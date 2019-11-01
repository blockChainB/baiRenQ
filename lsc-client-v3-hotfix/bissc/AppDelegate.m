//
//  AppDelegate.m
//  clientservice
//
//  Created by 龙广发 on 2018/7/24.
//  Copyright © 湖南灵控智能科技有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import "WXApiManager.h"
#import "BaseNavigationController.h"
//#import <AlipaySDK/AlipaySDK.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#if !TARGET_OS_SIMULATOR
#import <IDLFaceSDK/IDLFaceSDK.h>
#endif
#import "FaceParameterConfig.h"
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
// 如果需要使用 idfa 功能所需要引入的头文件（可选）
#import <AdSupport/AdSupport.h>
//#import "SplashScreenView.h"
#import "SplashScreenDataManager.h"
#import <Bugly/Bugly.h>
#import "YGLoginViewController.h"
#import "XTGuidePagesViewController.h"
#import "YGPostContentController.h"
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBookDefines.h>
#import <AddressBook/ABRecord.h>
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "LasAdvertisementController.h"
@interface AppDelegate ()<JPUSHRegisterDelegate,selectDelegate,RCIMUserInfoDataSource>{
    
    UINavigationController * personNav;
}
@property (nonatomic, strong) AMapLocationManager *locationManager;

@end

@implementation AppDelegate

-(void)configUSharePlatforms {
    [UMConfigure setEncryptEnabled:YES];//打开加密传输
    [UMConfigure setLogEnabled:YES];//设置打开日志
    [UMConfigure initWithAppkey:@"5c452ff5b465f543ed000ed4" channel:@"App Store"];//友盟统计
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxa37efeb775e2e50a" appSecret:@"6df35973f359aa6b1972f760bb7dd9fa" redirectURL:@"www.likone.cn"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatTimeLine appKey:@"wxa37efeb775e2e50a" appSecret:@"6df35973f359aa6b1972f760bb7dd9fa" redirectURL:@"www.likone.cn"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"101535187" appSecret:nil redirectURL:@"www.likone.cn"];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"2847009833" appSecret:@"62efbab33a55aebfb886be33c88c8696" redirectURL:@"www.likone.cn"];
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite),@(UMSocialPlatformType_Qzone)]];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self.window makeKeyAndVisible];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [Bugly startWithAppId:@"0ceabb826d"];//腾讯bug管理
    
    
    [self configUSharePlatforms];
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager]; // 获取类库的单例变量
    
    keyboardManager.enable = YES; // 控制整个功能是否启用
    
    keyboardManager.shouldResignOnTouchOutside = YES; // 控制点击背景是否收起键盘
    
    
    [[UITabBar appearance] setTranslucent:NO];
    [[UserInfo sharedUserInfo] loadInfoFromSandbox];
    
    if ([UserInfo sharedUserInfo].siteID == nil) {
        [UserInfo sharedUserInfo].siteID = @"";
    }
    
    [UserInfo sharedUserInfo].isPushAppStore = YES;
    [[UserInfo sharedUserInfo] saveToSandbox];
    [[UserInfo sharedUserInfo] loadInfoFromSandbox];
    
    NSArray *images = @[@"智能办公",@"交流互动",@"周边商店"];

    BOOL y = [XTGuidePagesViewController isShow];
    if (!y) {

        [[UserInfo sharedUserInfo] saveToSandbox];
        [[UserInfo sharedUserInfo] loadInfoFromSandbox];

        XTGuidePagesViewController *xt = [[XTGuidePagesViewController alloc] init];
        self.window.rootViewController = xt;
        xt.delegate = self;
        [xt guidePageControllerWithImages:images];
    }else{

        [self clickEnter];

        TabBarViewController *tabar = [[TabBarViewController alloc] init];
        tabar.selectedIndex = 0;
        self.window.rootViewController = tabar;
    }

    
//
//        TabBarViewController *tabar = [[TabBarViewController alloc] init];
//        tabar.selectedIndex = 0;
//        self.window.rootViewController = tabar;
    
