//
//  ViewController.m
//  bissc
//
//  Created by 龙广发 on 2019/9/19.
//  Copyright © 2019年 龙广发. All rights reserved.
//
#import "UIButton+XBSImageAlignment.h"
#import "ViewController.h"
#import "YGHomeLoopPlaybackView.h"

@interface ViewController ()
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) YGHomeLoopPlaybackView *cycleScrollView1;

@property(nonatomic,strong) NSMutableArray *imageArray1;
@property(nonatomic,strong) YGHomeLoopPlaybackView *cycleScrollView2;

@property(nonatomic,strong) NSMutableArray *imageArray2;
@property(nonatomic,assign) BOOL isfreeViewHidden;
@property(nonatomic,weak) UIView *freeView;
@property(nonatomic,weak) UIView *serviceView;
@property(nonatomic,weak) UIView *lineViewFood;
@property(nonatomic,weak) UIView *foodView;
@property(nonatomic,weak) UIView *hotTopicView;
@property(nonatomic,weak) UIView *lineViewTp;
@property(nonatomic,weak) UIView *lineViewJX;
@property(nonatomic,weak) UIView *JXView;
@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = appBgRGBColor;
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
#define GAP 13
#define _Scaling  [[UIScreen mainScreen]bounds].size.width/375.0
- (void)createUI{
    
    [self.view addSubview:self.topView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"万博汇" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"图层 23"] forState:UIControlStateNormal];
    [btn xbs_updateImageAlignmentToRightWithSpace:3];
    [btn addTarget:self action:@selector(selectedAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:btn];
    
    
    UIButton *searBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 17"] forState:UIControlStateNormal];
    [self.topView addSubview:searBtn];
    UIImageView *searchImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图层 20"]];
    [searBtn addSubview:searchImage];
     UILabel *lable = [[UILabel alloc] init];
    lable.textColor = [UIColor grayColor];
    lable.text  = @"搜索公司,服务,场地";
    [searBtn addSubview:lable];
    UIImageView *voiceImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"图层 22"]];
    [searBtn addSubview:voiceImage];
    
   
    
    UIButton *scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanBtn  setImage:[UIImage imageNamed:@"图层 21"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(scanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.topView addSubview:scanBtn];
    
    //layout
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.height.mas_equalTo(29*_Scaling);
        make.top.mas_equalTo(37*_Scaling);
    }];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(78*_Scaling);
        make.height.mas_equalTo(14*_Scaling);
        make.centerY.mas_equalTo(self.topView);
    }];
    //searBtn
    [searBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(80);
//        make.width.mas_equalTo(230*_Scaling);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(29*_Scaling);
        make.centerY.mas_equalTo(self.topView);
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
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(17*_Scaling);
        make.height.mas_equalTo(17*_Scaling);
        make.centerY.mas_equalTo(self.topView);
    }];
    //
    UIScrollView *sv = [[UIScrollView alloc] init];
    [self.view addSubview:sv];
    UIView *svHeight = [[UIView alloc] init];
    UIView *svContentView = [[UIView alloc] init];
    [sv addSubview:svHeight];
    [sv addSubview:svContentView];
    svContentView.backgroundColor = appBgRGBColor;
    
    
    self.view.backgroundColor = appBgRGBColor;
    
    //laout
    [sv mas_remakeConstraints:^(MASConstraintMaker *make) {
        //        make.edges.mas_equalTo(self.view);
        make.bottom.left.right.mas_equalTo(0);
        make.top.mas_equalTo(91*_Scaling);
      
        
    }];
    
    
    [svContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv);
        make.width.equalTo(sv);
        make.height.equalTo(svHeight);
    }];
    

    // 第一个 轮播图
    NSArray *array =@[@"https://www.baidu.com/s?tn=84053098_3_dg&wd=ios&ie=utf-8&rsv_cq=NavigationBar+hidden&rsv_dl=0_right_recommends_merge_28335&euri=8747673", @"https://www.baidu.com/s?tn=84053098_3_dg&wd=ios&ie=utf-8&rsv_cq=NavigationBar+hidden&rsv_dl=0_right_recommends_merge_28335&euri=8747673"];
    self.imageArray1 = [NSMutableArray arrayWithArray:array] ;
    self.cycleScrollView1 = [[YGHomeLoopPlaybackView alloc] initWithFrame:CGRectMake(0, 0, __kWidth, 150*_Scaling) imageGroups:self.imageArray1 withPlaceHoderl:[UIImage imageNamed:@"组 44"]];
    self.cycleScrollView1.delegate = self;
    self.cycleScrollView1.scrollView.backgroundColor = appBgRGBColor;
    
    [svContentView addSubview:self.cycleScrollView1];
    
    UIView *btnView = [[UIView alloc] init];
    btnView.backgroundColor = appBgRGBColor ;
    [svContentView addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(150*_Scaling);
        make.top.mas_equalTo(191*_Scaling);
    }];
    
    
    NSArray *btnTitles = @[@"访客",@"预定",@"门禁",@"企业广场",@"停车",@"考勤",@"审批",@"全部应用"];
    NSArray *btnImages = @[@"home-fk",@"home-yd",@"home-mj",@"home-qy",@"home-tc",@"home-kq",@"home-sp",@"home-all"];
    CGFloat width = (__kWidth - 40*4*_Scaling)/4.0;
    for (int i = 0; i<btnTitles.count ; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [btn setImage:[UIImage imageNamed:btnImages[i]] forState:UIControlStateNormal];
        

        [btn  addTarget:self action:@selector(seltedBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000 + i;
        [btnView addSubview:btn];
//        [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
       
       

        NSInteger row = i / 4;
        NSInteger col = i % 4;
        btn.frame = CGRectMake((30 + width)*col,  (35 + 50)*row, width*_Scaling+60, 55*_Scaling);
      
        [btn xbs_updateImageAlignmentToUpWithSpace:3];

    }
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
      [svContentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(2);
        make.top.mas_equalTo(340*_Scaling);
    }];
    
// 广播
    UIButton *gbBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [gbBtn setBackgroundImage:[UIImage imageNamed:@"圆角矩形 17"] forState:UIControlStateNormal];
    [svContentView addSubview:gbBtn];
    
    UIImageView *gbBtnImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home-gb"]];
    [gbBtn addSubview:gbBtnImg];
    
    UILabel *ttlable = [[UILabel alloc] init];
    ttlable.textColor = [UIColor blackColor];
    ttlable.text  = @"云谷头条";
    [gbBtn addSubview:ttlable];
    
    UILabel *ttlableAfter = [[UILabel alloc] init];
    ttlableAfter.textColor = [UIColor colorWithHexString:@"#999999"];
    ttlableAfter.text  = @"2019香港公司年审需要知道哪些····";
    [gbBtn addSubview:ttlableAfter];
    
    [gbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
         make.right.mas_equalTo(-GAP);
        make.height.mas_equalTo(40*_Scaling);
        make.top.mas_equalTo(346*_Scaling);
    }];
    //gbtn
    [gbBtnImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*_Scaling);
        make.width.mas_equalTo(25*_Scaling);
        make.height.mas_equalTo(25*_Scaling);
        make.centerY.mas_equalTo(gbBtn);
    }];
    [ttlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40*_Scaling);
        make.width.mas_equalTo(74*_Scaling);
        make.height.mas_equalTo(14*_Scaling);
        make.centerY.mas_equalTo(gbBtn);
    }];
    [ttlableAfter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(110*_Scaling);
        make.width.mas_equalTo(240*_Scaling);
        make.height.mas_equalTo(14*_Scaling);
        make.centerY.mas_equalTo(gbBtn);
    }];
    
