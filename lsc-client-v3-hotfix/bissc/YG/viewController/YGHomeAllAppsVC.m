//
//  YGHomeAllAppsVC.m
//  bissc
//
//  Created by 龙广发 on 2019/10/14.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import "YGHomeAllAppsVC.h"

@interface YGHomeAllAppsVC ()
@property(nonatomic,strong) UIButton *backBtn;
@property(nonatomic,strong) UILabel *titleLB;
@property(nonatomic,strong) UIScrollView *sv;
@property(nonatomic,strong) UIView *svContentView;
@property(nonatomic,strong) UIButton *rightBtn;
@end

@implementation YGHomeAllAppsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI{
   

    UIScrollView *sv = [[UIScrollView alloc] init];
    [self.view addSubview:sv];
    self.sv = sv;
    UIView *svHeight = [[UIView alloc] init];
    UIView *svContentView = [[UIView alloc] init];
    self.svContentView = svContentView;
    
    [sv addSubview:svHeight];
    [sv addSubview:svContentView];
    svContentView.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];;
    
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F6F6F6"];
    
    //laout
    [sv mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        //        make.bottom.left.right.mas_equalTo(0);
        //        make.top.mas_equalTo(91*_Scaling);
        
        
    }];
    
    
    [svContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv);
        make.width.equalTo(sv);
        make.height.equalTo(svHeight);
    }];
    //企业服务
    UIView *serviceView=[[UIView alloc] init];
    serviceView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [svContentView addSubview:serviceView];
    
    UILabel *serviceViewlable = [[UILabel alloc] init];
    serviceViewlable.textColor = [UIColor blackColor];
    serviceViewlable.text  = @"企业服务";
    [serviceViewlable setFont: [UIFont fontWithName:@"Arial-BoldMT" size:18*_Scaling]];
    [serviceView addSubview:serviceViewlable];
    
    
    UIView *serviceBtnView=[[UIView alloc] init];
    serviceBtnView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [serviceView addSubview:serviceBtnView];
    
    
    NSArray *btnTitles = @[@"企业服务",@"场地预定",@"会议室预定",@"访客邀约",@"活动",@"企业广场",@"智慧招聘",@"考勤打卡"];
    NSArray *btnImages = @[@"企业服务",@"预定_icon",@"会议室预定",@"访客邀约",@"活动-1",@"企业2",@"智慧招聘",@"kaoqintiaozheng"];
    CGFloat width = 130 *_Scaling;
    for (int i = 0; i<btnTitles.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn setImage:[UIImage imageNamed:btnImages[i]] forState:UIControlStateNormal];
        
        
        [btn  addTarget:self action:@selector(seltedBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000 + i;
        [serviceBtnView addSubview:btn];
        
        NSInteger row = i / 3;
        NSInteger col = i % 3;
        btn.frame = CGRectMake(( width)*col-36,  ( 18 +75)*row, width, 75*_Scaling);
        
        [btn xbs_updateImageAlignmentToUpWithSpace:7];
        
    }
    
    //企业服务
    [serviceViewlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16*_Scaling);
        
        make.top.mas_equalTo(20*_Scaling);
        make.height.mas_equalTo(17*_Scaling);
    }];
    
    [serviceBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16*_Scaling);
        make.right.mas_equalTo(-16*_Scaling);
        make.top.mas_equalTo(62*_Scaling);
        make.height.mas_equalTo(277*_Scaling);
    }];

    
    
    //智能硬件
    UIView *zhiNengView=[[UIView alloc] init];
    zhiNengView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [svContentView addSubview:zhiNengView];
    
    UILabel *zhiNengViewViewlable = [[UILabel alloc] init];
    zhiNengViewViewlable.textColor = [UIColor blackColor];
    zhiNengViewViewlable.text  = @"智能硬件";
    [zhiNengViewViewlable setFont: [UIFont fontWithName:@"Arial-BoldMT" size:18*_Scaling]];
    [zhiNengView addSubview:zhiNengViewViewlable];
    
    
    UIView *zhiNengBtnView=[[UIView alloc] init];
    zhiNengBtnView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [zhiNengView addSubview:zhiNengBtnView];
  
    
    NSArray *zhiNengViewbtnTitles = @[@"云打印",@"停车管理",@"门禁管理"];
    NSArray *zhiNengViewbtnImages = @[@"打印机",@"停车场",@"门禁管理"];