//        YGLoginViewController *tabar = [[YGLoginViewController alloc] init];
//    //    tabar.selectedIndex = 0;
//        self.window.rootViewController = tabar;
// [WXApi registerApp:@"wxa37efeb775e2e50a" enableMTA:YES];
    
    [WXApi registerApp:@"wxa37efeb775e2e50a" universalLink:nil];
    [AMapServices sharedServices].apiKey = @"5a66c8c1861f278c9452eb3876f40507";
    
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    // Optional
    // 获取 IDFA
    // 如需使用 IDFA 功能请添加此代码并在初始化方法的 advertisingIdentifier 参数中填写对应值
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSLog(@"advertisingId:%@",advertisingId);
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    // 如需继续使用 pushConfig.plist 文件声明 appKey 等配置内容，请依旧使用 [JPUSHService setupWithOption:launchOptions] 方式初始化。
    //    fcc394b1d9689ac055d1fc46
    [JPUSHService setupWithOption:launchOptions appKey:@"fcc394b1d9689ac055d1fc46"
                          channel:@"Publish channel"
                 apsForProduction:1
            advertisingIdentifier:advertisingId];
    
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter addObserver:self selector:@selector(networkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    [self setupFaceSDK];
    
    if ([application
         respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, 用于iOS8以及iOS8之后的系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    }
    
    //获取共享的UserDefaults
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.YGShareExtension"];
    if ([userDefaults boolForKey:@"has-new-share"])
    {
        
        YGPostContentController *ctl = [[YGPostContentController alloc] init];
        ctl.hidesBottomBarWhenPushed = YES;
        ctl.type = @"新鲜事";
        
        TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
        if([tabBar isKindOfClass:[TabBarViewController class]]){
            UINavigationController *nav = tabBar.selectedViewController;
            [nav.topViewController.navigationController pushViewController:ctl animated:YES];
        }
    }
    
    [self requestAuthorizationForAddressBook];
    self.locationManager = [[AMapLocationManager alloc] init];
    return YES;
}

/**
 * 推送处理2
 */
//注册用户通知设置
- (void)application:(UIApplication *)application
didRegisterUserNotificationSettings:
(UIUserNotificationSettings *)notificationSettings {
    // register to receive notifications
    [application registerForRemoteNotifications];
}


- (void)didReceiveMessageNotification:(NSNotification *)notification {
    
    if ([notification.object isKindOfClass:[RCMessage class]]) {
        
        RCMessage *message = notification.object;
        
        NSDictionary *dic = @{@"siteId":[UserInfo sharedUserInfo].siteID,@"memberId":[UserInfo sharedUserInfo].userDic[@"id"],@"id":message.targetId};
        
        [YGHttpRequest GETDataUrl:@"member/getMyNameAndheadPortrait" Parameters:dic callback:^(id obj) {
            NSLog(@"%@",obj);
            BOOL istrue   = [obj[@"success"] boolValue];
            if (istrue) {
                
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",obj[@"data"][@"headPortrait"]] forKey:[NSString stringWithFormat:@"%@img",message.targetId]];
                [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@",obj[@"data"][@"userName"]] forKey:[NSString stringWithFormat:@"%@name",message.targetId]];
            }
        }];
    }
}


- (void)clickEnter
{
    
    [[UserInfo sharedUserInfo] loadInfoFromSandbox];
    
    if ([[[UserInfo sharedUserInfo].userDic allKeys] count] > 0) {
        //      启动页停留1秒
        [NSThread sleepForTimeInterval:1];
        
        if ([[UserInfo sharedUserInfo].advertisementImageUrl length] > 0) {
            // 图片存在
            LasAdvertisementController *xt = [[LasAdvertisementController alloc] init];
            self.window.rootViewController = xt;
            xt.delegate = self;
            [xt guidePageControllerWithImageUrl:@{@"imgFilePath":[UserInfo sharedUserInfo].advertisementImageUrl,@"imgLinkUrl":[UserInfo sharedUserInfo].advertisementUrl,@"title":[UserInfo sharedUserInfo].advertisementTitle,@"count":[UserInfo sharedUserInfo].advertisementCount}];
        }else {
            TabBarViewController *tabar = [[TabBarViewController alloc] init];
            tabar.selectedIndex = 0;
            self.window.rootViewController = tabar;
            [self.window makeKeyWindow];
        }
        [SplashScreenDataManager getAdvertisingImageData];
        
    }else {
        YGLoginViewController *tabar = [[YGLoginViewController alloc] init];
        self.window.rootViewController = tabar;
    }
}
- (void)touchAction {
    
    TabBarViewController *tabar = [[TabBarViewController alloc] init];
    tabar.selectedIndex = 0;
    self.window.rootViewController = tabar;
    [self.window makeKeyWindow];
    
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    WXApiManager *wx = [WXApiManager sharedManager];
    
    return  [WXApi handleOpenURL:url delegate:wx];
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    NSLog(@"%@",url);
    NSLog(@"%@",url.host);
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        //        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
        //            NSLog(@"result = %@",resultDic);
        //            NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        //
        //            if ([resultDic[@"resultStatus"] integerValue] == 9000) {
        //
        //                [[NSNotificationCenter defaultCenter] postNotificationName:@"successPay" object:nil];
        //                strMsg = @"订单支付成功";
        //            }else if ([resultDic[@"resultStatus"] integerValue] == 8000){
        //                strMsg = @"订单正在处理中";
        //            }else if ([resultDic[@"resultStatus"] integerValue] == 4000){
        //                strMsg = @"订单支付失败";
        //            }else if ([resultDic[@"resultStatus"] integerValue] == 6001){
        //                strMsg = @"用户中途取消";
        //            }else if ([resultDic[@"resultStatus"] integerValue] == 6002){
        //                strMsg = @"网络连接出错";
        //            }else if ([resultDic[@"resultStatus"] integerValue] == 5000){
        //                strMsg = @"重复请求";
        //            }else if ([resultDic[@"resultStatus"] integerValue] == 6004){
        //                strMsg = @"支付结果未知";
        //            }else {
        //                strMsg = @"支付错误";
        //            }
        //
        //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        //            [alert show];
        //
        //        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        //        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
        //            NSLog(@"result = %@",resultDic);
        //            // 解析 auth code
        //            NSString *result = resultDic[@"result"];
        //            NSString *authCode = nil;
        //            if (result.length>0) {
        //                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
        //                for (NSString *subResult in resultArr) {
        //                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
        //                        authCode = [subResult substringFromIndex:10];
        //                        break;
        //                    }
        //                }
        //            }
        //            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        //        }];
        
    }else if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.xin"] && [url.absoluteString containsString:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }else if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.xin"] && [url.absoluteString containsString:@"oauth"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }else {
        if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.xin"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"aouthError" object:nil];
        }else {
            return [[UMSocialManager defaultManager] handleOpenURL:url];
        }
    }
    return YES;
    
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
}