//     freeView
    UIView *freeView = [[UIView alloc] init];
    self.freeView =freeView;
    
    freeView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [svContentView addSubview:freeView];
    
    UIImageView *freeViewImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"组 44"]];
    freeViewImg.userInteractionEnabled = YES;
    [freeView addSubview:freeViewImg];
    
    UIButton *freeViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [freeViewBtn setImage:[UIImage imageNamed:@"图层 39"] forState:UIControlStateNormal];
    [freeViewBtn  addTarget:self action:@selector(freeViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [freeViewImg addSubview:freeViewBtn];
    
    [freeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(80*_Scaling);
        make.top.mas_equalTo(390*_Scaling);
    }];
    [freeViewImg  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.height.mas_equalTo(75*_Scaling);
        make.centerY.mas_equalTo(freeView);
    }];
    [freeViewBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.width.height.mas_equalTo(20*_Scaling);
        
    }];
    
    
//     qywf
    UIView *serviceView = [[UIView alloc] init];
    self.serviceView= serviceView;
    [svContentView addSubview:serviceView];
    
    
    UILabel *serviceViewlable = [[UILabel alloc] init];
    serviceViewlable.textColor = [UIColor blackColor];
    serviceViewlable.text  = @"企业服务";
    [serviceViewlable setFont:[UIFont systemFontOfSize:16*_Scaling]];
    [serviceView addSubview:serviceViewlable];
    
    UIButton *servicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [servicBtn  setImage:[UIImage imageNamed:@"图层 15"] forState:UIControlStateNormal];
    [servicBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [servicBtn setTitle:@"更多" forState:UIControlStateNormal];
    [servicBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [servicBtn addTarget:self action:@selector(servicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [serviceView addSubview:servicBtn];
    [servicBtn xbs_updateImageAlignmentToRightWithSpace:2];
    
    
    UIButton *servicLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    servicLeftBtn.tag = 2000;
    [servicLeftBtn  setImage:[UIImage imageNamed:@"组 46"] forState:UIControlStateNormal];
    [servicLeftBtn addTarget:self action:@selector(servicLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [serviceView addSubview:servicLeftBtn];
    
    
    UIButton *servicRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     servicRightBtn.tag = 2001;
    [servicRightBtn  setImage:[UIImage imageNamed:@"组 45"] forState:UIControlStateNormal];
    [servicRightBtn addTarget:self action:@selector(servicLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [serviceView addSubview:servicRightBtn];
    
    
    CGFloat topGap =self.isfreeViewHidden?390*_Scaling:390*_Scaling+80;
    
    [serviceView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topGap);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(136*_Scaling);
        
    }];
    [serviceViewlable  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(GAP);
        make.left.mas_equalTo(GAP);
        make.height.mas_equalTo(16*_Scaling);
         make.width.mas_equalTo(70*_Scaling);
        
    }];
    [servicBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.height.mas_equalTo(25*_Scaling);
        make.width.mas_equalTo(60*_Scaling);
        
    }];
    
    [servicLeftBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(43*_Scaling);
        make.left.mas_equalTo(GAP);
        make.height.mas_equalTo(80*_Scaling);
        make.width.mas_equalTo(175*_Scaling);
        
    }];
    [servicRightBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(43*_Scaling);
        make.right.mas_equalTo(-GAP);
        make.height.mas_equalTo(80*_Scaling);
        make.width.mas_equalTo(175*_Scaling);
        
    }];
    
  //lineview
    UIView *lineViewFood = [[UIView alloc] init];
    self.lineViewFood = lineViewFood;
    lineViewFood.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [svContentView addSubview:lineViewFood];
    
    CGFloat topGapFood =self.isfreeViewHidden?(390+136)*_Scaling:(390+80+136)*_Scaling;
    [lineViewFood mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(5);
        make.top.mas_equalTo(topGapFood);
    }];
//ViewFoo
    UIView *foodView = [[UIView alloc] init];
    self.foodView= foodView;
    [svContentView addSubview:foodView];
    
    // 第2个 轮播图
    NSArray *array2 =@[@"https://www.baidu.com/s?tn=84053098_3_dg&wd=ios&ie=utf-8&rsv_cq=NavigationBar+hidden&rsv_dl=0_right_recommends_merge_28335&euri=8747673", @"https://www.baidu.com/s?tn=84053098_3_dg&wd=ios&ie=utf-8&rsv_cq=NavigationBar+hidden&rsv_dl=0_right_recommends_merge_28335&euri=8747673"];
    self.imageArray2 = [NSMutableArray arrayWithArray:array] ;
    
    
    self.cycleScrollView2 = [[YGHomeLoopPlaybackView alloc] initWithFrame:CGRectMake(0, 15*_Scaling, __kWidth, 150*_Scaling) imageGroups:self.imageArray2 withPlaceHoderl:[UIImage imageNamed:@"组 47"]];
    self.cycleScrollView2.delegate = self;
    self.cycleScrollView2.scrollView.backgroundColor = appBgRGBColor;
    [foodView addSubview:self.cycleScrollView2];
    
    CGFloat topGapLoopPlaybackView =self.isfreeViewHidden?(390+136+5)*_Scaling:(390+80+136+5)*_Scaling;
    [foodView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(193*_Scaling);
        make.top.mas_equalTo(topGapFood);
    }];
