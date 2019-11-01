//
//  YGMapAddressController.m
//  clientservice
//
//  Created by 龙广发 on 2019/1/7.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import "YGMapAddressController.h"
#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "YGMapAddressCell.h"
@interface YGMapAddressController ()<UISearchControllerDelegate,UISearchResultsUpdating,MAMapViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UISearchController *searchController;
@property (nonatomic, assign)CLLocationCoordinate2D currentLocationCoordinate;
//@property (nonatomic, strong)MAMapView * mapView;
@property (nonatomic, strong)AMapLocationManager *locationManager;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic,strong)AMapSearchAPI *mapSearch;
@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic ,strong)AMapPOIAroundSearchRequest *request;
@property (nonatomic ,assign)NSInteger currentPage;
@property (nonatomic ,assign)BOOL isSelectedAddress;
@property (nonatomic ,strong)NSIndexPath *selectedIndexPath;
@property (nonatomic ,strong)NSString *city;//定位的当前城市，用于搜索功能

@property (nonatomic ,strong)UITableView *searchTableView;//用于搜索的tableView
@property (nonatomic ,strong)NSArray *tipsArray;//搜索提示的数组
@property (nonatomic ,strong)NSMutableArray *remoteArray;
@property (nonatomic ,strong)AMapPOI *currentPOI;//点击选择的当前的位置插入到数组中
@property (nonatomic ,assign)BOOL isClickPoi;

@property (nonatomic ,strong)NSString *addressStr;//地址

@end

@implementation YGMapAddressController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"所在位置";
    [self setUpSearchController];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.currentPage = 1;
//    [self initMapView];
    [self.view addSubview:self.tableView];
    [self configLocationManager];
    [self locateAction];
    self.remoteArray = @[].mutableCopy;
    self.mapSearch = [[AMapSearchAPI alloc] init];
    self.mapSearch.delegate = self;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame =CGRectMake(0,0, 20, 20);
    [rightBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:kRGBColor(46, 46, 46, 1.0) forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem  *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
    
    self.request = [[AMapPOIAroundSearchRequest alloc] init];
    self.request.keywords  = @"商务住宅 | 写字楼 ";
    /* 按照距离排序. */
    self.request.sortrule = 0;
    self.request.offset = 50;
    self.request.requireExtension = YES;
    self.selectedIndexPath=[NSIndexPath indexPathForRow:-1 inSection:-1];
}

-(void) rightAction {
    
    if (self.block) {
        self.block(self.addressStr);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)setUpSearchController{
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.definesPresentationContext = YES;
    UISearchBar *bar = self.searchController.searchBar;
    bar.frame = CGRectMake(0, 0, __kWidth, 44);
    bar.barStyle = UIBarStyleDefault;
    bar.translucent = YES;
    bar.barTintColor = [UIColor groupTableViewBackgroundColor];
    bar.tintColor = [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1];
    UIImageView *view = [[[bar.subviews objectAtIndex:0] subviews] firstObject];
    view.layer.borderColor = [UIColor colorWithRed:((0xdddddd >> 16) & 0x000000FF)/255.0f green:((0xdddddd >> 8) & 0x000000FF)/255.0f blue:((0xdddddd) & 0x000000FF)/255.0 alpha:1].CGColor;
    view.layer.borderWidth = 0.7;
    
    bar.showsBookmarkButton = NO;
    UITextField *searchField = [bar valueForKey:@"searchField"];
    searchField.placeholder = @"搜索地点";
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius = 3.0f;
        searchField.layer.borderColor = [UIColor colorWithRed:((0xdddddd >> 16) & 0x000000FF)/255.0f green:((0xdddddd >> 8) & 0x000000FF)/255.0f blue:((0xdddddd) & 0x000000FF)/255.0 alpha:1].CGColor;
        searchField.layer.borderWidth = 0.7;
    }
    
    [self.view addSubview:bar];
}

