//
//  YGdynamicController.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/6.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGdynamicController.h"
#import "MomentCell.h"
//#import "YGCommunityHeaderView.h"
#import "YGHomeygkCell.h"
#import "HomeModel.h"
//#import "YGCommunityCenterView.h"
//#import "YGServiceModel.h"
//#import "YGCommunityDetailController.h"
#import "CommentView.h"
#import "YGHomeLoopPlaybackView.h"
@interface YGdynamicController ()<UITableViewDataSource,UITableViewDelegate,MomentCellDelegate,UICollectionViewDataSource,UICollectionViewDelegate,RCIMUserInfoDataSource,UITextViewDelegate,ygkCellDelegate,UIScrollViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic, strong)NSMutableArray<Moment *> *infoArray;
@property(nonatomic, strong)NSMutableArray *infoArray2;
@property(nonatomic,assign) int page;
@property(nonatomic, copy)NSString *commentType;
//@property(nonatomic,strong) SpaceView *spaceView;
@property(nonatomic,strong) UICollectionView *ygkCollectionView;
@property(nonatomic,strong) NSMutableArray *ygkArray;
@property(nonatomic,strong) NSMutableArray *ygkArray2;

@property(nonatomic,strong) NSDictionary *dataDic;

@property(nonatomic,strong) CommentView *bottonView;
@property(nonatomic,assign) NSInteger sectionn;

@property(nonatomic,strong) NSString *commentOrReply;
@property(nonatomic,strong) NSString *ReplyName;
@property(nonatomic,strong) Comment *comment;

@property(nonatomic,copy) NSString *topicType;

@property(nonatomic,copy) NSString *pasteBoardString;
@property(nonatomic,copy) MLLinkLabel *mkLabel;

@property(nonatomic,strong) JQFMDB *db;

//轮播图
@property(nonatomic,strong) NSMutableArray *imageArray2;
@property(nonatomic,strong) YGHomeLoopPlaybackView *cycleScrollView2;
@end

@implementation YGdynamicController

-(CommentView *)bottonView {
    
    if (!_bottonView) {
        _bottonView = [[CommentView alloc] initWithFrame:CGRectMake(0, __kHeight - LGF_Tabbar_Height  - 120*_Scaling, __kWidth, 60*_Scaling)];
        _bottonView.textView.delegate = self;
        _bottonView.userInteractionEnabled = YES;
        //        [_bottonView.likeBtn addTarget:self action:@selector(likeBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        _bottonView.likeBtn.hidden = YES;
        _bottonView.shareBtn.hidden = YES;
    }
    return _bottonView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ygkArray = [NSMutableArray array];
    _ygkArray2 = [NSMutableArray array];
    _db = [JQFMDB shareDatabase];
    self.topicType = @"1";
    
    [self createTableView];
    _page = 0;
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"refresh" object:nil];
    
    NSArray *dataArray = [self.db jq_lookupTable:@"YG_dynamic_list" dicOrModel:[YGJsonModel class] whereFormat:nil];
    
    
    for (YGJsonModel *model in dataArray) {
        
        NSData *data = [model.jsonDetails dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        //保存数据了
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"@st%@",str);
        self.dataDic = dataDic;
        [self createDataDic];
    }
    [self prepareRefresh];
    
    __weak typeof(self) weakSelf = self;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page = weakSelf.page + 1;
        [weakSelf requestData];
    }];
    [self.view addSubview:self.bottonView];
    //fixbug
    
}


-(void) refresh {
    
    [self prepareRefresh];
}

//-(SpaceView *)spaceView {
//
//    if (!_spaceView) {
//        _spaceView = [[SpaceView alloc] initWithFrame:CGRectMake(0, 0*_Scaling, __kWidth, __kHeight -44*_Scaling)];
//        _spaceView.bgView.image = [UIImage imageNamed:@"发现空白"];
//    }
//    return _spaceView;
//}

- (void)prepareRefresh

