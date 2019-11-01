//
//  YGConnectionController.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/6.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGConnectionController.h"

#import "MomentCell.h"
//#import "YGCommunityHeaderView.h"
#import "YGHomeygkCell.h"
#import "HomeModel.h"
//#import "YGCommunityCenterView.h"
//#import "YGServiceModel.h"
//#import "ConnectionCell.hd"
#import "CommentView.h"

@interface YGConnectionController ()<UITableViewDataSource,UITableViewDelegate,MomentCellDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UITextViewDelegate>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic, strong)NSMutableArray<Moment *> *infoArray;
@property(nonatomic, strong)NSMutableArray *infoArray2;
@property(nonatomic,assign) int page;
@property(nonatomic, copy)NSString *commentType;
//@property(nonatomic,strong) SpaceView *spaceView;
@property(nonatomic,strong) UICollectionView *ygkCollectionView;
@property(nonatomic,strong) NSMutableArray *ygkArray;
@property(nonatomic,strong) NSDictionary *dataDic;

@property(nonatomic,strong) CommentView *bottonView;
@property(nonatomic,assign) NSInteger sectionn;

@property(nonatomic,strong) NSString *commentOrReply;
@property(nonatomic,strong) NSString *ReplyName;
@property(nonatomic,strong) Comment *comment;
@property(nonatomic,copy) NSString *pasteBoardString;

@property(nonatomic,strong) JQFMDB *db;

@end

@implementation YGConnectionController

-(CommentView *)bottonView {
    
    if (!_bottonView) {
        _bottonView = [[CommentView alloc] initWithFrame:CGRectMake(0, __kHeight - LGF_Tabbar_Height  - 120*_Scaling, __kWidth, 60*_Scaling)];
        _bottonView.textView.delegate = self;
        _bottonView.userInteractionEnabled = YES;
        _bottonView.likeBtn.hidden = YES;
        _bottonView.shareBtn.hidden = YES;
    }
    return _bottonView;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _ygkArray = [NSMutableArray array];
    _page = 0;
    
    _db = [JQFMDB shareDatabase];
    [self createTableView];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh2) name:@"refresh2" object:nil];

    
    //缓存model
    NSArray *dataArray = [self.db jq_lookupTable:@"YG_need_list" dicOrModel:[YGJsonModel class] whereFormat:nil];
    for (YGJsonModel *model in dataArray) {

        NSData *data = [model.jsonDetails dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.dataDic = dataDic;
        [self createDataDic];
    }

    [self prepareRefresh];

    __weak typeof(self) weakSelf = self;
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page = weakSelf.page + 1;
        [weakSelf requestData];
    }];
//    [self.view addSubview:self.bottonView];

}