//- (void)initMapView{
//    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,  44, __kWidth, 300)];
//    //    self.mapView.delegate = self;
//    self.mapView.mapType = MAMapTypeStandard;
//    self.mapView.showsScale = NO;
//    self.mapView.showsCompass = NO;
//    self.mapView.showsUserLocation = YES;
//    [self.view addSubview:self.mapView];
//
//}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 44 , __kWidth, __kHeight - 44 ) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            self.currentPage ++ ;
            self.request.page = self.currentPage;
            self.request.location = [AMapGeoPoint locationWithLatitude:self.currentLocationCoordinate.latitude longitude:self.currentLocationCoordinate.longitude];
            [self.mapSearch AMapPOIAroundSearch:self.request];
        }];
    }
    return _tableView;
}

- (UITableView *)searchTableView{
    if (_searchTableView == nil) {
        _searchTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, LGF_StatusAndNavBar_Height, __kWidth, __kHeight- LGF_StatusAndNavBar_Height ) style:UITableViewStylePlain];
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        _searchTableView.tableFooterView = [UIView new];
    }
    return _searchTableView;
}

// 定位SDK
- (void)configLocationManager {
    self.locationManager = [[AMapLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    //单次定位超时时间
    [self.locationManager setLocationTimeout:10];
    [self.locationManager setReGeocodeTimeout:10];
}

- (void)locateAction {
    
    [MBProgressHUD showSuccess:@"正在定位" toView:self.view];
    //带逆地理的单次定位
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error) {
            [MBProgressHUD showError:@"定位错误" toView:self.view];
            NSLog(@"locError:{%ld - %@};",(long)error.code,error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed) {
                return ;
            }
        }
        
//        self.mapView.delegate = self;
        //定位信息
        NSLog(@"location:%@", location);
        if (regeocode)
        {
            NSLog(@"%@",regeocode);
            [MBProgressHUD hideHUD];
            self.isClickPoi = NO;
            self.currentLocationCoordinate = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude);
            self.city = regeocode.city;
//            [self showMapPoint];
//            [self setCenterPoint];
            self.request.location = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
            self.request.page = 1;
            [self.mapSearch AMapPOIAroundSearch:self.request];

        }
    }];
    
}

//- (void)showMapPoint{
//    [_mapView setZoomLevel:15.1 animated:YES];
//    [_mapView setCenterCoordinate:self.currentLocationCoordinate animated:YES];
//}

//- (void)setCenterPoint{
//    MAPointAnnotation * centerAnnotation = [[MAPointAnnotation alloc] init];//初始化注解对象
//    centerAnnotation.coordinate = self.currentLocationCoordinate;//定位经纬度
//    centerAnnotation.title = @"";
//    centerAnnotation.subtitle = @"";
//    [self.mapView addAnnotation:centerAnnotation];//添加注解
//
//}


//#pragma mark - MAMapView Delegate
//- (MAAnnotationView *)mapView:(MAMapView *)mapView
//            viewForAnnotation:(id<MAAnnotation>)annotation {
//    if ([annotation isKindOfClass:[MAPointAnnotation class]]) {
//        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//        }
//        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
//        annotationView.pinColor = MAPinAnnotationColorPurple;
//        return annotationView;
//    }
//    return nil;
//}
//
//
//- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
//    [self.mapView removeAnnotations:self.mapView.annotations];
//
//    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
//    self.currentLocationCoordinate = centerCoordinate;
//
//    MAPointAnnotation * centerAnnotation = [[MAPointAnnotation alloc] init];
//    centerAnnotation.coordinate = centerCoordinate;
//    centerAnnotation.title = @"";
//    centerAnnotation.subtitle = @"";
//    [self.mapView addAnnotation:centerAnnotation];
//    //主动选择地图上的地点
//    if (!self.isSelectedAddress) {
//        //        self.isClickPoi = NO;
//        [self.tableView setContentOffset:CGPointMake(0,0) animated:NO];
//        self.selectedIndexPath=[NSIndexPath indexPathForRow:0 inSection:0];
//        self.request.location = [AMapGeoPoint locationWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
//        self.currentPage = 1;
//        self.request.page = self.currentPage;
//        [self.mapSearch AMapPOIAroundSearch:self.request];
//    }
//    self.isSelectedAddress = NO;
//
//}