- (void)setupFaceSDK {
#if !TARGET_OS_SIMULATOR
    NSString* licensePath = [[NSBundle mainBundle] pathForResource:FACE_LICENSE_NAME ofType:FACE_LICENSE_SUFFIX];
    NSAssert([[NSFileManager defaultManager] fileExistsAtPath:licensePath], FACE_LICENSE_ID);
    [[FaceSDKManager sharedInstance] setLicenseID:FACE_LICENSE_ID andLocalLicenceFile:licensePath];
    
    // 设置最小检测人脸阈值
    [[FaceSDKManager sharedInstance] setMinFaceSize:100];
    // 设置截取人脸图片大小
    [[FaceSDKManager sharedInstance] setCropFaceSizeWidth:100];
    // 设置人脸遮挡阀值
    [[FaceSDKManager sharedInstance] setOccluThreshold:0.5];
    // 设置亮度阀值
    [[FaceSDKManager sharedInstance] setIllumThreshold:40];
    // 设置图像模糊阀值
    [[FaceSDKManager sharedInstance] setBlurThreshold:0.7];
    // 设置头部姿态角度
    [[FaceSDKManager sharedInstance] setEulurAngleThrPitch:30 yaw:30 roll:30];
    // 设置是否进行人脸图片质量检测
    [[FaceSDKManager sharedInstance] setIsCheckQuality:YES];
    // 设置人脸检测精度阀值
    [[FaceSDKManager sharedInstance] setNotFaceThreshold:0.6];
#endif
}

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    //    [[NSUserDefaults standardUserDefaults] setObject:@{@"deviceType":@"iOS", @"deviceToken":deviceToken} forKey:@"devieceInfo"];
    
    NSString *deviceString = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceString = [deviceString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
    
}

// 接收到通知事件
- (void)networkDidReceiveMessage:(NSNotification *)notification {
    
    NSDictionary *userInfo = [notification userInfo];
    NSDictionary *dic = [self dictionaryWithJsonString:userInfo[@"content"]];
    
    if([dic[@"type"] isEqualToString:@"1"] ){
        
        if ([UserInfo sharedUserInfo].notificationUserInfo) {
            
        }else {
            
            [UserInfo sharedUserInfo].notificationDic = dic;
            [[UserInfo sharedUserInfo] saveToSandbox];
            [[UserInfo sharedUserInfo] loadInfoFromSandbox];
        }
        
    }else if ([dic[@"type"] isEqualToString:@"3"]){
        
        
    }else if ([dic[@"type"] isEqualToString:@"4"]){
        
    }
    
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"xxxxxxxxxx:%@",userInfo);
    
    // Required, iOS 7 Support
    [JPUSHService handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required, For systems with less than or equal to iOS 6
    NSLog(@"zzzzzzzz:%@",userInfo);
    
    [JPUSHService handleRemoteNotification:userInfo];
    
}