-(void) refresh2 {
    
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
    NSLog(@"%@",[UserInfo sharedUserInfo].siteID);
    MJRefreshGifHeader *gifHeader = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //下拉刷新要做的操作.
        weakSelf.page = 0;
        
        [weakSelf requestData];
    }];
    if ([self.dataDic allKeys] == 0) {
        [gifHeader beginRefreshing];
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
    
    NSDictionary *parameters = @{@"pageNumber":[NSString stringWithFormat:@"%d",_page],@"pageSize":@"10",@"attentionType":@"0",@"publishType":@"need"};
    
    [YGHttpRequest GETDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/findDynamic"] Parameters:parameters callback:^(id obj) {
        NSLog(@"%@",obj);
        NSDictionary *dic = [NSDictionary changeType:obj];
        BOOL istrue   = [dic[@"success"] boolValue];
        if (istrue) {
            
            if ([dic[@"data"][@"topicList"] count] > 0) {
                
                weakSelf.dataDic = @{};
                weakSelf.dataDic = obj[@"data"];
                [weakSelf createDataDic];
                if ([weakSelf.dataDic[@"topicList"] count] == 0) {
                    [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                }

                if (self->_page == 0) {
                    
                    [weakSelf.db jq_deleteAllDataFromTable:@"YG_need_list"];
                    YGJsonModel *model2 = [[YGJsonModel alloc] init];
                    NSError *err = nil;
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic[@"data"] options:NSJSONWritingPrettyPrinted error:&err];
                    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    model2.jsonDetails = jsonStr;
                    
                    [weakSelf.db jq_insertTable:@"YG_need_list" dicOrModel:model2];
                }
                
            }else {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                
                if (weakSelf.infoArray.count > 0) {
//                    weakSelf.spaceView.hidden = YES;
                }else {
//                    weakSelf.spaceView.hidden = NO;
                }
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
    [self.ygkArray removeAllObjects];


    NSDictionary *dic = @{@"groupCharIcon":@"http://files.likspace.cn/f93522a7-8489-42a6-9efa-6d4d12fa4f99.jpg",
                              @"groupCharTitle":@"资讯小组群",
                          @"groupCharContent":@"王丽：欢迎新同事的加入"
                          };
    
    
    Moment *momet = [[Moment alloc] initWithDic:dic];
    [self.infoArray addObject:momet];
    
    NSDictionary *dic1 = @{@"groupCharIcon":@"http://files.likspace.cn/f93522a7-8489-42a6-9efa-6d4d12fa4f99.jpg",
                          @"groupCharTitle":@"订个小目标&挣他一个亿",
                          @"groupCharContent":@"群主:最新项目云谷客3.0正式启动!"
                          };
    
    
    Moment *momet1 = [[Moment alloc] initWithDic:dic1];
    [self.infoArray addObject:momet1];
    
    
//    for (NSDictionary *dic in self.dataDic[@"topicList"]) {
//
//        Moment *momet = [[Moment alloc] initWithDic:dic];
//        [self.infoArray addObject:momet];
//        [self.infoArray2 addObject:dic];
//    }
    
    for (NSDictionary *dic in self.dataDic[@"ygk"][@"ygk"]) {
        
        HomeModel *momet = [[HomeModel alloc] initWithDic:dic];
        [self.ygkArray addObject:momet];
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
    
    
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [self.infoArray count];
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"MomentCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor whiteColor];
    }
    if (self.infoArray.count > 0) {
        
       Moment *moment = [self.infoArray objectAtIndex:indexPath.section];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:moment.groupCharIcon] placeholderImage:[UIImage imageNamed:@"chat 2"]];
         cell.textLabel.text = moment.groupCharTitle;
        
        cell.imageView.layer.cornerRadius = 5;
        cell.imageView.layer.masksToBounds = YES;
        
        
        cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
        cell.detailTextLabel.text = moment.groupCharContent;
        [cell.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_equalTo(68*_Scaling);
        }];
        [cell.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(48*_Scaling);
            make.left.mas_equalTo(GAP);
            
        }];
        [cell.detailTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(cell.imageView);
            make.left.mas_equalTo(cell.textLabel);
        }];
        
        
    }

//    cell.startBtn.hidden = YES;
//    cell.delegate = self;
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 使用缓存行高，避免计算多次
//    Moment *moment = [self.infoArray objectAtIndex:indexPath.section];
    return 50*_Scaling;
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    
    if (section == self.infoArray.count - 1) {
        return 10*_Scaling;
    }else{
          return 0.01*_Scaling;
    }
}

-(UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    return lineView;
}


-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 50*_Scaling;
    }else {
        return 15*_Scaling;
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.bottonView.textView resignFirstResponder];
    
    Moment *model = self.infoArray[indexPath.section];
//    YGCommunityDetailController *controller = [[YGCommunityDetailController alloc] init];
//    controller.topicId = model.topicId;
//    controller.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:controller animated:YES];
    
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {

        UIView *view = [[UIView alloc] init];
        view.backgroundColor = appBgRGBColor;
        UIButton *addNewGroupBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addNewGroupBtn setImage:[UIImage imageNamed:@"chat 加号"] forState:UIControlStateNormal];
        [addNewGroupBtn setTitle:@"创建新群聊" forState:UIControlStateNormal];
        [addNewGroupBtn setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateNormal];
        [view addSubview:addNewGroupBtn];
        addNewGroupBtn.titleLabel.font = [UIFont systemFontOfSize:14*_Scaling];
        [addNewGroupBtn addTarget:self action:@selector(addNewGroupChat:) forControlEvents:   UIControlEventTouchUpInside];
        
        [addNewGroupBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.right.mas_equalTo(-GAP);
                        make.top.mas_offset(5*_Scaling);
            
                        make.height.mas_offset(20*_Scaling);
                    }];
        
        
         UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        [view addSubview:lineView];
        [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_offset(40*_Scaling);
            
            make.height.mas_offset(10*_Scaling);
        }];
        
        return view;
        
    }else{
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        return view;
    }
    
}
//event
-(void)addNewGroupChat:(UIButton *)btn{
    NSLog(@"addNewGroupChat");
}