#pragma mark -AMapSearchDelegate
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    //    self.isClickPoi = NO;
    NSLog(@"输出：%@",self.isClickPoi ?@"YES":@"NO");
    NSMutableArray *remoteArray = response.pois.mutableCopy;
    self.remoteArray = remoteArray;
    if (self.isClickPoi) {
        [remoteArray insertObject:self.currentPOI atIndex:0];
    }else {
        AMapTip *tip = [[AMapTip alloc] init];
        tip.name = @"不显示位置";
        tip.address = @"";
        [remoteArray insertObject:tip atIndex:0];
    }
    if (self.currentPage == 1) {
        self.dataArray = remoteArray;
    }else{
        NSMutableArray * moreArray = self.dataArray.mutableCopy;
        
        [moreArray addObjectsFromArray:remoteArray];
        self.dataArray = moreArray.copy;
    }
    
    if (response.pois.count< 50) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.tableView.mj_footer endRefreshing];
    }
    [self.tableView reloadData];
    
}

- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response{
    
    self.tipsArray = response.tips;
    
    AMapTip *tip = [[AMapTip alloc] init];
    tip.name = @"没有找到你的位置？";
    tip.address = @"创建新的位置";

    NSMutableArray *tipArr = [NSMutableArray array];
    
    for (int i = 0; i < self.tipsArray.count; i ++) {
        
        [tipArr addObject:self.tipsArray[i]];
    }
    [tipArr addObject:tip];
    self.tipsArray = tipArr;
    [self.searchTableView reloadData];
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.tableView) {
        return self.dataArray.count;
    }else{
        return self.tipsArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"POITableViewCell";
    YGMapAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[YGMapAddressCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
    }
    if (tableView == self.tableView) {
        AMapPOI *POIModel = self.dataArray[indexPath.row];
        
        if (POIModel.address.length == 0) {
            cell.nameLabel.text = POIModel.name;

            [cell.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(20*_Scaling);
                make.width.mas_offset(__kWidth - 40*_Scaling);
                make.height.mas_offset(50*_Scaling);
                make.top.mas_offset(0);
            }];

        }else {
            cell.nameLabel.text = POIModel.name;
            cell.addressLable.text = POIModel.address;
        }
        
        
        if (indexPath.row==self.selectedIndexPath.row){
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
            
            AMapPOI *seletedModel = self.dataArray[indexPath.row];
            self.addressStr = seletedModel.name;
        }else{
            cell.accessoryType=UITableViewCellAccessoryNone;
        }
    }else{
        NSLog(@"搜索出来的：%@",self.tipsArray[indexPath.row]);
        AMapTip *tipModel = self.tipsArray[indexPath.row];
        cell.nameLabel.text = tipModel.name;
        cell.addressLable.text = tipModel.address;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50*_Scaling;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView == tableView) {
        self.selectedIndexPath=indexPath;
        [tableView reloadData];
//        AMapPOI *POIModel = self.dataArray[indexPath.row];
//        CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake(POIModel.location.latitude, POIModel.location.longitude);
//        [_mapView setCenterCoordinate:locationCoordinate animated:YES];
        self.isSelectedAddress = YES;
    }else{
        
        if (indexPath.row == self.tipsArray.count - 1) {

            YGCreateAddressController *controller = [[YGCreateAddressController alloc] init];
            controller.hidesBottomBarWhenPushed = YES;
            controller.block = ^(NSString *address) {
                NSLog(@"%@",address);
                self.tableView.frame = CGRectMake(0, 44, __kWidth, __kHeight - 44);
                self.searchController.active = NO;
                [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
                
                AMapPOI *POIModel = [AMapPOI new];
                POIModel.address = @"";
                POIModel.name = address;
                self.currentPOI = POIModel;
                self.isClickPoi = YES;
                [self.tableView reloadData];

            };
            [self.navigationController pushViewController:controller animated:YES];
            
        }else {
//            self.searchController.active = NO;
//            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            AMapTip *tipModel = self.tipsArray[indexPath.row];
////            CLLocationCoordinate2D locationCoordinate = CLLocationCoordinate2DMake(tipModel.location.latitude, tipModel.location.longitude);
////            [_mapView setCenterCoordinate:locationCoordinate animated:YES];
//            self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//
//            self.request.location = [AMapGeoPoint locationWithLatitude:tipModel.location.latitude longitude:tipModel.location.longitude];
//            self.currentPage = 1;
//            self.request.page = self.currentPage;
//            [self.mapSearch AMapPOIAroundSearch:self.request];
//            [self.tableView reloadData];
            
            AMapPOI *POIModel = [AMapPOI new];
            POIModel.address = [NSString stringWithFormat:@"%@%@",tipModel.district,tipModel.address];
            POIModel.location = tipModel.location;
            POIModel.name = tipModel.name;
//            self.currentPOI = POIModel;
//            self.isClickPoi = YES;
//            [self.tableView reloadData];
            
            if (self.block) {
                self.block(tipModel.name);
            }
            [self.navigationController popViewControllerAnimated:YES];

        }
    }
    
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.searchTableView) {
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    }
}