//    CGFloat zhiNengViewwidth = 130 *_Scaling;
    for (int i = 0; i<zhiNengViewbtnTitles.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:zhiNengViewbtnTitles[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn setImage:[UIImage imageNamed:zhiNengViewbtnImages[i]] forState:UIControlStateNormal];
        
        
        [btn  addTarget:self action:@selector(seltedBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 2000 + i;
        [zhiNengBtnView addSubview:btn];
        
        NSInteger row = i / 3;
        NSInteger col = i % 3;
        btn.frame = CGRectMake(( width)*col-36,  ( 18 +75)*row, width, 75*_Scaling);
        
        [btn xbs_updateImageAlignmentToUpWithSpace:7];
        
    }
    
   
    [zhiNengViewViewlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16*_Scaling);
        
        make.top.mas_equalTo(20*_Scaling);
        make.height.mas_equalTo(17*_Scaling);
    }];
    
    [zhiNengBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16*_Scaling);
        make.right.mas_equalTo(-16*_Scaling);
        make.top.mas_equalTo(62*_Scaling);
        make.height.mas_equalTo(91*_Scaling);
    }];

     //智能硬件
    
    //运营服务
    UIView *yyingView=[[UIView alloc] init];
    yyingView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [svContentView addSubview:yyingView];
    
    UILabel *yyingViewlable = [[UILabel alloc] init];
    yyingViewlable.textColor = [UIColor blackColor];
    yyingViewlable.text  = @"运营服务";
    [yyingViewlable setFont: [UIFont fontWithName:@"Arial-BoldMT" size:18*_Scaling]];
    [yyingView addSubview:yyingViewlable];
    
    
    UIView *yyingBtnView=[[UIView alloc] init];
    yyingBtnView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [yyingView addSubview:yyingBtnView];
    
    
    NSArray *yyingBtnViewTitles = @[@"最美的人"];
    NSArray *yyingBtnViewImages = @[@"最美的人"];
    //    CGFloat zhiNengViewwidth = 130 *_Scaling;
    for (int i = 0; i<yyingBtnViewTitles.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:yyingBtnViewTitles[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn setImage:[UIImage imageNamed:yyingBtnViewImages[i]] forState:UIControlStateNormal];
        
        
        [btn  addTarget:self action:@selector(seltedBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 3000 + i;
        [yyingBtnView addSubview:btn];
        
        NSInteger row = i / 3;
        NSInteger col = i % 3;
        btn.frame = CGRectMake(( width)*col-36,  ( 18 +75)*row, width, 75*_Scaling);
        
        [btn xbs_updateImageAlignmentToUpWithSpace:7];
        
    }
    
    
    [yyingViewlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16*_Scaling);
        
        make.top.mas_equalTo(20*_Scaling);
        make.height.mas_equalTo(17*_Scaling);
    }];
    
    [yyingBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16*_Scaling);
        make.right.mas_equalTo(-16*_Scaling);
        make.top.mas_equalTo(62*_Scaling);
        make.height.mas_equalTo(91*_Scaling);
    }];
    
    //运营服务
    
    
    
    //空间党建
    UIView *spaceView=[[UIView alloc] init];
    spaceView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [svContentView addSubview:spaceView];
    
    UILabel *spaceViewlable = [[UILabel alloc] init];
    spaceViewlable.textColor = [UIColor blackColor];
    spaceViewlable.text  = @"空间党建";
    [spaceViewlable setFont: [UIFont fontWithName:@"Arial-BoldMT" size:18*_Scaling]];
    [spaceView addSubview:spaceViewlable];
    
    
    UIView *spaceBtnView=[[UIView alloc] init];
    spaceBtnView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [spaceView addSubview:spaceBtnView];
    
    
    NSArray *spaceBtnViewTitles = @[@"党建动态",@"党建公告",@"志愿者服务",@"教育视频"];
    NSArray *spaceBtnViewImages = @[@"iconfontdongtaidianji",@"gonggao",@"renlishebao",@"jinrongfuwu"];
    //    CGFloat zhiNengViewwidth = 130 *_Scaling;
    for (int i = 0; i<spaceBtnViewTitles.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:spaceBtnViewTitles[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn setImage:[UIImage imageNamed:spaceBtnViewImages[i]] forState:UIControlStateNormal];
        
        
        [btn  addTarget:self action:@selector(seltedBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 4000 + i;
        [spaceBtnView addSubview:btn];
        
        NSInteger row = i / 3;
        NSInteger col = i % 3;
        btn.frame = CGRectMake(( width)*col-36,  ( 18 +75)*row, width, 75*_Scaling);
        
        [btn xbs_updateImageAlignmentToUpWithSpace:7];
        
    }
    
    
    [spaceViewlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16*_Scaling);
        
        make.top.mas_equalTo(20*_Scaling);
        make.height.mas_equalTo(17*_Scaling);
    }];
    
    [spaceBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16*_Scaling);
        make.right.mas_equalTo(-16*_Scaling);
        make.top.mas_equalTo(62*_Scaling);
        make.height.mas_equalTo(184*_Scaling);
    }];
    
    //空间党建
    //企业金融
    UIView *companyView=[[UIView alloc] init];
    companyView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [svContentView addSubview:companyView];
    
    UILabel *companyViewlable = [[UILabel alloc] init];
    companyViewlable.textColor = [UIColor blackColor];
    companyViewlable.text  = @"企业金融";
    [companyViewlable setFont: [UIFont fontWithName:@"Arial-BoldMT" size:18*_Scaling]];
    [companyView addSubview:companyViewlable];
    
    
    UIView *companyViewlableBtnView=[[UIView alloc] init];
    companyViewlableBtnView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [companyView addSubview:companyViewlableBtnView];
    
    
    NSArray *companyViewTitles = @[@"融资服务",@"供应链金融",@"公司理财",@"微企业金融"];
    NSArray *companyViewImages = @[@"jinrongfuwu",@"gongyinglian",@"licai",@"微企业金融"];
    //    CGFloat zhiNengViewwidth = 130 *_Scaling;
    for (int i = 0; i<companyViewTitles.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:companyViewTitles[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn setImage:[UIImage imageNamed:companyViewImages[i]] forState:UIControlStateNormal];
        
        
        [btn  addTarget:self action:@selector(seltedBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 5000 + i;
        [companyViewlableBtnView addSubview:btn];
        
        NSInteger row = i / 3;
        NSInteger col = i % 3;
        btn.frame = CGRectMake(( width)*col-36,  ( 18 +75)*row, width, 75*_Scaling);
        
        [btn xbs_updateImageAlignmentToUpWithSpace:7];
        
    }
    
    
    [companyViewlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16*_Scaling);
        
        make.top.mas_equalTo(20*_Scaling);
        make.height.mas_equalTo(17*_Scaling);
    }];
    
    [companyViewlableBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16*_Scaling);
        make.right.mas_equalTo(-16*_Scaling);
        make.top.mas_equalTo(62*_Scaling);
        make.height.mas_equalTo(184*_Scaling);
    }];
    
    //企业金融
    
    //物业服务
    UIView *wyView=[[UIView alloc] init];
    wyView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [svContentView addSubview:wyView];
    
    UILabel *wyViewlable = [[UILabel alloc] init];
    wyViewlable.textColor = [UIColor blackColor];
    wyViewlable.text  = @"物业服务";
    [wyViewlable setFont: [UIFont fontWithName:@"Arial-BoldMT" size:18*_Scaling]];
    [wyView addSubview:wyViewlable];
    
    
    UIView *wyViewBtnView=[[UIView alloc] init];
    wyViewBtnView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [wyView addSubview:wyViewBtnView];
    
    
    NSArray *wyViewBtnViewTitles = @[@"物业费用",@"我要保修",@"预约保洁",@"我要投诉"];
    NSArray *wyViewBtnViewImages = @[@"物业费用",@"我要保修",@"预约保洁",@"我要投诉"];
    //    CGFloat zhiNengViewwidth = 130 *_Scaling;
    for (int i = 0; i<wyViewBtnViewTitles.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:wyViewBtnViewTitles[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn setImage:[UIImage imageNamed:wyViewBtnViewImages[i]] forState:UIControlStateNormal];
        
        
        [btn  addTarget:self action:@selector(seltedBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 6000 + i;
        [wyViewBtnView addSubview:btn];
        
        NSInteger row = i / 3;
        NSInteger col = i % 3;
        btn.frame = CGRectMake(( width)*col-36,  ( 18 +75)*row, width, 75*_Scaling);
        
        [btn xbs_updateImageAlignmentToUpWithSpace:7];
        
    }
    
    
    [wyViewlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16*_Scaling);
        
        make.top.mas_equalTo(20*_Scaling);
        make.height.mas_equalTo(17*_Scaling);
    }];
    
    [wyViewBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16*_Scaling);
        make.right.mas_equalTo(-16*_Scaling);
        make.top.mas_equalTo(62*_Scaling);
        make.height.mas_equalTo(184*_Scaling);
    }];
    
    //企业金融
    
    
    
    
    
    serviceView.layer.cornerRadius = 2.5 ;
    serviceView.layer.masksToBounds = YES;
    
    zhiNengView.layer.cornerRadius = 2.5 ;
    zhiNengView.layer.masksToBounds = YES;
    yyingView.layer.cornerRadius = 2.5 ;
    yyingView.layer.masksToBounds = YES;
    spaceView.layer.cornerRadius = 2.5 ;
    spaceView.layer.masksToBounds = YES;
    companyView.layer.cornerRadius = 2.5 ;
    companyView.layer.masksToBounds = YES;
    wyView.layer.cornerRadius = 2.5 ;
    wyView.layer.masksToBounds = YES;
    
    //layout zhiNengView
    [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*_Scaling);
        make.right.mas_equalTo(-13*_Scaling);
        make.top.mas_equalTo(70*_Scaling);
        make.height.mas_equalTo(339*_Scaling);
    }];
    [zhiNengView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*_Scaling);
        make.right.mas_equalTo(-13*_Scaling);
        make.top.mas_equalTo(429*_Scaling);
        make.height.mas_equalTo(153*_Scaling);
    }];
    [yyingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*_Scaling);
        make.right.mas_equalTo(-13*_Scaling);
        make.top.mas_equalTo(602*_Scaling);
        make.height.mas_equalTo(155*_Scaling);
    }];
    [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*_Scaling);
        make.right.mas_equalTo(-13*_Scaling);
        make.top.mas_equalTo(776*_Scaling);
        make.height.mas_equalTo(245*_Scaling);
    }];
    
    [companyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*_Scaling);
        make.right.mas_equalTo(-13*_Scaling);
        make.top.mas_equalTo(1041*_Scaling);
        make.height.mas_equalTo(247*_Scaling);
    }];
    [wyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13*_Scaling);
        make.right.mas_equalTo(-13*_Scaling);
        make.top.mas_equalTo(1307*_Scaling);
        make.height.mas_equalTo(247*_Scaling);
    }];
    
    //svHeight lastView spaceView companyView
    UIView *lastView = wyView;
    [svHeight mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(sv);
        make.bottom.mas_equalTo(lastView);
    }];
    
    
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"返回-2"] forState:(UIControlStateNormal)];
    _backBtn.frame = CGRectMake(10*_Scaling, 40*_Scaling, 20*_Scaling, 25*_Scaling);
    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_backBtn];
 
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = [UIFont systemFontOfSize:16*_Scaling];
    
    _titleLB.textColor = [UIColor colorWithHexString:@"#2E2E2E"];
    _titleLB.textAlignment = NSTextAlignmentCenter;
    _titleLB.text = @"应用";
    
    [self.view addSubview:_titleLB];
    [_titleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(40*_Scaling);
    }];
    
}
//event seltedBtn

-(void) seltedBtn:(UIButton *)btn {
    NSLog(@"seltedBtn,%ld",(long)btn.tag);
     
}

-(void) backAction {
    NSLog(@"backAction");
    [self.navigationController popViewControllerAnimated:YES ];
}



-(void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
@end