// 删除
//- (void)didDyDeleteMoment:(ConnectionCell *)cell {
//
//
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"确定删除该动态吗？" preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//    }]];
//
//    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//
//        Moment *moment = self.infoArray[indexPath.section];
//        NSDictionary *dic = @{@"id":moment.topicId};
//        [YGHttpRequest GETDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/delDnamic"] Parameters:dic callback:^(id obj) {
//            NSLog(@"%@",obj);
//            BOOL istrue   = [obj[@"success"] boolValue];
//            if (istrue) {
//                [MBProgressHUD showSuccess:obj[@"msg"]];
//
//                [self.infoArray removeObjectAtIndex:indexPath.section];
//                if (self.infoArray.count > 0) {
//                    cell.moment = [self.infoArray objectAtIndex:indexPath.section];
//                }
//                [self.tableView reloadData];
//
//            }else {
//                [MBProgressHUD showError:obj[@"msg"]];
//            }
//        }];
//
//    }]];
//
//    [self presentViewController:alert animated:YES completion:nil];
//}

// 点击用户头像
//- (void)didClickProfile:(ConnectionCell *)cell {
//    
////    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
////    Moment *momet = self.infoArray[indexPath.section];
////    YGUserDyController *controller = [[YGUserDyController alloc] init];
////    controller.hidesBottomBarWhenPushed = YES;
////    controller.membersId = momet.memberId;
////    [self.navigationController pushViewController:controller animated:YES];
////
//}

// 评论
//- (void)didDyAddComment:(ConnectionCell *)cell {
//    NSLog(@"评论");
//    self.commentOrReply = @"0";
//    self.bottonView.placLabel.text = @"";
//
//    [self.bottonView.textView becomeFirstResponder];
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    self.sectionn = indexPath.section;
//
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//}
// 私信
//- (void)didImMoment:(ConnectionCell *)cell{
//    NSLog(@"私信");
//
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
//
//}

// 解决
//- (void)didstartComment:(ConnectionCell *)cell {
//
//    NSLog(@"编辑");
//
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    Moment *momet = self.infoArray[indexPath.section];
//    if ([momet.memberId isEqualToString:[UserInfo sharedUserInfo].userDic[@"id"]]) {
//
//        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"该需求是否已解决？" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
//
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
//
//            NSDictionary *dic = @{@"id":momet.topicId};
//            [YGHttpRequest GETDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/updateSolve"] Parameters:dic callback:^(id obj) {
//                NSLog(@"%@",obj);
//                NSDictionary *dic = [NSDictionary changeType:obj];
//
//                BOOL istrue   = [dic[@"success"] boolValue];
//
//                if (istrue) {
//                    [MBProgressHUD showSuccess:obj[@"msg"]];
//
//                    MomentCell *cell = (MomentCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//
//                    Moment *momet = [[Moment alloc] initWithDic:dic[@"data"]];
//                    [self.infoArray replaceObjectAtIndex:indexPath.section withObject:momet];
//                    cell.moment = [self.infoArray objectAtIndex:indexPath.section];
//                    __weak typeof(self) weakSelf = self;
//                    [UIView performWithoutAnimation:^{
//                        [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//
//                        [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
//                    }];
//
//                }
//
//            }];
//        }];
//
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//
//        }];
//
//        [controller addAction:okAction];
//        [controller addAction:cancelAction];
//
//        [self presentViewController:controller animated:YES completion:nil];
//    }
//}


#pragma mark -- 回复评论