//lineViewTp
    UIView *lineViewTp = [[UIView alloc] init];
    self.lineViewTp = lineViewTp;
    lineViewTp.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [svContentView addSubview:lineViewTp];
    
     CGFloat topGapTp =self.isfreeViewHidden?(390+136+5+193)*_Scaling:(390+80+136+5+193)*_Scaling;
     [lineViewTp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(5);
        make.top.mas_equalTo(topGapTp);
    }];
//hotTopicView
    UIView *hotTopicView = [[UIView alloc] init];
    self.hotTopicView= hotTopicView;
    [svContentView addSubview:hotTopicView];
    
    
    UILabel *hotTopicViewlable = [[UILabel alloc] init];
    hotTopicViewlable.textColor = [UIColor blackColor];
    hotTopicViewlable.text  = @"热门话题";
    [hotTopicViewlable setFont:[UIFont systemFontOfSize:16*_Scaling]];
    [hotTopicView addSubview:hotTopicViewlable];
    
    UIButton *hotTopicViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [hotTopicViewBtn  setImage:[UIImage imageNamed:@"图层 15"] forState:UIControlStateNormal];
    [hotTopicViewBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [hotTopicViewBtn setTitle:@"更多" forState:UIControlStateNormal];
    [hotTopicViewBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [hotTopicViewBtn addTarget:self action:@selector(hotTopicViewBtnMore:) forControlEvents:UIControlEventTouchUpInside];
    [hotTopicView addSubview:hotTopicViewBtn];
    [hotTopicViewBtn xbs_updateImageAlignmentToRightWithSpace:2];
    
    
    UIButton *hotTopicViewBtnCenter = [UIButton buttonWithType:UIButtonTypeCustom];
    hotTopicViewBtnCenter.tag = 2000;
    [hotTopicViewBtnCenter  setImage:[UIImage imageNamed:@"组 48"] forState:UIControlStateNormal];
    [hotTopicViewBtnCenter addTarget:self action:@selector(hotTopicViewBtnCenterClick:) forControlEvents:UIControlEventTouchUpInside];
    [hotTopicView addSubview:hotTopicViewBtnCenter];
    

    CGFloat topGaphotTopicView =self.isfreeViewHidden?(390+136+5+193+5)*_Scaling:(390+80+136+5+193+5)*_Scaling;
    [hotTopicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(211*_Scaling);
        make.top.mas_equalTo(topGaphotTopicView);
    }];
    
    [hotTopicViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.height.mas_equalTo(16*_Scaling);
  
    }];
    [hotTopicViewlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(GAP);
        make.height.mas_equalTo(16*_Scaling);
        
    }];
    [hotTopicViewBtnCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(46*_Scaling);
        make.right.mas_equalTo(-GAP);
        make.left.mas_equalTo(GAP);
         make.height.mas_equalTo(150*_Scaling);
        
    }];
    