{
    __weak typeof(self) weakSelf = self;
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //下拉刷新要做的操作.
        weakSelf.page = 0;
        [weakSelf requestData];
    }];
    
    if ([self.dataDic allKeys] == 0) {
        [gifHeader beginRefreshing];
    }else {
        [self requestData];
    }
    self.tableView.mj_header = gifHeader;
}

-(NSMutableArray *)infoArray {
    if (!_infoArray) {
        _infoArray = [NSMutableArray new];
    }
    return _infoArray;
}

-(NSMutableArray *)infoArray2 {
    if (!_infoArray2) {
        _infoArray2 = [NSMutableArray new];
        
    }
    return _infoArray2;
}
-(void) requestData {
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *parameters = @{@"pageNumber":[NSString stringWithFormat:@"%d",_page],@"pageSize":@"10",@"attentionType":self.topicType,@"publishType":@"dynamic"};
    
    [YGHttpRequest GETDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/findDynamic"] Parameters:parameters callback:^(id obj) {
        
        [MBProgressHUD hideGifHUDForView:self.view];
        NSDictionary *dic = [NSDictionary changeType:obj];
        BOOL istrue   = [dic[@"success"] boolValue];
        if (istrue) {
            [weakSelf.ygkArray removeAllObjects];
            [weakSelf.ygkArray2 removeAllObjects];
            
            if (weakSelf.page == 0) {
                [weakSelf.infoArray removeAllObjects];
                [weakSelf.infoArray2 removeAllObjects];
            }
            weakSelf.dataDic = @{};
            weakSelf.dataDic = obj[@"data"];
            
            [weakSelf createDataDic];
            
            if ([weakSelf.dataDic[@"topicList"] count] == 0) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            if (self->_page == 0 && [weakSelf.topicType isEqualToString:@"1"]) {
                
                [weakSelf.db jq_deleteAllDataFromTable:@"YG_dynamic_list"];
                YGJsonModel *model2 = [[YGJsonModel alloc] init];
                NSError *err = nil;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic[@"data"] options:NSJSONWritingPrettyPrinted error:&err];
                NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                model2.jsonDetails = jsonStr;
                
                [weakSelf.db jq_insertTable:@"YG_dynamic_list" dicOrModel:model2];
            }
            
        }
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    }];
    
}

-(void) createDataDic {
    
    if (self.page == 0) {
        
        [self.infoArray removeAllObjects];
        [self.infoArray2 removeAllObjects];
    }
    int i = arc4random() % 100 ;
    NSNumber *count =[NSNumber numberWithInt:i];
    int i2 = arc4random() % 100 ;
    NSNumber *count2 =[NSNumber numberWithInt:i2];
    NSDictionary *dict = @{
                           @"id" : @"8a8082b66cde5301016ce023a9990000",
                           @"isLike" : @true,
                           
                           @"isAttention" : @false,
                           @"imgs" :@[
                                   @"https:\/\/files.likspace.cn\/3fdcf5ae-b159-477a-be53-5c1471f39417.jpg",
                                   @"https:\/\/files.likspace.cn\/3fdcf5ae-b159-477a-be53-5c1471f39417.jpg"
                                   ],
                           @"isSolve" : @false,
                           @"isVip" : @"",
                           @"headportrait" : @"https:\/\/files.likspace.cn\/a9c9c96f-2037-488f-838e-9d27c362d7e1.jpg",
                           @"likes" : count,
                           @"countComment" : @60,
                           @"likes" : @80,
                           @"countZhuanfa" : count2,
                           @"name" : @"张然",
                           @"content" : @"早上好,特币价格破9700美元业内区链警示线将发财了呀"
                           };
    Moment *momet = [[Moment alloc] initWithDic:dict];
    [self.infoArray addObject:momet];
    [self.infoArray2 addObject:dict];
    for (NSDictionary *dic in self.dataDic[@"topicList"]) {
        Moment *momet = [[Moment alloc] initWithDic:dic];
        
        [self.infoArray addObject:momet];
        [self.infoArray2 addObject:dic];
    }
    
    [self.ygkArray removeAllObjects];
    
    if ([self.dataDic[@"members"] count] > 0) {
        
        for (NSDictionary *dic in self.dataDic[@"members"]) {
            
            HomeModel *momet = [[HomeModel alloc] initWithDic:dic];
            [self.ygkArray addObject:momet];
            [self.ygkArray2 addObject:dic];
        }
        [self.ygkCollectionView reloadData];
    }
    
    //    self.spaceView.hidden = YES;
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
    
}



