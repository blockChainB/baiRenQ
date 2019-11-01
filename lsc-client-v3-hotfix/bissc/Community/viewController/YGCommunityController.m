//
//  YGCommunityController.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/6.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGCommunityController.h"
#import "YGdynamicController.h"
#import "YGConnectionController.h"
#import "YGCooperationController.h"
//#import "YGMessageViewController.h"
#import "BaseNavigationController.h"
//#import "YGPostCommunityView.h"
#import "YGPostContentController.h"
//#import "YGPostView.h"
//#import "YGAccessViewController.h"
//#import "YGScanViewController.h"
#import <RongIMKit/RongIMKit.h>
//#import "YGBadgeButton.h"
@interface YGCommunityController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate,UIScrollViewDelegate,RCIMReceiveMessageDelegate>

@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UILabel *titleName;
@property(nonatomic,strong) UIButton *addBtn;

//@property(nonatomic,strong) YGBadgeButton *messageBtn;

@property(nonatomic,strong) UILabel *sliderLabel;
@property(nonatomic,strong) UIPageViewController *pageVC;
@property(nonatomic,strong) NSArray *viewControllers;
@property(nonatomic,strong) UIView *bgView;

@property(nonatomic,strong) UIButton *backBtn;
@property(nonatomic,strong) UIButton *deletedBtn;

//@property(nonatomic,strong) YGPostView *postBgView;
//
//
//@property(nonatomic,strong) YGPostCommunityView *postView1;
//@property(nonatomic,strong) YGPostCommunityView *postView2;


@end

@implementation YGCommunityController




//-(YGPostView *)postBgView {
//
//    if (!_postBgView) {
//        _postBgView = [[YGPostView alloc] initWithFrame:CGRectMake(__kWidth - 112*_Scaling, 64*_Scaling, 100*_Scaling, 109*_Scaling)];
//        _postBgView.hidden = YES;
//        _postBgView.userInteractionEnabled = YES;
//        _postBgView.bgImgView.userInteractionEnabled = YES;
//        [_postBgView.scanBtn addTarget:self action:@selector(scanAction) forControlEvents:(UIControlEventTouchUpInside)];
//        [_postBgView.dyBtn addTarget:self action:@selector(dyAction) forControlEvents:(UIControlEventTouchUpInside)];
//        [_postBgView.blueBtn addTarget:self action:@selector(blueAction) forControlEvents:(UIControlEventTouchUpInside)];
//    }
//    return _postBgView;
//}

-(void) scanAction {
    
    //    _addBtn.selected = NO;
    //    _postBgView.hidden = YES;
    //
    //    YGScanViewController *controller = [[YGScanViewController alloc] init];
    //    controller.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:controller animated:YES];
}
-(void) dyAction {
    _addBtn.selected = NO;
    //    _postBgView.hidden = YES;
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.bgView.transform = CGAffineTransformMakeTranslation(0,-__kHeight);
        
    } completion:^(BOOL finished) {
        
    }];
}
-(void) blueAction {
    //    _addBtn.selected = NO;
    //    _postBgView.hidden = YES;
    //
    //    YGAccessViewController *controller = [[YGAccessViewController alloc] init];
    //    controller.hidesBottomBarWhenPushed = YES;
    //    controller.status = 5;
    //    [self.navigationController pushViewController:controller animated:YES];
}

//-(YGPostCommunityView *)postView1 {
//
//    if (!_postView1) {
//        _postView1 = [[YGPostCommunityView alloc] initWithFrame:CGRectMake(15*_Scaling, 118*_Scaling, __kWidth - 30*_Scaling, 125*_Scaling)];
//        _postView1.imageView.image = [UIImage imageNamed:@"ygk_社群_新鲜事"];
//        _postView1.titileLB.text = @"新鲜事";
//        _postView1.contentLabel.text = @"分享新鲜事.......";
//
//        _postView1.layer.cornerRadius = 5*_Scaling;
//        _postView1.layer.masksToBounds = YES;
//        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap1Action)];
//        [_postView1 addGestureRecognizer:tap1];
//    }
//    return _postView1;
//}
//-(YGPostCommunityView *)postView2 {
//
//    if (!_postView2) {
//        _postView2 = [[YGPostCommunityView alloc] initWithFrame:CGRectMake(15*_Scaling, self.postView1.bottom + 25*_Scaling, __kWidth - 30*_Scaling, 125*_Scaling)];
//        _postView2.imageView.image = [UIImage imageNamed:@"ygk_社群_提问"];
//        _postView2.titileLB.text = @"提问";
//        _postView2.contentLabel.text = @"问专家.......";
//
//        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap2Action)];
//        [_postView2 addGestureRecognizer:tap1];
//    }
//    return _postView2;
//}

