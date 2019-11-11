//
//  TabBarViewController.m
//  clientservice
//
//  Created by 龙广发 on 2018/7/24.
//  Copyright © 湖南灵控智能科技有限公司. All rights reserved.
//
#import "MYHostHomeMode.h"
#import "TabBarViewController.h"
#import "BaseNavigationController.h"
//#import "HomeModel.h"
#import "UITabBarItem+WebCache.h"
#import "ZYImageCacheManager.h"
//#import "AmarketViewController.h"
//#import "YGHomeViewController.h"
//#import "YGServiceViewController.h"
//#import "YGCommunityController.h"
//#import "AmarkHomeViewController.h"
//#import "YGMineController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBookDefines.h>
#import <AddressBook/ABRecord.h>

@interface TabBarViewController ()<UITabBarControllerDelegate,UITabBarDelegate,RCIMUserInfoDataSource,RCIMConnectionStatusDelegate,AMapLocationManagerDelegate>

@property(nonatomic,strong) LasFMDB * db;
@property(nonatomic,strong) JQFMDB * jqdb;

@end

@implementation TabBarViewController

//实现代理方法，以个人信息为例：
- (void)getUserInfoWithUserId:(NSString *)userId
                   completion:(void (^)(RCUserInfo *userInfo))completion
{
    NSLog(@"消息用户ID：%@",userId);
    
    if (![userId isEqualToString:[UserInfo sharedUserInfo].userDic[@"id"]]) {
        
        RCUserInfo *user = [RCUserInfo new];
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@img",userId]]) {
            user.portraitUri = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@img",userId]];
        }
        if ([[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@name",userId]]) {
            user.name = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@name",userId]];
        }
        [[RCIM sharedRCIM] refreshUserInfoCache:user withUserId:userId];
        return completion(user);
 
    }else {
        RCUserInfo *userA = [[RCUserInfo alloc] init];
        userA.userId = userId;
        userA.name= [UserInfo sharedUserInfo].userDic[@"userName"];
        userA.portraitUri = [UserInfo sharedUserInfo].userDic[@"headportrait"];
        
        return completion(userA);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.delegate = self;


    self.db = [[LasFMDB alloc] init];
    [self.db createAllTable];
    
    _jqdb = [JQFMDB shareDatabase];
    
    [[RCIM sharedRCIM] initWithAppKey:@"82hegw5u8xulx"];//融云即时通讯
    [RCIM sharedRCIM].enablePersistentUserInfoCache = YES;

    if ([[UserInfo sharedUserInfo].userDic[@"id"] length] > 0) {
        [self getIMToken];
    }
    [self createTabBar];
    
    [self getmyAddressbook];
}


- (void)getmyAddressbook {
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authorizationStatus == CNAuthorizationStatusAuthorized) {
        NSLog(@"没有授权...");
    }
    NSMutableArray *userArray = [NSMutableArray array];
    // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        NSMutableDictionary *nameDd = [NSMutableDictionary dictionary];
        
        NSString *nameStr = [NSString stringWithFormat:@"%@%@",contact.familyName,contact.givenName];
        
        NSArray *phoneNumbers = contact.phoneNumbers;
        
        for (CNLabeledValue *labelValue in phoneNumbers) {
            
            CNPhoneNumber *phoneNumber = labelValue.value;
            [nameDd setObject:nameStr forKey:@"name"];
            [nameDd setObject:[NSString stringWithFormat:@"%@",[phoneNumber.stringValue stringByReplacingOccurrencesOfString:@" " withString:@""]] forKey:@"phone"];
            [userArray addObject:nameDd];
        }
    }];
    
    if ([[[UserInfo sharedUserInfo].userDic allKeys] count] > 0) {
        
        NSDictionary *dic = @{@"memberId":[UserInfo sharedUserInfo].userDic[@"id"],@"list":userArray};
        [YGHttpRequest POSTDataUrl:@"member/getContactWay" Parameters:dic callback:^(id obj) {
            NSLog(@"%@",obj);
        }];
    }
}

-(void) getIMToken {
    
    NSDictionary *dic = @{
                          @"deviceUUID":[UserInfo deviceUUID],
                          @"name":[UIDevice currentDevice].name
                          
                          };
    
    [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_MYHOST,@"api/v1/login/sign"] Parameters:dic callback:^(id obj) {
        NSLog(@"obj",obj);
        if ([obj[@"code"] isEqualToValue:[NSNumber numberWithInteger:200] ]) {
            [MBProgressHUD showSuccess:@"登陆成功" toView:self.view];
            
            MYHostHomeMode *model = [MYHostHomeMode mj_objectWithKeyValues:obj[@"data"]];
            
            [[UserInfo sharedUserInfo].userDic setValue:model.portrait forKey:@"headportrait"];
            [[UserInfo sharedUserInfo].userDic setValue:model.name forKey:@"userName"];
            
            NSString *token = model.token;
            
            [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
                NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
                
                [[RCIM sharedRCIM] setUserInfoDataSource:self];
                
                RCUserInfo *info = [[RCUserInfo alloc] initWithUserId:userId name:[UserInfo sharedUserInfo].userDic[@"userName"] portrait:[UserInfo sharedUserInfo].userDic[@"headportrait"]];
                [RCIM sharedRCIM].currentUserInfo = info;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [[NSNotificationCenter defaultCenter]
                     addObserver:[[UIApplication sharedApplication] delegate]
                     selector:@selector(didReceiveMessageNotification:)
                     name:RCKitDispatchMessageNotification
                     object:nil];
                    
                });
                
            } error:^(RCConnectErrorCode status) {
                NSLog(@"登陆的错误码为:%ld", status);
            } tokenIncorrect:^{
                NSLog(@"token错误");
            }];
            
            
        }
        
    } ];
    
    
}