-(void) createTableView {
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0*_Scaling, __kWidth, __kHeight -160*_Scaling-LGF_Tabbar_Height ) style:(UITableViewStyleGrouped)];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = appBgRGBColor;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.estimatedRowHeight = 0;
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = appBgRGBColor;
    [self.view addSubview:_tableView];
    //    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
    //        make.left.right.top.mas_equalTo(self.view);
    //        make.height.mas_equalTo(self.view.height-LGF_Tabbar_Height);
    //    }];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 2"] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"发表文章" forState:UIControlStateNormal];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-44*_Scaling);
    }];
    [btn addTarget:self action:@selector(postNewNews:) forControlEvents:UIControlEventTouchUpInside];
}
//event
-(void)postNewNews:(UIButton *)btn{
    NSLog(@"postNewNews");
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (self.infoArray.count > 0) {
        return [self.infoArray count];
    }else {
        return 1;
    }
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.infoArray.count > 0) {
        return 1;
    }else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MomentCell";
    MomentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[MomentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.backgroundColor = [UIColor whiteColor];
    }
    if (self.infoArray.count > 0) {
        cell.moment = [self.infoArray objectAtIndex:indexPath.section];
    }
    cell.startBtn.hidden = YES;
    cell.delegate = self;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 使用缓存行高，避免计算多次
    Moment *moment = [self.infoArray objectAtIndex:indexPath.section];
    return moment.rowHeight;
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01*_Scaling;
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    //    if (section == 0) {
    //        static NSString *cellID = @"headerView3";
    //        YGCommunityCenterView *view = [_tableView dequeueReusableHeaderFooterViewWithIdentifier:cellID];
    //        if (!view) {
    //            view = [[YGCommunityCenterView alloc] initWithReuseIdentifier:cellID];
    //        }
    //        [view addSubview:self.ygkCollectionView];
    //        return view;
    //    }else {
    //        UIView *view = [[UIView alloc] init];
    //        view.backgroundColor = [UIColor redColor];
    //        return view;
    //    }
    UIView *view = [[UIView alloc] init];
    //    view.backgroundColor = [UIColor redColor];
    return view;
}