-(UIButton *)backBtn {
    
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"ygk_back"] forState:(UIControlStateNormal)];
        _backBtn.frame = CGRectMake(10*_Scaling, 40*_Scaling, 20*_Scaling, 25*_Scaling);
        [_backBtn addTarget:self action:@selector(touchAction) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _backBtn;
}

-(UIButton *)deletedBtn {
    
    if (!_deletedBtn) {
        _deletedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deletedBtn setBackgroundImage:[UIImage imageNamed:@"ygk_delete"] forState:(UIControlStateNormal)];
        _deletedBtn.frame = CGRectMake((__kWidth-18*_Scaling)/2.0, __kHeight -83*_Scaling, 18*_Scaling, 18*_Scaling);
        [_deletedBtn addTarget:self action:@selector(touchAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _deletedBtn;
}


-(void) tap1Action {
    
    [self touchAction];
    YGPostContentController *controller = [[YGPostContentController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.type = @"新鲜事";
    [self.navigationController pushViewController:controller animated:YES];
    
}
-(void) tap2Action {
    [self touchAction];
    YGPostContentController *controller = [[YGPostContentController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.type = @"提问";
    [self.navigationController pushViewController:controller animated:YES];
}



-(UIView *)bgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, __kHeight, __kWidth, __kHeight)];
        _bgView.backgroundColor = appBgRGBColor;
        _bgView.userInteractionEnabled = YES;
        
    }
    return _bgView;
}

-(void)touchAction {
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.bgView.transform = CGAffineTransformMakeTranslation(0,__kHeight);
        
    } completion:^(BOOL finished) {
        
        
    }];
}

-(UIView *)topView {
    
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __kWidth, 130*_Scaling)];
    }
    return _topView;
}

//-(YGBadgeButton *)messageBtn {
//
//    if (!_messageBtn) {
//        _messageBtn = [[YGBadgeButton alloc] init];
//        _messageBtn.frame = CGRectMake(__kWidth - 65, 14.5*_Scaling + LGF_Status_Height, 23*_Scaling, 23*_Scaling);
//        [_messageBtn setBackgroundImage:[UIImage imageNamed:@"ygk_社群通知"] forState:(UIControlStateNormal)];
//        [_messageBtn addTarget:self action:@selector(messageAction) forControlEvents:(UIControlEventTouchUpInside)];
//        _messageBtn.badgeValues = [self getUnreadCount];
//    }
//    return _messageBtn;
//}

-(UIButton *)addBtn {
    
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBtn.frame = CGRectMake(__kWidth - 36, 14.5*_Scaling + LGF_Status_Height, 23*_Scaling, 23*_Scaling);
        [_addBtn setBackgroundImage:[UIImage imageNamed:@"ygk_社群加号"] forState:(UIControlStateNormal)];
        [_addBtn addTarget:self action:@selector(postAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
}

-(UILabel *)titleName {
    
    if (!_titleName) {
        _titleName = [[UILabel alloc] initWithFrame:CGRectMake(15*_Scaling, 14*_Scaling + LGF_Status_Height, 60*_Scaling, 21*_Scaling)];
        _titleName.textColor = kRGBColor(0, 0, 0, 1.0);
        _titleName.font = [UIFont boldSystemFontOfSize:21*_Scaling];
        _titleName.text = @"社群";
        _titleName.textAlignment = NSTextAlignmentLeft;
    }
    return _titleName;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    
    self.navigationItem.title = @"";
    self.view.backgroundColor = appBgRGBColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenDyBgView) name:@"hiddenDyBgView" object:nil];
    
    [self createUI];
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.bgView];
    [self.bgView addSubview:self.backBtn];
    [self.bgView addSubview:self.deletedBtn];
    //
    //    [self.bgView addSubview:self.postView1];
    //    [self.bgView addSubview:self.postView2];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)hiddenDyBgView {
    
    self.addBtn.selected = NO;
    //    self.postBgView.hidden = YES;
    
}

