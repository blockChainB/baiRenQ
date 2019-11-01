

#import "YGPeripheryViewController.h"

#import "YGHomeTopHeaderView.h"
#import "YGHomeModel.h"
#import "HomeModel.h"
#import "YGHomeCell1.h"
#import "CHCycleScrollView.h"
#import "YGHomeLoopPlaybackView.h"
#import "YGHomeCenterHeaderView.h"
#import "YGHomeygkCell.h"
#import <CoreBluetooth/CoreBluetooth.h>
//#import "BlueShowView.h"
#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5
#import <AudioToolbox/AudioToolbox.h>
//#import "YGActivityViewController.h"
//#import "YGInformationViewController.h"
#import "YGScanViewController.h"
#import "YGHtmlViewController.h"
//#import "YGVideoViewController.h"
//#import "YGAllServiceController.h"
//#import "YGAccessViewController.h"
//#import "YGReserveViewController.h"
//#import "YGJobFairController.h"
//#import "HomeCollectionItemCell.h"
#import "YGHomeItemCell.h"
//#import "YGVistorViewController.h"
//#import "YGActivityDetailController.h"
//#import "YGEnterpriseManagerController.h"
//#import "YGClassroomListController.h"

//#import "YGHomeSearchController.h"
//#import "YGServiceDetailController.h"
//#import "YGJobReservationController.h"
//#import "YGLoginViewController.h"
#import "YGPYCellModel.h"
#import "MarqueeView.h"
#import "YG_VersionUpgrade.h"

#import "YGPYCellFoodView.h"

@interface YGPeripheryViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,YGHomeLoopPlayScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,CBCentralManagerDelegate,CBPeripheralDelegate,AMapLocationManagerDelegate,ygkCellDelegate>{
    
    CABasicAnimation *animation;
    CGFloat  lbwidth;
}

@property(nonatomic,strong) UIView *topView;


@property(nonatomic,strong)  YGHomeLoopPlaybackView *cycleScrollView3;//轮播下
@property(nonatomic,strong)  YGHomeLoopPlaybackView *cycleScrollView2;//轮播中
@property(nonatomic,strong)  YGHomeLoopPlaybackView *cycleScrollView1;//轮播上

@property(nonatomic,strong) UICollectionView *ygkCollectionView;
@property(nonatomic,strong) UICollectionView *myCollectionView;

@property(nonatomic,strong) UITableView *tableView;
@property (nonatomic ,strong)UISearchBar *searchBar;
@property (nonatomic, assign) CGFloat placeholderWidth;
@property(nonatomic,assign) float latitude;//纬度
@property(nonatomic,assign) float longitude;//经度
@property(nonatomic,strong) NSMutableArray *loactionArray;// 站点
@property(nonatomic,strong) NSDictionary *dataDic;


@property(nonatomic,strong) NSMutableArray *activeArray;
@property(nonatomic,strong) NSMutableArray *broadcasArray;
@property(nonatomic,strong) NSMutableArray *broadcas2Array;
@property(nonatomic,strong) NSMutableArray *broadcas3Array;

@property(nonatomic,strong) NSMutableArray *imageArray1;
@property(nonatomic,strong) NSMutableArray *imageArray2;
@property(nonatomic,strong) NSMutableArray *imageArray3;

@property(nonatomic,strong) NSMutableArray *classArray;
@property(nonatomic,strong) NSMutableArray *festivalArray;
@property(nonatomic,strong) NSMutableArray *notiveArray;
@property(nonatomic,strong) NSMutableArray *ygkArray;
@property(nonatomic,strong) NSMutableArray *informationArray;

@property(nonatomic,strong) JQFMDB *db;

@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

//手机设备
@property (nonatomic, strong) CBCentralManager *mCentral;
//外设设备
@property (nonatomic, strong) CBPeripheral *mPeripheral;
//特征值
@property (nonatomic, strong) CBCharacteristic *mCharacteristic;
//服务
@property (nonatomic, strong) CBService *mService;
//描述
@property (nonatomic, strong) CBDescriptor *mDescriptor;

@property (nonatomic, strong) NSMutableArray *blueList;

@property (nonatomic, strong) NSMutableArray *deviceList;