-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 255*_Scaling;
    }else {
        return 5*_Scaling;
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        UIView *hotTopicView = [[UIView alloc] init];
        hotTopicView.backgroundColor = [UIColor whiteColor];
        
        UILabel *hotTopicViewlable = [[UILabel alloc] init];
        hotTopicViewlable.textColor = [UIColor blackColor];
        hotTopicViewlable.text  = @"热门话题";
        [hotTopicViewlable setFont: [UIFont fontWithName:@"Arial-BoldMT" size:16*_Scaling]];
        [hotTopicView addSubview:hotTopicViewlable];
        

        
        
        UILabel *hotTopicViewBtn = [[UILabel alloc] init];;
        hotTopicViewBtn.textColor = [UIColor colorWithHexString:@"#666666"];
        hotTopicViewBtn.text  = @"1 /3";
        [hotTopicViewBtn setFont:[UIFont systemFontOfSize:12]];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:hotTopicViewBtn.text];
        [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16*_Scaling] range:NSMakeRange(0, 1 )];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#333333"] range:NSMakeRange(0, 1 )];
        hotTopicViewBtn.attributedText = str;
        
        
        //[hotTopicViewBtn addTarget:self action:@selector(hotTopicViewBtnMore:) forControlEvents:UIControlEventTouchUpInside];
        
        [hotTopicView addSubview:hotTopicViewBtn];
        
        
        
        
        
        NSArray *array2 =@[@"https://www.baidu.com/s?tn=84053098_3_dg&wd=ios&ie=utf-8&rsv_cq=NavigationBar+hidden&rsv_dl=0_right_recommends_merge_28335&euri=8747673", @"https://www.baidu.com/s?tn=84053098_3_dg&wd=ios&ie=utf-8&rsv_cq=NavigationBar+hidden&rsv_dl=0_right_recommends_merge_28335&euri=8747673"];
        self.imageArray2 = [NSMutableArray arrayWithArray:array2] ;
        
        
        self.cycleScrollView2 = [[YGHomeLoopPlaybackView alloc] initWithFrame:CGRectMake(0, 15*_Scaling, __kWidth, 150*_Scaling) imageGroups:self.imageArray2 withPlaceHoderl:[UIImage imageNamed:@"lunbo"]];
        self.cycleScrollView2.pageControl.hidden =YES;
        self.cycleScrollView2.delegate = self;
        
        
        [hotTopicView addSubview:self.cycleScrollView2];
        
        
        [hotTopicViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(GAP);
            make.right.mas_equalTo(-GAP);
            make.height.mas_equalTo(16*_Scaling);
            
        }];
        [hotTopicViewlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(GAP);
            make.height.mas_equalTo(16*_Scaling);
            
        }];
        [self.cycleScrollView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(49*_Scaling);
            make.right.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(142*_Scaling);
            
        }];
        //推荐文章
        UIView *hotTopicBottomView = [[UIView alloc] init];
        hotTopicBottomView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
        [hotTopicView addSubview:hotTopicBottomView];
        
        UILabel *hotTopicottomViewlable = [[UILabel alloc] init];
        hotTopicottomViewlable.textColor = [UIColor blackColor];
        hotTopicottomViewlable.text  = @"推荐文章";
        [hotTopicottomViewlable setFont: [UIFont fontWithName:@"Arial-BoldMT" size:16*_Scaling]];
        [hotTopicBottomView addSubview:hotTopicottomViewlable];
        
        UIButton *hotTopicBottomViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [hotTopicBottomViewBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [hotTopicBottomViewBtn  setImage:[UIImage imageNamed:@"图层 15"] forState:UIControlStateNormal];
        [hotTopicBottomViewBtn setTitle:@"全部文章" forState:UIControlStateNormal];
        [hotTopicBottomViewBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [hotTopicBottomViewBtn addTarget:self action:@selector(hotTopicBottomViewBtn:) forControlEvents:UIControlEventTouchUpInside];
        [hotTopicBottomViewBtn xbs_updateImageAlignmentToRightWithSpace:2];
        
        [hotTopicBottomView addSubview:hotTopicBottomViewBtn];
        //layout
        [hotTopicBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(209*_Scaling);
            make.height.mas_equalTo(46*_Scaling);
        }];
        [hotTopicottomViewlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(GAP);
            make.top.mas_equalTo(15*_Scaling);
            make.height.mas_equalTo(16*_Scaling);
            make.centerY.mas_equalTo(hotTopicBottomView);
        }];
        [hotTopicBottomViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-GAP);
            make.top.mas_equalTo(15*_Scaling);
            
            make.centerY.mas_equalTo(hotTopicBottomView);
        }];
        return hotTopicView;
        
    }else {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = appBgRGBColor;
        return view;
    }
}
//event
-(void)hotTopicBottomViewBtn:(UIButton *)btn{
    NSLog(@"hotTopicBottomViewBtn");
}

-(void)allBtnAction:(UIButton *) sender {
    
    sender.selected = !sender.selected;
    UIView *view = [sender.superview.superview viewWithTag:4003];
    UIButton *follBtn = [view viewWithTag:4005];
    
    if (sender.selected) {
        view.hidden = NO;
    }else {
        view.hidden = YES;
    }
    if (follBtn.selected) {
        [sender setTitle:@"全部动态" forState:(UIControlStateNormal)];
        [follBtn setTitle:@"我的关注" forState:(UIControlStateNormal)];
    }else {
        
        [sender setTitle:@"我的关注" forState:(UIControlStateNormal)];
        [follBtn setTitle:@"全部动态" forState:(UIControlStateNormal)];
    }
    
}