//lineViewJX JXView
    UIView *lineViewJX = [[UIView alloc] init];
    self.lineViewJX = lineViewJX;
    lineViewJX.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [svContentView addSubview:lineViewJX];
    
    CGFloat topGaplineViewJX =self.isfreeViewHidden?(390+136+5+193+5+211)*_Scaling:(390+80+136+5+193+5+211)*_Scaling;
    
    [lineViewJX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(5);
        make.top.mas_equalTo(topGaplineViewJX);
    }];
    //hotTopicView
    UIView *JXView = [[UIView alloc] init];
    JXView.backgroundColor = [UIColor whiteColor];
    self.JXView= JXView;
    [svContentView addSubview:JXView];
    
    
    UILabel *JXViewlable = [[UILabel alloc] init];
    JXViewlable.textColor = [UIColor blackColor];
    JXViewlable.text  = @"精选推荐";
    [JXViewlable setFont:[UIFont systemFontOfSize:16*_Scaling]];
    [JXView addSubview:JXViewlable];
    
    UIButton *JXViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [JXViewBtn  setImage:[UIImage imageNamed:@"图层 15"] forState:UIControlStateNormal];
    [JXViewBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [JXViewBtn setTitle:@"更多" forState:UIControlStateNormal];
    [JXViewBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [JXViewBtn addTarget:self action:@selector(hotTopicViewBtnMore:) forControlEvents:UIControlEventTouchUpInside];
    [JXView addSubview:JXViewBtn];
    [JXViewBtn xbs_updateImageAlignmentToRightWithSpace:2];
    
    
    UIButton *JXViewBtnCenter = [UIButton buttonWithType:UIButtonTypeCustom];
    JXViewBtnCenter.tag = 2000;
    [JXViewBtnCenter  setImage:[UIImage imageNamed:@"图层 38"] forState:UIControlStateNormal];
    [JXViewBtnCenter addTarget:self action:@selector(JXViewBtnCenterClick:) forControlEvents:UIControlEventTouchUpInside];
    [JXView addSubview:JXViewBtnCenter];
    //fixbug  xq
    UILabel *JXViewlableCenter = [[UILabel alloc] init];
    JXViewlableCenter.textColor = [UIColor blackColor];
    JXViewlableCenter.text  = @"太幸福了！辽宁夺冠归来遇暖心一幕 球迷凌晨2点还来接机";
    [JXViewlableCenter setFont:[UIFont systemFontOfSize:14*_Scaling]];
    [JXView addSubview:JXViewlableCenter];
     JXViewlableCenter.numberOfLines = 3;
    JXViewlableCenter.lineBreakMode = NSLineBreakByTruncatingTail;
   
    
    UILabel *JXViewlableCenterxq = [[UILabel alloc] init];
    JXViewlableCenterxq.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    JXViewlableCenterxq.text  = @"北京时间9月24日凌晨，东亚超级联赛非凡12登顶夺冠以后，史蒂芬森和辽宁队备受球迷热捧。这不，球队在凌晨两点返回沈阳机场时，现场竟然还出现了一小部分的辽宁球迷";
    [JXViewlableCenterxq setFont:[UIFont systemFontOfSize:14*_Scaling]];
    [JXView addSubview:JXViewlableCenterxq];
    JXViewlableCenterxq.numberOfLines = 4;
    JXViewlableCenterxq.lineBreakMode = NSLineBreakByTruncatingTail;
    
    
    //下面的点赞按钮
    UIView *lineViewJXBtoom = [[UIView alloc] init];
 
    lineViewJXBtoom.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [JXView addSubview:lineViewJXBtoom];
    //shouchang
    UIButton *JXViewBtnSave = [UIButton buttonWithType:UIButtonTypeCustom];
    JXViewBtnSave.tag = 3000;
    [JXViewBtnSave  setImage:[UIImage imageNamed:@"图层 24"] forState:UIControlStateNormal];
    [JXViewBtnSave setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateNormal];
    [JXViewBtnSave setTitle:@"15W" forState:UIControlStateNormal];
    [JXViewBtnSave.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [JXViewBtnSave addTarget:self action:@selector(JXViewBtnSaveClick:) forControlEvents:UIControlEventTouchUpInside];
    [JXView addSubview:JXViewBtnSave];
    

    UIButton *JXViewBtnPL = [UIButton buttonWithType:UIButtonTypeCustom];
    JXViewBtnPL.tag = 3001;
    [JXViewBtnPL  setImage:[UIImage imageNamed:@"图层 25"] forState:UIControlStateNormal];
    [JXViewBtnPL setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateNormal];
    [JXViewBtnPL setTitle:@"1W" forState:UIControlStateNormal];
    [JXViewBtnPL.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [JXViewBtnPL addTarget:self action:@selector(JXViewBtnSaveClick:) forControlEvents:UIControlEventTouchUpInside];
    [JXView addSubview:JXViewBtnPL];
    
    UIButton *JXViewBtnZan = [UIButton buttonWithType:UIButtonTypeCustom];
    JXViewBtnZan.tag = 3002;
    [JXViewBtnZan  setImage:[UIImage imageNamed:@"图层 26"] forState:UIControlStateNormal];
    [JXViewBtnZan setTitleColor:[UIColor colorWithHexString:@"#CCCCCC"] forState:UIControlStateNormal];
    [JXViewBtnZan setTitle:@"10W" forState:UIControlStateNormal];
    [JXViewBtnZan.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [JXViewBtnZan addTarget:self action:@selector(JXViewBtnSaveClick:) forControlEvents:UIControlEventTouchUpInside];
    [JXView addSubview:JXViewBtnZan];
    
   
    
    
    
    CGFloat topGapJXView =self.isfreeViewHidden?(390+136+5+193+5+211+5)*_Scaling:(390+80+136+5+193+5+211+5)*_Scaling;
    //fixbug 文字长短问题
    [JXView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(346*_Scaling);
        make.top.mas_equalTo(topGapJXView);
    }];
    
    [JXViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.height.mas_equalTo(16*_Scaling);
        
    }];
    [JXViewlable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(GAP);
        make.height.mas_equalTo(16*_Scaling);
        
    }];
    //xq JXViewlableCenter
    [JXViewBtnCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(46*_Scaling);
        make.right.mas_equalTo(-GAP);
        make.left.mas_equalTo(GAP);
        make.height.mas_equalTo(150*_Scaling);
        
    }];
    [JXViewlableCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(211*_Scaling);
        make.right.mas_equalTo(-GAP);
        make.left.mas_equalTo(GAP);
        make.height.mas_equalTo(32*_Scaling);
        
    }];
    [JXViewlableCenterxq mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(252*_Scaling);
        make.right.mas_equalTo(-GAP);
        make.left.mas_equalTo(GAP);
        make.height.mas_equalTo(50*_Scaling);
        
    }];