//- (void)didSelectComment:(Comment *)comment ConnectionCell:(ConnectionCell *)cell {
//
//    NSLog(@"点击了评论%@",comment.commentUser);
//    if ([comment.usersId isEqualToString:[UserInfo sharedUserInfo].userDic[@"id"]]) {
//
//        Moment *moment = self.infoArray[self.sectionn];
//
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"确定删除这条评论吗？" preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//            NSDictionary *dic = @{@"topicId":moment.topicId,@"id":comment.userId};
//            [YGHttpRequest GETDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/delComment"] Parameters:dic callback:^(id obj) {
//                NSLog(@"%@",obj);
//                NSDictionary *dic = [NSDictionary changeType:obj];
//
//                [MBProgressHUD showSuccess:obj[@"msg"]];
//
//                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.sectionn];
//                MomentCell *cell = (MomentCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//
//                Moment *momet = [[Moment alloc] initWithDic:dic[@"data"]];
//                [self.infoArray replaceObjectAtIndex:self.sectionn withObject:momet];
//                cell.moment = [self.infoArray objectAtIndex:indexPath.section];
//                __weak typeof(self) weakSelf = self;
//                [UIView performWithoutAnimation:^{
//                    [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//
//                    [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
//                }];
//
//            }];
//
//
//        }]];
//        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//        }]];
//        [self presentViewController:alert animated:YES completion:nil];
//
//
//    }else {
//
//    self.commentOrReply = @"1";
//    _comment = comment;
//    [self.bottonView.textView becomeFirstResponder];
//    self.bottonView.placLabel.text = [NSString stringWithFormat:@"回复%@:",comment.memberName];
//    self.ReplyName = self.bottonView.placLabel.text;
//    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
//    self.sectionn = indexPath.section;
//
//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
//
//    }
//}




#pragma mark 键盘出现
-(void)keyboardWillShow:(NSNotification *)note
{
    
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.bottonView.frame = CGRectMake(0, __kHeight  - LGF_Tabbar_Height - 132*_Scaling -keyBoardRect.size.height , __kWidth, 60*_Scaling);
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyBoardRect.size.height, 0);
    
}

#pragma mark 键盘消失
-(void)keyboardWillHide:(NSNotification *)note
{
    self.tableView.contentInset = UIEdgeInsetsZero;
    self.bottonView.frame = CGRectMake(0, __kHeight - LGF_Tabbar_Height - 120*_Scaling, __kWidth, 60*_Scaling);
    self.tableView.contentInset = UIEdgeInsetsZero;
}



//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
//        //在这里做你响应return键的代码
//        [textView resignFirstResponder];
//
//        if (textView.text.length != 0) {
//
//            if ([self.commentOrReply isEqualToString:@"0"]) {//评论
//
//                Moment *moment = self.infoArray[self.sectionn];
//
//                NSDictionary *dic = @{@"topicId":moment.topicId,@"content":textView.text};
//                [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/addComment"] Parameters:dic callback:^(id obj) {
//                    NSLog(@"%@",obj);
//                    BOOL istrue   = [obj[@"success"] boolValue];
//                    if (istrue) {
//
//                        [MBProgressHUD showSuccess:obj[@"msg"]];
//
//                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.sectionn];
//
//                        ConnectionCell *cell = (ConnectionCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//
//                        Moment *momet = [[Moment alloc] initWithDic:obj[@"data"]];
//                        [self.infoArray replaceObjectAtIndex:self.sectionn withObject:momet];
//                        cell.moment = [self.infoArray objectAtIndex:indexPath.section];
//                        __weak typeof(self) weakSelf = self;
//
//                        [UIView performWithoutAnimation:^{
//                            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//
//                            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
//
//                            textView.text = @"";
//                        }];
//                    }
//                }];
//
//            }else {
//
//                Moment *moment = self.infoArray[self.sectionn];
//                NSDictionary *dic = @{@"memberIds":_comment.memberId,@"topicId":moment.topicId,@"content":textView.text};
//
//                [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"community/addCommentComment"] Parameters:dic callback:^(id obj) {
//                    BOOL istrue   = [obj[@"success"] boolValue];
//                    if (istrue) {
//
//                        [MBProgressHUD showSuccess:obj[@"msg"]];
//                        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.sectionn];
//                        ConnectionCell *cell = (ConnectionCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//                        Moment *momet = [[Moment alloc] initWithDic:obj[@"data"]];
//                        [self.infoArray replaceObjectAtIndex:self.sectionn withObject:momet];
//                        cell.moment = [self.infoArray objectAtIndex:indexPath.section];
//                        __weak typeof(self) weakSelf = self;
//                        [UIView performWithoutAnimation:^{
//                            [weakSelf.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
//
//                            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
//                            textView.text = @"";
//                        }];
//                    }
//                }];
//            }
//        }
//        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
//    }
//
//    return YES;
//}


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


// 使label能够成为响应事件，为了能接收到事件（能成为第一响应者）
- (BOOL)canBecomeFirstResponder{
    return YES;
}
// 可以控制响应的方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
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