-(void)myFollowBtnAction:(UIButton *) sender {
    sender.selected = !sender.selected;
    
    UIButton *btn = [sender.superview.superview viewWithTag:4004];
    btn.selected = NO;
    
    UIView *view = [sender.superview.superview viewWithTag:4003];
    view.hidden = YES;
    
    [MBProgressHUD showGifToView:self.view];
    if (sender.selected) {
        
        self.topicType = @"0";
        
        [btn setTitle:@"全部动态" forState:(UIControlStateNormal)];
        [sender setTitle:@"我的关注" forState:(UIControlStateNormal)];
    }else {
        self.topicType = @"1";
        [btn setTitle:@"我的关注" forState:(UIControlStateNormal)];
        [sender setTitle:@"全部动态" forState:(UIControlStateNormal)];
        
    }
    self.page = 0;
    [self requestData];
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.bottonView.textView resignFirstResponder];
    
    //    Moment *model = self.infoArray[indexPath.section];
    //    YGCommunityDetailController *controller = [[YGCommunityDetailController alloc] init];
    //    controller.topicId = model.topicId;
    //    controller.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:controller animated:YES];
}


-(UICollectionView *)ygkCollectionView {
    
    if (!_ygkCollectionView) {
        
        CGRect collectionViewFrame= CGRectMake(0, 66*_Scaling, [UIScreen mainScreen].bounds.size.width, 132*_Scaling);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 设置UICollectionView为横向滚动
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 设置第一个cell和最后一个cell,与父控件之间的间距
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        flowLayout.minimumLineSpacing = .1;// 根据需要编写
        flowLayout.minimumInteritemSpacing = .1;// 根据需要编写
        flowLayout.itemSize = CGSizeMake(112*_Scaling, 132*_Scaling);// 该行代码就算不写,item也会有默认尺寸
        _ygkCollectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:flowLayout];
        _ygkCollectionView.dataSource = self;
        _ygkCollectionView.delegate = self;
        _ygkCollectionView.showsVerticalScrollIndicator = NO;
        _ygkCollectionView.showsHorizontalScrollIndicator = NO;
        _ygkCollectionView.backgroundColor = appBgRGBColor;
        [_ygkCollectionView registerClass:[YGHomeygkCell class] forCellWithReuseIdentifier:@"collectionCell3"];
        
    }
    return _ygkCollectionView;
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.ygkArray.count;
}

//定义每个Section的四边间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 5);//分别为上、左、下、右
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0.1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout*)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5*_Scaling;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YGHomeygkCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell3" forIndexPath:indexPath];
    
    if (self.ygkArray.count > 0) {
        cell.model = self.ygkArray[indexPath.row];
    }
    cell.delegate = self;
    
    return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //    HomeModel *model = self.ygkArray[indexPath.row];
    //    YGUserDyController *controller = [[YGUserDyController alloc] init];
    //    controller.hidesBottomBarWhenPushed = YES;
    //    controller.membersId = model.userID;
    //    [self.navigationController pushViewController:controller animated:YES];
    
}
#pragma mark -- 云谷客关注
- (void)ygkFollowMoment:(YGHomeygkCell *)cell {
    
    NSIndexPath *indexPath = [self.ygkCollectionView indexPathForCell:cell];
    HomeModel *model = self.ygkArray[indexPath.row];
    
    NSString *followType;
    if (model.isAttention == YES) {
        followType = @"1";
    }else {
        followType = @"0";
    }
    
    NSDictionary *dic = @{@"attenTionType":@"MEMBER",@"objectId":model.userID,@"type":followType};
    [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/addAttention"] Parameters:dic callback:^(id obj) {
        NSLog(@"%@",obj);
        BOOL istrue   = [obj[@"success"] boolValue];
        if (istrue) {
            
            NSMutableDictionary *dd = [NSMutableDictionary dictionary];
            [dd setDictionary:self.ygkArray2[indexPath.row]];
            
            if (model.isAttention == YES) {
                [dd setValue:[NSNumber numberWithBool:false] forKey:@"isAttention"];
            }else {
                [dd setValue:[NSNumber numberWithBool:true] forKey:@"isAttention"];
            }
            
            HomeModel *model3 = [[HomeModel alloc] initWithDic:dd];
            [self.ygkArray replaceObjectAtIndex:indexPath.row withObject:model3];
            cell.model = [self.ygkArray objectAtIndex:indexPath.row];
            
            __weak typeof(self) weakSelf = self;
            [self requestData];
        }
    }];
    
}