//下面的点赞
//    lineViewJXBtoom JXViewBtnSave  JXViewBtnPL JXViewBtnZan
    [lineViewJXBtoom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.height.mas_equalTo(2);
        make.top.mas_equalTo(315*_Scaling);
    }];
    
    [JXViewBtnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        make.width.mas_equalTo(45*_Scaling);
        make.height.mas_equalTo(20*_Scaling);
        make.top.mas_equalTo(320*_Scaling);
    }];
    
    [JXViewBtnPL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(75*_Scaling);
        make.width.mas_equalTo(45*_Scaling);
        make.height.mas_equalTo(20*_Scaling);
        make.top.mas_equalTo(320*_Scaling);
    }];
    [JXViewBtnZan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(132*_Scaling);
        make.width.mas_equalTo(45*_Scaling);
        make.height.mas_equalTo(20*_Scaling);
        make.top.mas_equalTo(320*_Scaling);
    }];
    
//svHeight servicBtn
    [svHeight mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(sv);
        make.bottom.mas_equalTo(JXView);
    }];

    
}
-(UIView *)topView {
    
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __kWidth, LGF_StatusAndNavBar_Height +10)];
        _topView.backgroundColor = appBgRGBColor;
//        _topView.backgroundColor = [UIColor redColor];
        
        
    }
    return _topView;
}
//event
- (void)JXViewBtnSaveClick:(UIButton *)btn{
    NSLog(@"JXViewBtnSaveClick,%ld",btn.tag);
}
- (void)JXViewBtnCenterClick:(UIButton *)btn{
    NSLog(@"JXViewBtnCenterClick,%ld",btn.tag);
}
- (void)hotTopicViewBtnCenterClick:(UIButton *)btn{
    NSLog(@"hotTopicViewBtnCenterClick,%ld",btn.tag);
}
- (void)hotTopicViewBtnMore:(UIButton *)btn{
    NSLog(@"hotTopicViewBtnMore,%ld",btn.tag);
}
- (void)servicLeftBtnClick:(UIButton *)btn{
    NSLog(@"servicLeftBtnClick,%ld",btn.tag);
}
- (void)servicBtnClick:(UIButton *)btn{
    NSLog(@"servicBtnClick,%ld",btn.tag);
}
- (void)freeViewBtnClick:(UIButton *)btn{
    NSLog(@"freeViewBtnClick,%ld",btn.tag);
    self.freeView.hidden = YES;
    self.isfreeViewHidden = YES;
    
    CGFloat topGap =self.isfreeViewHidden?390*_Scaling:390*_Scaling+80;
    
    [self.serviceView  mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topGap);
    }];
    
    CGFloat topGapFood =self.isfreeViewHidden?(390+136)*_Scaling:(390+80+136)*_Scaling;
    [self.lineViewFood mas_updateConstraints:^(MASConstraintMaker *make) {
    
        make.top.mas_equalTo(topGapFood);
    }];
    CGFloat topGapLoopPlaybackView =self.isfreeViewHidden?(390+136+5)*_Scaling:(390+80+136+5)*_Scaling;
    [self.foodView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topGapLoopPlaybackView);
    }];
    
    //hotTopicView

    CGFloat topGapFoodtp =self.isfreeViewHidden?(390+136+193)*_Scaling:(390+80+136+193)*_Scaling;
    
    [self.lineViewTp mas_updateConstraints:^(MASConstraintMaker *make) {
      
        make.top.mas_equalTo(topGapFoodtp);
    }];
    CGFloat topGaphotTopicView =self.isfreeViewHidden?(390+136+5+193+5)*_Scaling:(390+80+136+5+193+5)*_Scaling;
    [self.hotTopicView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(topGaphotTopicView);
    }];
    
    //jingxuan
    CGFloat topGaplineViewJX =self.isfreeViewHidden?(390+136+5+193+5+211)*_Scaling:(390+80+136+5+193+5+211)*_Scaling;
    
    [self.lineViewJX mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(topGaplineViewJX);
    }];
    
    CGFloat topGapJXView =self.isfreeViewHidden?(390+136+5+193+5+211+5)*_Scaling:(390+80+136+5+193+5+211+5)*_Scaling;
    //fixbug 文字长短问题
    [self.JXView mas_updateConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(topGapJXView);
    }];
    

}
- (void)seltedBtn:(UIButton *)btn{
    NSLog(@"seltedBtn,%ld",btn.tag);
}
- (void)selectedAddressClick:(UIButton *)btn{
    NSLog(@"selectedAddressClick")
}