#pragma mark- JPUSHRegisterDelegate

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler  API_AVAILABLE(ios(10.0)){
    
    
    //收到推送的请求
    UNNotificationRequest *request = notification.request;
    //收到推送的内容
    UNNotificationContent *content = request.content;
    //收到用户的基本信息
    NSDictionary *userInfo = content.userInfo;
    //收到推送消息的角标
    NSNumber *badge = content.badge;
    //收到推送消息body
    NSString *body = content.body;
    //推送消息的声音
    UNNotificationSound *sound = content.sound;
    // 推送消息的副标题
    NSString *subtitle = content.subtitle;
    // 推送消息的标题
    NSString *title = content.title;
    NSLog(@"bibibi%@",content.userInfo);
    
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"bibibi%@",content.userInfo);
        
        
        [JPUSHService handleRemoteNotification:userInfo];
        
        //此处省略一万行需求代码。。。。。。
        // NSLog(@"iOS10 收到远程通知:%@",userInfo);
    }else {
        // 判断为本地通知
        //此处省略一万行需求代码。。。。。。
        NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
        
    }
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler(UNNotificationPresentationOptionBadge| UNNotificationPresentationOptionSound| UNNotificationPresentationOptionAlert);
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    
    NSLog(@"点击了");
    // Required
    //收到推送的请求
    UNNotificationRequest *request = response.notification.request;
    //收到推送的内容
    UNNotificationContent *content = request.content;
    //收到用户的基本信息
    NSDictionary *userInfo = content.userInfo;
    //收到推送消息的角标
    NSNumber *badge = content.badge;
    //收到推送消息body
    NSString *body = content.body;
    //推送消息的声音
    UNNotificationSound *sound = content.sound;
    // 推送消息的副标题
    NSString *subtitle = content.subtitle;
    // 推送消息的标题
    NSString *title = content.title;
    
    //    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
    //        NSLog(@"%@",request.content);
    //        [JPUSHService handleRemoteNotification:userInfo];
    //
    //        if([userInfo[@"type"] isEqualToString:@"1"]){
    //
    //            NSString *itunes = @"itms-apps://itunes.apple.com/cn/app/id1434962021?mt=8";
    //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:itunes]];
    //
    //        }else if ([userInfo[@"type"] isEqualToString:@"2"]){
    //
    //            YGCommunityDetailController *ctl = [[YGCommunityDetailController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //            ctl.topicId = userInfo[@"typeId"];
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //
    //        }else if ([userInfo[@"type"] isEqualToString:@"3"]){
    //
    //            YGValleyViewController *ctl = [[YGValleyViewController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //
    //
    //        }else if ([userInfo[@"type"] isEqualToString:@"4"]){
    //
    //
    //        }else if ([userInfo[@"type"] isEqualToString:@"5"]){
    //
    //            YGOrderDetailController *ctl = [[YGOrderDetailController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //            ctl.orderID = userInfo[@"typeId"];
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //
    //        }else if ([userInfo[@"type"] isEqualToString:@"6"]){
    //
    //            YGVipCenterViewController *ctl = [[YGVipCenterViewController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //        }else if ([userInfo[@"type"] isEqualToString:@"7"]){
    //
    //
    //        }else if ([userInfo[@"type"] isEqualToString:@"8"]){
    //
    //            YGCommunityDetailController *ctl = [[YGCommunityDetailController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //            ctl.topicId = userInfo[@"typeId"];
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //        }else if ([userInfo[@"type"] isEqualToString:@"9"]){
    //
    //            YGVisitListController *ctl = [[YGVisitListController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //            ctl.visitID = userInfo[@"typeId"];
    //            ctl.titleLB = userInfo[@"typeParam"];
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //        }else if ([userInfo[@"type"] isEqualToString:@"10"]){
    //
    //            YGHtmlViewController *ctl = [[YGHtmlViewController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //            ctl.status = @"99";
    //            ctl.url = userInfo[@"typeId"];
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //        }else if ([userInfo[@"type"] isEqualToString:@"11"]){
    //
    //            YGCompantDetailController *ctl = [[YGCompantDetailController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //            ctl.companyId = userInfo[@"typeId"];
    //            ctl.companyName = userInfo[@"typeParam"];
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //        }else if ([userInfo[@"type"] isEqualToString:@"12"]){
    //
    //            YGServiceDetailController *ctl = [[YGServiceDetailController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //            ctl.serviceID = userInfo[@"typeId"];
    //            ctl.tiltleLB = userInfo[@"typeParam"];
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //        }else if ([userInfo[@"type"] isEqualToString:@"13"]){
    //
    //            YGVideoViewController *ctl = [[YGVideoViewController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //            ctl.userID = userInfo[@"typeId"];
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //        }else if ([userInfo[@"type"] isEqualToString:@"14"]){
    //
    //            YGActivityDetailController *ctl = [[YGActivityDetailController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //            ctl.ID = userInfo[@"typeId"];
    //            ctl.titleStr = userInfo[@"typeParam"];
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //        }else if ([userInfo[@"type"] isEqualToString:@"15"]){
    //
    //            YGJobReservationController *ctl = [[YGJobReservationController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //            ctl.titl = @"会议室预定";
    //            ctl.roomId = userInfo[@"typeId"];
    //            ctl.time = [UserInfo getCurrentTimes:@"YYYY-MM-dd"];
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //        }else if ([userInfo[@"type"] isEqualToString:@"16"]){
    //
    //            YGJobReservationController *ctl = [[YGJobReservationController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //            ctl.titl = @"场地预定";
    //            ctl.roomId = userInfo[@"typeId"];
    //            ctl.time = [UserInfo getCurrentTimes:@"YYYY-MM-dd"];
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //        }else if ([userInfo[@"type"] isEqualToString:@"17"]){
    //
    //            YGHtmlViewController *ctl = [[YGHtmlViewController alloc] init];
    //            ctl.hidesBottomBarWhenPushed = YES;
    //            ctl.infomationID = userInfo[@"typeId"];
    //            ctl.titleStr = userInfo[@"typeParam"];
    //
    //            TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
    //            if([tabBar isKindOfClass:[TabBarViewController class]]){
    //                UINavigationController *nav = tabBar.selectedViewController;
    //                [nav.topViewController.navigationController pushViewController:ctl animated:YES];
    //            }
    //        }
    //        //此处省略一万行需求代码。。。。。。
    //        // NSLog(@"iOS10 收到远程通知:%@",userInfo);
    //    }else {
    // 判断为本地通知
    //此处省略一万行需求代码。。。。。。
    NSLog(@"iOS10 收到本地通知:{\\\\nbody:%@，\\\\ntitle:%@,\\\\nsubtitle:%@,\\\\nbadge：%@，\\\\nsound：%@，\\\\nuserInfo：%@\\\\n}",body,title,subtitle,badge,sound,userInfo);
    
    //}
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler();
}