// 点击用户头像
- (void)didClickProfile:(MomentCell *)cell {
    
    //    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //    Moment *momet = self.infoArray[indexPath.section];
    //    YGUserDyController *controller = [[YGUserDyController alloc] init];
    //    controller.hidesBottomBarWhenPushed = YES;
    //    controller.membersId = momet.memberId;
    //    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark -- 私信
- (void)didImMoment:(MomentCell *)cell {
    NSLog(@"zhuanfa .. didImMoment ")
    
    //    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    //    Moment *momet = self.infoArray[indexPath.section];
    //
    //    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",momet.img] forKey:[NSString stringWithFormat:@"%@img",momet.sourceId]];
    //    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",momet.name] forKey:[NSString stringWithFormat:@"%@name",momet.sourceId]];
    //
    //    RCConversationViewController *conversationVC = [[RCConversationViewController alloc]init];
    //    conversationVC.conversationType = ConversationType_PRIVATE;
    //    conversationVC.targetId = momet.sourceId;
    //    conversationVC.title = momet.name;
    //    conversationVC.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:conversationVC animated:YES];
    
}

// 删除
- (void)didDeleteMoment:(MomentCell *)cell {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定删除该动态吗？" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        
        Moment *moment = self.infoArray[indexPath.section];
        NSDictionary *dic = @{@"id":moment.topicId};
        [YGHttpRequest GETDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/delDnamic"] Parameters:dic callback:^(id obj) {
            NSLog(@"%@",obj);
            BOOL istrue   = [obj[@"success"] boolValue];
            if (istrue) {
                
                [MBProgressHUD showSuccess:obj[@"msg"]];
                [self.infoArray removeObjectAtIndex:indexPath.section];
                if (self.infoArray.count > 0) {
                    cell.moment = [self.infoArray objectAtIndex:indexPath.section];
                    [self.tableView reloadData];
                }else{
                    [self requestData];
                }
            }else {
                [MBProgressHUD showError:obj[@"msg"]];
            }
        }];
        
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}
#pragma mark -- 点赞
- (void)didLikeMoment:(MomentCell *)cell {
    
    NSLog(@"点赞 didLikeMoment");
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    Moment *moment = self.infoArray[indexPath.section];
    NSDictionary *dic = @{@"id":moment.topicId,@"type":moment.isLike == YES?@"1":@"0"};
    [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/addTopicLike"] Parameters:dic callback:^(id obj) {
        NSLog(@"%@",obj);
        BOOL istrue   = [obj[@"success"] boolValue];
        if (istrue) {
            
            Moment *momet = [[Moment alloc] initWithDic:obj[@"data"]];
            [self.infoArray replaceObjectAtIndex:indexPath.section withObject:momet];
            cell.moment = [self.infoArray objectAtIndex:indexPath.section];
            __weak typeof(self) weakSelf = self;
            [UIView performWithoutAnimation:^{
                [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
            }];
        }
    }];
}

#pragma mark -- 评论
- (void)didAddComment:(MomentCell *)cell{
    
    NSLog(@"评论, didAddComment  ");
    self.bottonView.placLabel.text = @"";
    
    self.commentOrReply = @"0";
    [self.bottonView.textView becomeFirstResponder];
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    self.sectionn = indexPath.section;
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    
}