//创建tabbar
- (void)createTabBar
{
        NSDictionary *dataDic;
        NSArray *dataArray = [self.jqdb jq_lookupTable:@"YG_home" dicOrModel:[YGJsonModel class] whereFormat:nil];
        for (YGJsonModel *model in dataArray) {
            
            NSData *data = [model.jsonDetails dataUsingEncoding:NSUTF8StringEncoding];
            dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        }
    
        if ([dataDic[@"tab"][@"tab"] count] == 5) {

            NSMutableArray * textColorArr = [NSMutableArray array];
            NSMutableArray * seletedTextColorArr = [NSMutableArray array];
            //试图数组
            NSArray* controllerArr;
            //标题数组
            NSMutableArray* titleArr = [NSMutableArray array];
            //图片数组
            NSMutableArray* picArr = [NSMutableArray array];
            NSMutableArray* picSelectArr = [NSMutableArray array];
            
            for (NSDictionary *dic in dataDic[@"tab"][@"tab"]) {
                
                [titleArr addObject:dic[@"name"]];
                [picArr addObject:dic[@"clickFrontImg"]];
                [picSelectArr addObject:dic[@"clickAfterImg"]];
                [textColorArr addObject:dic[@"clickFrontTextColor"]];
                [seletedTextColorArr addObject:dic[@"clickAfterTextColor"]];
            }
            //试图数组
            controllerArr = @[@"YGHomeViewController",@"YGCommunityController",@"AmarketViewController",@"YGServiceViewController",@"YGMineController"];

            NSMutableArray* array = [[NSMutableArray alloc]init];
            
            for(int i=0; i<picArr.count; i++)
            {
                Class cl=NSClassFromString(controllerArr[i]);
                
                UIViewController* controller = [[cl alloc]init];
                BaseNavigationController* nv = [[BaseNavigationController alloc]initWithRootViewController:controller];
                
                controller.title = titleArr[i];
                
                //设置选中时字体的颜色(也可更改字体大小)
                [nv.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:greenRGBColor} forState:UIControlStateSelected];
                
                [nv.tabBarItem zy_setImageWithURL:picArr[i] placeholderImage:[UIImage imageNamed:@""]];
                [nv.tabBarItem zy_setSelectImageWithURL:picSelectArr[i] placeholderImage:[UIImage imageNamed:@""]];
                
                
                [nv.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:textColorArr[i]],NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
                [nv.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:seletedTextColorArr[i]],NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
                
                [array addObject:nv];
            }
            self.selectedIndex = 0;
            self.viewControllers = array;
 
        }else {
            //试图数组
            NSArray* controllerArr;
            //标题数组
            NSArray* titleArr;
            //图片数组
            NSArray* picArr;
            NSArray* picSelectArr;
            
            //试图数组
            controllerArr = @[@"YGHomeViewController",@"YGCommunityController",@"YGPeripheryViewController",@"YGMineController"];
            //标题数组
            titleArr = @[@"云谷",@"社群",@"周边",@"我的"];
            //图片数组
            picArr = @[@"首页.png",@"社群.png",@"周边.png",@"我的.png"];
            picSelectArr = @[@"首页选中.png",@"社群选中.png",@"周边选中.png",@"我的选中.png"];
            
            
            NSMutableArray* array = [[NSMutableArray alloc]init];
            
            for(int i=0; i<picArr.count; i++)
            {
                Class cl=NSClassFromString(controllerArr[i]);
                
//                UIViewController* controller = [[ViewController alloc]init];
                 UIViewController* controller = [[cl alloc]init];
                BaseNavigationController* nv = [[BaseNavigationController alloc]initWithRootViewController:controller];
                
                controller.title = titleArr[i];
                
                nv.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",picArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                //设置选中时的图片
                nv.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",picSelectArr[i]]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
                //设置选中时字体的颜色(也可更改字体大小)
                [nv.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]} forState:UIControlStateSelected];
                [nv.tabBarItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
                
                [array addObject:nv];
                
            }
            self.viewControllers = array;
        }
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    
    BaseNavigationController *navCtrl = (BaseNavigationController *)viewController;
    
    UIViewController *rootCtrl = navCtrl.topViewController;
    
//    if([rootCtrl isKindOfClass:[UIViewController class]]) {
//
////        AmarkHomeViewController *viewController = [[AmarkHomeViewController alloc] init];
//UIViewController *viewController = [[UIViewController alloc] init];
//        viewController.hidesBottomBarWhenPushed = YES;
//        [UIView transitionWithView:((BaseNavigationController *)tabBarController.selectedViewController).view
//                          duration:0.5
//                           options:UIViewAnimationOptionTransitionFlipFromRight
//                        animations:^{
//                            [((BaseNavigationController *)tabBarController.selectedViewController) pushViewController:viewController animated:YES];
//                        }
//                        completion:nil];
//        return NO;
//    }
    return YES;
}




@end