-(void) createUI {
    
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.addBtn];
    self.topView.backgroundColor = [UIColor whiteColor];
    UIButton *searBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searBtn setBackgroundImage:[UIImage imageNamed:@"search圆角矩形 17"] forState:UIControlStateNormal];
    [self.topView addSubview:searBtn];
    UIImageView *searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图层 20"]];
    [searBtn addSubview:searchImage];
    UILabel *lable = [[UILabel alloc] init];
    lable.textColor = [UIColor grayColor];
    lable.text  = @"搜索店铺、搜活动、搜服务";
    lable.font = [UIFont systemFontOfSize:12*_Scaling];
    [searBtn addSubview:lable];
    UIImageView *voiceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图层 22"]];
    [searBtn addSubview:voiceImage];
    
    
    
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanBtn  setImage:[UIImage imageNamed:@"添加好友"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(addFrind:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:scanBtn];
    
    //layout
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(150*_Scaling);
        make.top.mas_equalTo(0*_Scaling);
    }];
    
    //searBtn
    [searBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        
        make.right.mas_equalTo(-30-GAP);
        make.height.mas_equalTo(29*_Scaling);
        make.top.mas_equalTo(37*_Scaling);
    }];
    [searchImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(9);
        make.width.mas_equalTo(16*_Scaling);
        make.height.mas_equalTo(16*_Scaling);
        make.centerY.mas_equalTo(searBtn);
    }];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(38*_Scaling);
        
        make.height.mas_equalTo(12*_Scaling);
        make.centerY.mas_equalTo(searBtn);
    }];
    [voiceImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5*_Scaling);
        make.width.mas_equalTo(23*_Scaling);
        make.height.mas_equalTo(23*_Scaling);
        make.centerY.mas_equalTo(searBtn);
    }];
    
    
    [scanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-GAP);
        make.width.mas_equalTo(17*_Scaling);
        make.height.mas_equalTo(17*_Scaling);
        make.centerY.mas_equalTo(searBtn);
    }];
    //    [self.topView addSubview:self.messageBtn];
    
    for (int i = 0; i < 3; i ++) {
        
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        titleBtn.frame = CGRectMake( i*85*_Scaling, 60*_Scaling + LGF_Status_Height, 90*_Scaling, 60*_Scaling);
        
        if (i == 0) {
             titleBtn.selected = YES;
           
            [titleBtn setTitle:@"动态" forState:(UIControlStateNormal)];
            [titleBtn setImage:[UIImage imageNamed:@"动态normal"] forState:(UIControlStateNormal)];
            
            [titleBtn setImage:[UIImage imageNamed:@"动态"] forState:(UIControlStateSelected)];
            
            
            
        }else if (i == 1){
            
            [titleBtn setTitle:@"群聊" forState:(UIControlStateNormal)];
            [titleBtn setImage:[UIImage imageNamed:@"群聊"] forState:(UIControlStateSelected)];
            [titleBtn setImage:[UIImage imageNamed:@"qunliao"] forState:(UIControlStateNormal)];
            
        }else {
           
            [titleBtn setTitle:@"联系人" forState:(UIControlStateNormal)];
            [titleBtn setImage:[UIImage imageNamed:@"灰色"] forState:(UIControlStateNormal)];
            
            [titleBtn setImage:[UIImage imageNamed:@"联系人"] forState:(UIControlStateSelected)];
        }
        [titleBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [titleBtn xbs_updateImageAlignmentToUpWithSpace:10];
        [titleBtn setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:(UIControlStateNormal)];
        [titleBtn setTitleColor:kRGBColor(0, 0, 0, 1.0) forState:(UIControlStateSelected)];
        titleBtn.tag = 100 + i;
        [titleBtn addTarget:self action:@selector(titileAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.topView addSubview:titleBtn];
        
    }
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(14*_Scaling);
        make.top.mas_equalTo(150*_Scaling);
    }];
    
    YGdynamicController *oneViewController = [[YGdynamicController alloc] init];
    
    YGConnectionController *twoViewController = [[YGConnectionController alloc] init];
    
    YGCooperationController *threeViewController = [[YGCooperationController alloc] init];
    
    self.viewControllers = @[oneViewController,twoViewController,threeViewController];
    
    
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    
    //    self.sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(22*_Scaling , 82*_Scaling + LGF_Status_Height, 25*_Scaling, 3*_Scaling)];
    //    self.sliderLabel.backgroundColor = kRGBColor(183, 145, 83, 1.0);
    //    [self.topView addSubview:self.sliderLabel];
    
    //    [self.view addSubview:self.postBgView];
}
- (void)addFrind:(UIButton *)btn{
    NSLog(@"addFrind");
}
-(void)titileAction:(UIButton *) sender {
    
    for (int i = 0; i < 3; i ++) {
        if (sender.tag == 100 +i) {
            UIButton *button = [self.view viewWithTag:i+100];
            button.selected = YES;
            //            [button setTitleColor:kRGBColor(183, 145, 83, 1.0) forState:(UIControlStateNormal)];
            //            button.titleLabel.font = [UIFont boldSystemFontOfSize:12*_Scaling];
            
            [UIView animateWithDuration:.25 animations:^{
                self.sliderLabel.frame = CGRectMake( 23*_Scaling + i*85*_Scaling,  82*_Scaling + LGF_Status_Height, 25*_Scaling, 2*_Scaling);
            }];
            [_pageVC setViewControllers:@[self.viewControllers[sender.tag - 100]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
            
            continue;
        }
        
        UIButton *button = [self.view viewWithTag:i+100];
        button.selected = NO;
        //        [button setTitleColor:kRGBColor(0, 0, 0, 1.0) forState:(UIControlStateNormal)];
        //        button.titleLabel.font = [UIFont systemFontOfSize:12*_Scaling];
        
    }
}

- (UIPageViewController *)pageVC {
    if (!_pageVC) {
        
        _pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        
        _pageVC.dataSource = self;
        _pageVC.delegate = self;
        
        _pageVC.view.frame = CGRectMake(0, 160*_Scaling, __kWidth, __kHeight -  160*_Scaling);
        
        for (UIView *subview in _pageVC.view.subviews) {
            
            [(UIScrollView *)subview setDelegate:self];
            //设置是否支持手势滑动
            //            [(UIScrollView *)subview setScrollEnabled:NO];
            
        }
        [_pageVC setViewControllers:@[self.viewControllers[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
    return _pageVC;
}

#pragma mark - UIPageViewControllerDataSource
// 返回下一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:viewController];
    
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    
    if (index == [self.viewControllers count]) {
        return nil;
    }
    return self.viewControllers[index];
}
// 返回上一个ViewController对象
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = [self indexOfViewController:viewController];
    
    if (index == 0 || index == NSNotFound) {
        return nil;
    }
    index--;
    
    return self.viewControllers[index];
}
-(void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    
}

#pragma mark - UIPageViewControllerDelegate

// 开始翻页调用
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers NS_AVAILABLE_IOS(6_0) {
    NSLog(@"开始翻页");
}
// 翻页完成调用
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    NSInteger index = [self.viewControllers indexOfObject:pageViewController.viewControllers[0]];
    
    
    for (int i = 0; i < 3; i ++) {
        if (index + 100 == 100 +i) {
            UIButton *button = [self.view viewWithTag:i+100];
            button.selected = YES;
            
            
            
            [UIView animateWithDuration:.25 animations:^{
                self.sliderLabel.frame = CGRectMake( 23*_Scaling + i*85*_Scaling,  82*_Scaling + LGF_Status_Height, 25*_Scaling, 2*_Scaling);
            }];
            continue;
        }
        
        UIButton *button = [self.view viewWithTag:i+100];
        button.selected = NO;
        
        
    }
    
    NSLog(@"翻页完成");
}
- (UIInterfaceOrientation)pageViewControllerPreferredInterfaceOrientationForPresentation:(UIPageViewController *)pageViewController NS_AVAILABLE_IOS(7_0) __TVOS_PROHIBITED {
    return UIInterfaceOrientationPortrait;
}


#pragma mark - Tool
// 根据数组元素，得到下标值
- (NSUInteger)indexOfViewController:(UIViewController *)viewControlller {
    return [self.viewControllers indexOfObject:viewControlller];
}

-(void) messageAction {
    
    //    YGMessageViewController *controller = [[YGMessageViewController alloc] init];
    //    controller.hidesBottomBarWhenPushed = YES;
    //    [self.navigationController pushViewController:controller animated:YES];
    
}

-(void) postAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            //            self.postBgView.hidden = NO;
        } completion:^(BOOL finished) {
        }];
        
        
    }else {
        
        //        [UIView animateWithDuration:0.25 animations:^{
        //            self.postBgView.hidden = YES;
        //        } completion:^(BOOL finished) {
        //
        //        }];
    }
    
}


#pragma mark -- 融云代理

-(void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
    
    NSLog(@"未读消息数：%ld",[self getUnreadCount]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //        self.messageBtn.badgeValues = [self getUnreadCount];
    });
}

-(void) addRippleLayer {
    //    _messageBtn.badgeValues = 12;
}

-(NSInteger)getUnreadCount{
    int unreadMsgCount = [[RCIMClient sharedRCIMClient] getUnreadCount:@[
                                                                         @(ConversationType_PRIVATE)
                                                                         ]];
    return unreadMsgCount ;
}

@end