#pragma mark -- 回复评论
- (void)didSelectComment:(Comment *)comment MomentCell:(MomentCell *)cell {
    
    if ([comment.memberId isEqualToString:[UserInfo sharedUserInfo].userDic[@"id"]]) {
        
        Moment *moment = self.infoArray[self.sectionn];
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定删除这条评论吗？" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            NSDictionary *dic = @{@"topicId":moment.topicId,@"id":comment.userId};
            [YGHttpRequest GETDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/delComment"] Parameters:dic callback:^(id obj) {
                NSLog(@"%@",obj);
                NSDictionary *dic = [NSDictionary changeType:obj];
                
                [MBProgressHUD showSuccess:obj[@"msg"]];
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.sectionn];
                MomentCell *cell = (MomentCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                
                Moment *momet = [[Moment alloc] initWithDic:dic[@"data"]];
                [self.infoArray replaceObjectAtIndex:self.sectionn withObject:momet];
                cell.moment = [self.infoArray objectAtIndex:indexPath.section];
                __weak typeof(self) weakSelf = self;
                [UIView performWithoutAnimation:^{
                    [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                    
                    [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
                }];
                
            }];
        }]];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
        
    }else {
        self.commentOrReply = @"1";
        
        _comment = comment;
        [self.bottonView.textView becomeFirstResponder];
        self.bottonView.placLabel.text = [NSString stringWithFormat:@"回复%@:",comment.memberName];
        self.ReplyName = self.bottonView.placLabel.text;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        self.sectionn = indexPath.section;
        
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
    
}

// 点击高亮文字
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText {
    
    
    // url链接的规则
    if ([[UserInfo urlValidation:linkText] length] > 0) {
        
        //        YGHtmlViewController *controller = [[YGHtmlViewController alloc] init];
        //        controller.hidesBottomBarWhenPushed = YES;
        //        controller.status = @"99";
        //        controller.url = linkText;
        //        [self.navigationController pushViewController:controller animated:YES];
    }
}



#pragma mark -- 关注
- (void)didfollowMoment:(MomentCell *)cell {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    Moment *moment = self.infoArray[indexPath.section];
    
    NSString *followType;
    if (moment.isAttention == YES) {
        followType = @"1";
    }else {
        followType = @"0";
    }
    NSDictionary *dic = @{@"attenTionType":@"MEMBER",@"objectId":moment.memberId,@"type":followType};
    
    [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/addAttention"] Parameters:dic callback:^(id obj) {
        NSLog(@"%@",obj);
        BOOL istrue   = [obj[@"success"] boolValue];
        if (istrue) {
            
            [MBProgressHUD showSuccess:obj[@"msg"]];
            for (int i = 0; i < self.infoArray2.count; i ++) {
                
                NSMutableDictionary *dd = [NSMutableDictionary dictionary];
                [dd setDictionary:self.infoArray2[i]];
                
                if ([moment.memberId isEqualToString:dd[@"memberId"]]) {//判断当前所有动态与点击的动态是同一个人发出的
                    
                    if (moment.isAttention == YES) {
                        [dd setValue:[NSNumber numberWithBool:false] forKey:@"isAttention"];
                    }else {
                        [dd setValue:[NSNumber numberWithBool:true] forKey:@"isAttention"];
                    }
                    
                    Moment *moment3 = [[Moment alloc] initWithDic:dd];
                    [self.infoArray replaceObjectAtIndex:i withObject:moment3];
                    cell.moment = [self.infoArray objectAtIndex:i];
                    
                    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:i];
                    
                    __weak typeof(self) weakSelf = self;
                    [UIView performWithoutAnimation:^{
                        /**
                         刷新指定section
                         */
                        [weakSelf.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                    }];
                }
            }
        }
    }];
}

#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
    
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottonView.frame = CGRectMake(0, __kHeight  - LGF_Tabbar_Height - 132*_Scaling -keyBoardRect.size.height , __kWidth, 60*_Scaling);
    [self.bottonView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(60*_Scaling);
        make.bottom.mas_equalTo(-keyBoardRect.size.height+80*_Scaling);
    }];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
    
}