@property (nonatomic, strong) NSDictionary *blueDic;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isFirst;
@property(nonatomic,strong) UIButton *postBtn;
@property (nonatomic, strong) NSMutableArray *blueArray;
//@property (nonatomic, strong) BlueShowView *blueView;
@property (nonatomic, assign) BOOL isBlue;
@property (nonatomic, assign) BOOL yaoyiyao;

//站点切换
@property(nonatomic,strong) UIView *leftView;
@property(nonatomic,strong) UITableView *siteTableView;
@property(nonatomic,strong) UIImageView *addressImg;
@property(nonatomic,strong) UILabel *addressLabel2;
@property(nonatomic,strong) UIImageView *addressImg2;
@property(nonatomic,strong) NSArray *siteArray;

@property(nonatomic,strong) UIView *MaskView;

@property(nonatomic,strong) UIButton *weatherBtn;
@property(nonatomic,strong) NSArray *weatherArray;
@property (nonatomic, strong) MarqueeView *marqueeView;


@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,copy) NSString *version;
@property(nonatomic,strong) YG_VersionUpgrade *upgradeView;

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

@implementation YGPeripheryViewController

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
    
    //    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [btn setTitle:@"万博汇" forState:UIControlStateNormal];
    //    [btn setTitleColor:[UIColor blackColor]  forState:UIControlStateNormal];
    //    [btn setImage:[UIImage imageNamed:@"图层 23"] forState:UIControlStateNormal];
    //    [btn xbs_updateImageAlignmentToRightWithSpace:3];
    //    [btn addTarget:self action:@selector(selectedAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [self.topView addSubview:btn];
    
    
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
    [scanBtn  setImage:[UIImage imageNamed:@"图层 21"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topView addSubview:scanBtn];
    
    //layout
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.height.mas_equalTo(29*_Scaling);
        make.top.mas_equalTo(37*_Scaling);
    }];
    //    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.mas_equalTo(0);
    //        make.width.mas_equalTo(78*_Scaling);
    //        make.height.mas_equalTo(14*_Scaling);
    //        make.centerY.mas_equalTo(self.topView);
    //    }];
    //searBtn
    [searBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
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
    svContentView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    
    
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
    self.cycleScrollView1 = [[YGHomeLoopPlaybackView alloc] initWithFrame:CGRectMake(0, 0, __kWidth, 150*_Scaling) imageGroups:self.imageArray1 withPlaceHoderl:[UIImage imageNamed:@"banner 拷贝"]];
    self.cycleScrollView1.delegate = self;
    self.cycleScrollView1.scrollView.backgroundColor = appBgRGBColor;
    
    [svContentView addSubview:self.cycleScrollView1];
    
    UIView *btnView = [[UIView alloc] init];
    btnView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];   ;
    [svContentView addSubview:btnView];
    [btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(80*_Scaling);
        make.top.mas_equalTo(191*_Scaling);
    }];
    
    
    NSArray *btnTitles = @[@"领券中心",@"电影",@"商城",@"活动日历"];
    NSArray *btnImages = @[@"领券中心",@"电影",@"商城",@"活动日历"];
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
        
        [btn xbs_updateImageAlignmentToUpWithSpace:7];
        
    }
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [svContentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(2);
        make.top.mas_equalTo(270*_Scaling);
    }];
    //-70
    
    //     qywf
    UIView *serviceView = [[UIView alloc] init];
    serviceView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.serviceView= serviceView;
    [svContentView addSubview:serviceView];
    
    
    UILabel *serviceViewlable = [[UILabel alloc] init];
    serviceViewlable.textColor = [UIColor blackColor];
    serviceViewlable.text  = @"生活服务";
    [serviceViewlable setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16*_Scaling]];
    [serviceView addSubview:serviceViewlable];
    
    UIButton *servicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [servicBtn  setImage:[UIImage imageNamed:@"图层 15"] forState:UIControlStateNormal];
    [servicBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [servicBtn setTitle:@"更多" forState:UIControlStateNormal];
    [servicBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [servicBtn addTarget:self action:@selector(servicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [serviceView addSubview:servicBtn];
    [servicBtn xbs_updateImageAlignmentToRightWithSpace:2];
    
    
//    UIButton *servicLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    servicLeftBtn.tag = 2000;
//    [servicLeftBtn  setImage:[UIImage imageNamed:@"今日美食 拷贝"] forState:UIControlStateNormal];
//    [servicLeftBtn addTarget:self action:@selector(servicLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [serviceView addSubview:servicLeftBtn];
//
//
//    UIButton *servicRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    servicRightBtn.tag = 2001;
//    [servicRightBtn  setImage:[UIImage imageNamed:@"今日活动 拷贝"] forState:UIControlStateNormal];
//    [servicRightBtn addTarget:self action:@selector(servicLeftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [serviceView addSubview:servicRightBtn];
//
//
    
    UIImageView *servicLeftBtn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"今日美食 拷贝"]];
    [serviceView addSubview:servicLeftBtn];
    servicLeftBtn.tag = 2000;
    servicLeftBtn.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(servicLeftBtnClick:)];
    [servicLeftBtn addGestureRecognizer:tap];
    
    
    
    UIImageView *servicRightBtn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"今日活动 拷贝"]];
    [serviceView addSubview:servicRightBtn];
    servicRightBtn.tag = 2001;
    servicRightBtn.userInteractionEnabled = YES;
    [servicRightBtn addGestureRecognizer:tap];
    
    
    
    
    [serviceView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(270*_Scaling);
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
        
        
    }];
    
    [servicLeftBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(43*_Scaling);
        make.left.mas_equalTo(GAP);
        make.height.mas_equalTo(80*_Scaling);
        make.width.mas_equalTo(170*_Scaling);
        
    }];
    [servicRightBtn  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(43*_Scaling);
        make.right.mas_equalTo(-GAP);
        make.height.mas_equalTo(80*_Scaling);
        make.width.mas_equalTo(170*_Scaling);
        
    }];
    
    
    //lineViewTp
    UIView *lineViewTp = [[UIView alloc] init];
    self.lineViewTp = lineViewTp;
    lineViewTp.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [svContentView addSubview:lineViewTp];
    
    CGFloat topGapTp =270+136;
    [lineViewTp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(5);
        make.top.mas_equalTo(topGapTp*_Scaling);
    }];
    //hotTopicView
    UIView *hotTopicView = [[UIView alloc] init];
    hotTopicView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.hotTopicView= hotTopicView;
    [svContentView addSubview:hotTopicView];
    
    
    UILabel *hotTopicViewlable = [[UILabel alloc] init];
    hotTopicViewlable.textColor = [UIColor blackColor];
    hotTopicViewlable.text  = @"口碑推荐";
    [hotTopicViewlable setFont:[UIFont fontWithName:@"Arial-BoldMT" size:16*_Scaling]];
    [hotTopicView addSubview:hotTopicViewlable];
    
    UIButton *hotTopicViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [hotTopicViewBtn  setImage:[UIImage imageNamed:@"图层 15"] forState:UIControlStateNormal];
    [hotTopicViewBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [hotTopicViewBtn setTitle:@"更多" forState:UIControlStateNormal];
    [hotTopicViewBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [hotTopicViewBtn addTarget:self action:@selector(hotTopicViewBtnMore:) forControlEvents:UIControlEventTouchUpInside];
    [hotTopicView addSubview:hotTopicViewBtn];
    [hotTopicViewBtn xbs_updateImageAlignmentToRightWithSpace:2];
    
    
//    UIButton *hotTopicViewBtnCenter = [UIButton buttonWithType:UIButtonTypeCustom];
//    hotTopicViewBtnCenter.tag = 2000;
//    [hotTopicViewBtnCenter  setImage:[UIImage imageNamed:@"口碑推荐 拷贝"] forState:UIControlStateNormal];
//    [hotTopicViewBtnCenter addTarget:self action:@selector(hotTopicViewBtnCenterClick:) forControlEvents:UIControlEventTouchUpInside];
//    [hotTopicView addSubview:hotTopicViewBtnCenter];
    
    UIImageView *hotTopicViewBtnCenter = [[UIImageView alloc] init];
    hotTopicViewBtnCenter.tag = 2000;
    hotTopicViewBtnCenter.image = [UIImage imageNamed:@"口碑推荐 拷贝"];
    [hotTopicView addSubview:hotTopicViewBtnCenter];
    hotTopicViewBtnCenter.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hotTopicViewBtnCenterClick:)];
    [hotTopicViewBtnCenter addGestureRecognizer:tap2];

    
    
    
    CGFloat topGaphotTopicView = topGapTp + 5;
    [hotTopicView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(211*_Scaling);
        make.top.mas_equalTo(topGaphotTopicView * _Scaling);
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
    lineViewJX.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [svContentView addSubview:lineViewJX];
    
    CGFloat topGaplineViewJX =topGaphotTopicView+211 ;
    
    [lineViewJX mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(5);
        make.top.mas_equalTo(topGaplineViewJX*_Scaling);
    }];
    //附近推荐
    UIView *JXView = [[UIView alloc] init];
    JXView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    self.JXView= JXView;
    [svContentView addSubview:JXView];
    
    
    UILabel *JXViewlable = [[UILabel alloc] init];
    JXViewlable.textColor = [UIColor blackColor];
    JXViewlable.text  = @"附近推荐";
    [JXViewlable setFont: [UIFont fontWithName:@"Arial-BoldMT" size:16*_Scaling]];
    [JXView addSubview:JXViewlable];
    
    UIButton *JXViewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [JXViewBtn  setImage:[UIImage imageNamed:@"图层 15"] forState:UIControlStateNormal];
    [JXViewBtn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
    [JXViewBtn setTitle:@"更多" forState:UIControlStateNormal];
    [JXViewBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [JXViewBtn addTarget:self action:@selector(hotTopicViewBtnMore:) forControlEvents:UIControlEventTouchUpInside];
    [JXView addSubview:JXViewBtn];
    [JXViewBtn xbs_updateImageAlignmentToRightWithSpace:2];
    //fixbug
    
    YGPYCellModel *model1 = [[YGPYCellModel alloc] init];
    model1.foodImage=@"www.baidu.com";
    model1.foodName = @"大唐烧鸭";
    model1.foodStyle=@"烧鸭饭";
    model1.foodStyle1=@"烧鹅饭";
    model1.foodStyle2=@"叉烧饭";
    model1.address=@"距离万博汇·云谷50米";
    model1.isSeltedYY=false;
    model1.isLast=false;
    
    YGPYCellModel *model2 = [[YGPYCellModel alloc] init];
    model2.foodImage=@"www.baidu.com";
    model2.foodName = @"大唐烧鸭";
    model2.foodStyle=@"烧鸭饭";
    model2.foodStyle1=@"烧鹅饭";
    model2.foodStyle2=@"叉烧饭";
    model2.address=@"距离万博汇·云谷50米";
    model2.isSeltedYY=true;
    model2.isLast=true;
    
    YGPYCellFoodView *foodView1 = [[YGPYCellFoodView alloc] init];
    foodView1.model = model1;
    foodView1.yyBtnClickBlock = ^(YGPYCellModel * _Nonnull model) {
        NSLog(@"foodView1.yyBtnClickBlock");
    };
    
    
    YGPYCellFoodView *foodView2 = [[YGPYCellFoodView alloc] init];
    foodView2.model = model2;
    foodView2.yyBtnClickBlock = ^(YGPYCellModel * _Nonnull model) {
        NSLog(@" foodView2.yyBtnClickBlock");
    };
    //96高 41
    [JXView addSubview:foodView1];
    [JXView addSubview:foodView2];
    //    UIView *cellView = [self createCellView:model];
    
    
    CGFloat topGapJXView =topGaplineViewJX+5;
    //fixbug 文字长短问题
    [JXView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo((41+96*2)*_Scaling);
        make.top.mas_equalTo(topGapJXView*_Scaling);
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
    //foodView 96
    
    [foodView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(41*_Scaling);
        make.left.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.height.mas_equalTo(96*_Scaling);
        
    }];
    [foodView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo((41+96)*_Scaling);
        make.left.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.height.mas_equalTo(96*_Scaling);
        
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
    NSLog(@"JXViewBtnSaveClick");
}
- (void)JXViewBtnCenterClick:(UIButton *)btn{
    NSLog(@"JXViewBtnCenterClick");
}
- (void)hotTopicViewBtnCenterClick:(UIButton *)btn{
    NSLog(@"hotTopicViewBtnCenterClick");
}
- (void)hotTopicViewBtnMore:(UIButton *)btn{
    NSLog(@"hotTopicViewBtnMore");
}
- (void)servicLeftBtnClick:(UIButton *)btn{
    NSLog(@"servicLeftBtnClick");
}
- (void)servicBtnClick:(UIButton *)btn{
    NSLog(@"servicBtnClick");
}
- (void)freeViewBtnClick:(UIButton *)btn{
    NSLog(@"freeViewBtnClick");
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