-(void)didReceiveJPushNotification:(NSDictionary *)notiDict{
    //在这里统一处理接收通知的处理，notiDict为接收到的所有数据
}



- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    //获取共享的UserDefaults
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.YGShareExtension"];
    if ([userDefaults boolForKey:@"has-new-share"])
    {
        NSArray *datas = [userDefaults arrayForKey:@"sharedImages"];
        
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:datas.count];
        for (NSData *data in datas) {
            UIImage *image = [UIImage imageWithData:data];
            [images addObject:image];
        }
        
        YGPostContentController *ctl = [[YGPostContentController alloc] init];
        ctl.hidesBottomBarWhenPushed = YES;
        ctl.type = @"新鲜事";
        
        TabBarViewController *tabBar = (TabBarViewController *)self.window.rootViewController;
        if([tabBar isKindOfClass:[TabBarViewController class]]){
            UINavigationController *nav = tabBar.selectedViewController;
            [nav.topViewController.navigationController pushViewController:ctl animated:YES];
        }
        
    }
    
    [application setApplicationIconBadgeNumber:0];   //清除角标
    [JPUSHService setBadge:0];//同样的告诉极光角标为0了
    [application cancelAllLocalNotifications];
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        return nil;
    }
    return dic;
}

#pragma mark -- 通讯录授权

- (void)requestAuthorizationForAddressBook {
    
    if ([[UIDevice currentDevice].systemVersion floatValue]>=9.0){
        
        CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authorizationStatus == CNAuthorizationStatusNotDetermined) {
            CNContactStore *contactStore = [[CNContactStore alloc] init];
            [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    
                } else {
                    NSLog(@"授权失败, error=%@", error);
                }
            }];
        }
        
    }
}


@end