- (void)scanBtnClick:(UIButton *)btn{
    NSLog(@"scanBtnClick")
}
- (void)cycleScrollView:(YGHomeLoopPlaybackView *)YGcycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
//    if ([YGcycleScrollView isEqual:_cycleScrollView1]) {
//
//        HomeModel *model = self.broadcasArray[index];
//        if (model.actionUrl.length > 0) {
//            YGHtmlViewController *controller = [[YGHtmlViewController alloc] init];
//            controller.hidesBottomBarWhenPushed = YES;
//            controller.infomationID = model.typeId;
//            controller.titleStr = model.typeParam;
//            controller.status = @"88";
//            controller.url = model.actionUrl;
//            //            controller.url = @"http://console.likspace.cn:9044/cList.html";
//            //            @"memberId":[UserInfo sharedUserInfo].userDic[@"id"] @"http://console.likspace.cn:9044/cList.html?memberId="
//            NSString *memberId = [UserInfo sharedUserInfo].userDic[@"id"];
//            controller.url = [NSString stringWithFormat:@"%@?memberId=%@",controller.url,memberId];
//
//            [self.navigationController pushViewController:controller animated:YES];
//        }else {
//            [self didtype:model.type typeID:model.typeId title:model.typeParam actionUrl:model.actionUrl];
//        }
//    }else if ([YGcycleScrollView isEqual:_cycleScrollView2]){
//        HomeModel *model = self.broadcas2Array[index];
//
//        if (model.actionUrl.length > 0) {
//            YGHtmlViewController *controller = [[YGHtmlViewController alloc] init];
//            controller.hidesBottomBarWhenPushed = YES;
//            controller.infomationID = model.typeId;
//            controller.titleStr = model.typeParam;
//            controller.status = @"88";
//            controller.url = model.actionUrl;
//            [self.navigationController pushViewController:controller animated:YES];
//        }else {
//            [self didtype:model.type typeID:model.typeId title:model.typeParam actionUrl:model.actionUrl];
//        }
//
//    }else if ([YGcycleScrollView isEqual:_cycleScrollView3]){
//        HomeModel *model = self.broadcas3Array[index];
//        if (model.actionUrl.length > 0) {
//            YGHtmlViewController *controller = [[YGHtmlViewController alloc] init];
//            controller.hidesBottomBarWhenPushed = YES;
//            controller.infomationID = model.typeId;
//            controller.titleStr = model.typeParam;
//            controller.status = @"88";
//            controller.url = model.actionUrl;
//            [self.navigationController pushViewController:controller animated:YES];
//        }else {
//            [self didtype:model.type typeID:model.typeId title:model.typeParam actionUrl:model.actionUrl];
//        }
//    }
}
@end