#pragma mark - UISearchControllerDelegate && UISearchResultsUpdating

//谓词搜索过滤
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text.length == 0) {
        return;
    }
    [self.view addSubview:self.searchTableView];
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = searchController.searchBar.text;
    tips.city = self.city;
    [self.mapSearch AMapInputTipsSearch:tips];
    
}


#pragma mark - UISearchControllerDelegate代理
- (void)willPresentSearchController:(UISearchController *)searchController{
    self.searchController.searchBar.frame = CGRectMake(0, 0, self.searchController.searchBar.frame.size.width, 44.0);
//    self.mapView.frame = CGRectMake(0, LGF_StatusAndNavBar_Height, __kWidth, 300);
    self.tableView.frame = CGRectMake(0, LGF_StatusAndNavBar_Height, __kWidth, __kHeight - LGF_StatusAndNavBar_Height);
    NSLog(@"ss---%@",NSStringFromCGRect(self.tableView.frame));
    
}

- (void)didDismissSearchController:(UISearchController *)searchController{
    self.searchController.searchBar.frame = CGRectMake(0,  0, self.searchController.searchBar.frame.size.width, 44.0);
//    self.mapView.frame = CGRectMake(0, 44, __kWidth, 300);
    self.tableView.frame = CGRectMake(0, 44, __kWidth, __kHeight - 44);
    [self.searchTableView removeFromSuperview];
}



- (void)localButtonAction{
    [self locateAction];
}






@end




@interface YGCreateAddressController ()

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UILabel *titleLb;
@property(nonatomic,strong) UITextField *addressTF;

@end

@implementation YGCreateAddressController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = appBgRGBColor;
    self.title = @"创建位置";
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame =CGRectMake(0,0, 20, 20);
    [rightBtn setTitle:@"完成" forState:(UIControlStateNormal)];
    [rightBtn setTitleColor:kRGBColor(46, 46, 46, 1.0) forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem  *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;

    [self setUI];
}

-(void) setUI {
    
    
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, __kWidth, 44)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bgView];
    
    _titleLb = [[UILabel alloc] initWithFrame:CGRectMake(15*_Scaling, 0, 80, 44)];
    _titleLb.font = [UIFont boldSystemFontOfSize:16];
    _titleLb.textAlignment = NSTextAlignmentLeft;
    _titleLb.textColor = kRGBColor(46, 46, 46, 1.0);
    _titleLb.text = @"位置名称";
    [self.bgView addSubview:_titleLb];
    
    _addressTF = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, __kWidth - 120, 44)];
    _addressTF.placeholder = @"请输入地址名称";
    _addressTF.textColor = kRGBColor(46, 46, 46, 1.0);
    _addressTF.font = [UIFont boldSystemFontOfSize:16];
    _addressTF.textAlignment = NSTextAlignmentLeft;
    [self.bgView addSubview:_addressTF];
}



-(void)rightAction {
    
    [self.addressTF resignFirstResponder];
    
//    if (self.block) {
//        self.block(self.addressTF.text);
//    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CreateAddress" object:self.addressTF.text];

    UIViewController *controller = self.navigationController.viewControllers[1];
    [self.navigationController popToViewController:controller animated:YES];

    [self.navigationController popViewControllerAnimated:YES];
}

-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.addressTF resignFirstResponder];

}

@end