#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.bottonView.frame = CGRectMake(0, __kHeight - LGF_Tabbar_Height - 120*_Scaling, __kWidth, 60*_Scaling);
    self.tableView.contentInset = UIEdgeInsetsZero;
    [self.bottonView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(60*_Scaling);
        make.bottom.mas_equalTo(120*_Scaling);
    }];
    
    
    
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        //在这里做你响应return键的代码
        [textView resignFirstResponder];
        
        if (textView.text.length != 0) {
            
            if ([self.commentOrReply isEqualToString:@"0"]) {//评论
                
                Moment *moment = self.infoArray[self.sectionn];
                
                NSDictionary *dic = @{@"topicId":moment.topicId,@"content":textView.text};
                [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/addComment"] Parameters:dic callback:^(id obj) {
                    NSLog(@"%@",obj);
                    BOOL istrue   = [obj[@"success"] boolValue];
                    if (istrue) {
                        
                        [MBProgressHUD showSuccess:obj[@"msg"]];
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.sectionn];
                        MomentCell *cell = (MomentCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                        Moment *momet = [[Moment alloc] initWithDic:obj[@"data"]];
                        [self.infoArray replaceObjectAtIndex:self.sectionn withObject:momet];
                        cell.moment = [self.infoArray objectAtIndex:indexPath.section];
                        __weak typeof(self) weakSelf = self;
                        [UIView performWithoutAnimation:^{
                            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                            
                            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
                            textView.text = @"";
                        }];
                    }
                }];
                
            }else {//回复
                
                Moment *moment = self.infoArray[self.sectionn];
                NSDictionary *dic = @{@"memberIds":_comment.memberId,@"topicId":moment.topicId,@"content":textView.text};
                
                [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/addCommentComment"] Parameters:dic callback:^(id obj) {
                    NSLog(@"%@",obj);
                    BOOL istrue   = [obj[@"success"] boolValue];
                    if (istrue) {
                        
                        [MBProgressHUD showSuccess:obj[@"msg"]];
                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.sectionn];
                        MomentCell *cell = (MomentCell *)[self.tableView cellForRowAtIndexPath:indexPath];
                        Moment *momet = [[Moment alloc] initWithDic:obj[@"data"]];
                        [self.infoArray replaceObjectAtIndex:self.sectionn withObject:momet];
                        cell.moment = [self.infoArray objectAtIndex:indexPath.section];
                        __weak typeof(self) weakSelf = self;
                        [UIView performWithoutAnimation:^{
                            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
                            
                            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
                            textView.text = @"";
                        }];
                    }
                }];
                
            }
        }
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    if (textView.text.length > 0) {
        self.bottonView.placLabel.text = @"";
    }else{
        if ([self.commentOrReply isEqualToString:@"1"]) {
            self.bottonView.placLabel.text = self.ReplyName;
        }
    }
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hiddenDyBgView" object:nil];
    
}


// 使label能够成为响应事件，为了能接收到事件（能成为第一响应者）
- (BOOL)canBecomeFirstResponder{
    return YES;
}
// 可以控制响应的方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    
    NSLog(@"%@",NSStringFromSelector(action));
    return (action == @selector(copy:));
}

//针对响应方法的实现，最主要的复制的两句代码
- (void)copy:(id)sender{
    
    //UIPasteboard：该类支持写入和读取数据，类似剪贴板
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.pasteBoardString;
    
    [MBProgressHUD showSuccess:@"复制成功"];
}
//长按内容2
- (void)didLabelLongPresslinkText:(NSString*)linkText linkLabel:(MLLinkLabel*)linkLabel {
    
    
    [self becomeFirstResponder]; // 用于UIMenuController显示，缺一不可
    NSLog(@"长按内容%@",linkLabel.text);
    //UIMenuController：可以通过这个类实现点击内容，或者长按内容时展示出复制等选择的项，每个选项都是一个UIMenuItem对象
    self.pasteBoardString = linkLabel.text;
    UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copy:)];
    
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
    [[UIMenuController sharedMenuController] setTargetRect:linkLabel.frame inView:linkLabel.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}


@end

