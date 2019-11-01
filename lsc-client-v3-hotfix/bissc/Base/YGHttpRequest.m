//
//  YGHttpRequest.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/1.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGHttpRequest.h"
#import "sys/utsname.h"
#import "Reachability.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "YGLoginViewController.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif



@implementation YGHttpRequest

#pragma mark -- Post 请求
+(void)POSTDataUrl:(NSString *)url
        Parameters:(NSDictionary *)parameters
          callback:(MyCallback)callback {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];

    NSString* URLString;
    if (![[url substringToIndex:4] isEqualToString:@"http"]) {
        URLString = [NSString stringWithFormat:@"%@%@",_V2URL,url];
    }else{
        URLString = url;
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setDictionary:parameters];
    [[UserInfo sharedUserInfo] loadInfoFromSandbox];
    if ([[[UserInfo sharedUserInfo].userDic allKeys] count] > 0) {
        [manager.requestSerializer setValue:[UserInfo sharedUserInfo].token forHTTPHeaderField:@"Authorization"];
    }
    
    NSString *ReachableVia;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.hcios.com"];
    switch([reach currentReachabilityStatus]){
            
        case ReachableViaWWAN:
        {
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            NSString *currentStatus = info.currentRadioAccessTechnology;
            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                ReachableVia = @"2G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                ReachableVia = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                ReachableVia = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                ReachableVia = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                ReachableVia = @"4G";
            }
        }
            break;
        case ReachableViaWiFi:
            ReachableVia = @"WIFI";
            break;
        default:
            ReachableVia = @"";
            break;
    }
    [dic setObject:@"IOS" forKey:@"phoneType"];
    [dic setObject:[UserInfo deviceUUID] forKey:@"phoneVersion"];
    [dic setObject:ReachableVia forKey:@"netWork"];
    [dic setObject:[UserInfo iphoneType] forKey:@"phoneModel"];
    if (![[dic allKeys] containsObject:@"siteId"]) {
        [dic setObject:[[UserInfo sharedUserInfo].siteID length] > 0?[UserInfo sharedUserInfo].siteID:@"" forKey:@"siteId"];
    }
    if (![[dic allKeys] containsObject:@"orgId"]) {
        [dic setObject:[[UserInfo sharedUserInfo].userDic[@"orgId"] length] > 0 ?[UserInfo sharedUserInfo].userDic[@"orgId"]:@"" forKey:@"orgId"];
    }
    if (![[dic allKeys] containsObject:@"memberId"]) {
        [dic setObject:[[UserInfo sharedUserInfo].userDic[@"id"] length] > 0 ?[UserInfo sharedUserInfo].userDic[@"id"]:@"" forKey:@"memberId"];
    }

    NSLog(@"参数：%@",dic);
    NSLog(@"路径：%@",URLString);

    [manager POST:URLString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        callback(responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSHTTPURLResponse  *responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode == 401) {
            [YGHttpRequest code401];
        }else if (responses.statusCode != 200) {
            [MBProgressHUD showError:@"服务异常，请稍后再试"];
        }
    }];
    


}

#pragma mark -- GET 请求
+(void)GETDataUrl:(NSString *)url
       Parameters:(NSDictionary *)parameters
         callback:(MyCallback)callback {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setDictionary:parameters];
    
    if ([[[UserInfo sharedUserInfo].userDic allKeys] count] > 0) {
        [manager.requestSerializer setValue:[UserInfo sharedUserInfo].token forHTTPHeaderField:@"Authorization"];
    }
    NSString* URLString;
    if (![[url substringToIndex:4] isEqualToString:@"http"]) {
        URLString = [NSString stringWithFormat:@"%@%@",_V2URL,url];
    }else{
        URLString = url;
    }

    NSString *ReachableVia;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.hcios.com"];
    
    switch([reach currentReachabilityStatus]){
            
            case ReachableViaWWAN:
            
            {
                CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
                NSString *currentStatus = info.currentRadioAccessTechnology;
                
                if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                    
                    ReachableVia = @"2G";
                }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                    
                    ReachableVia = @"3G";
                }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                    
                    ReachableVia = @"3G";
                }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                    
                    ReachableVia = @"3G";
                }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                    
                    ReachableVia = @"4G";
                }
            }
               break;
          case ReachableViaWiFi:
               ReachableVia = @"WIFI";
               break;
            default:
                ReachableVia = @"";
                break;
    }

    [dic setObject:@"IOS" forKey:@"phoneType"];
    [dic setObject:[UserInfo deviceUUID] forKey:@"phoneVersion"];
    [dic setObject:ReachableVia forKey:@"netWork"];
    [dic setObject:[UserInfo iphoneType] forKey:@"phoneModel"];
    
    if (![[dic allKeys] containsObject:@"siteId"]) {
        [dic setObject:[[UserInfo sharedUserInfo].siteID length] > 0?[UserInfo sharedUserInfo].siteID:@"" forKey:@"siteId"];
    }
    if (![[dic allKeys] containsObject:@"orgId"]) {
        [dic setObject:[[UserInfo sharedUserInfo].userDic[@"orgId"] length] > 0 ?[UserInfo sharedUserInfo].userDic[@"orgId"]:@"" forKey:@"orgId"];
    }
    if (![[dic allKeys] containsObject:@"memberId"]) {
        [dic setObject:[[UserInfo sharedUserInfo].userDic[@"id"] length] > 0 ?[UserInfo sharedUserInfo].userDic[@"id"]:@"" forKey:@"memberId"];
    }

    NSLog(@"参数：%@",dic);
    NSLog(@"路径：%@",URLString);

    [manager GET:URLString parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(responseObject);
        NSLog(@"%@",responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);

        NSHTTPURLResponse  *responses = (NSHTTPURLResponse *)task.response;
        NSLog(@"%ld",responses.statusCode);
        if (responses.statusCode == 401) {
            [YGHttpRequest code401];
        }else if (responses.statusCode != 200) {
            [MBProgressHUD showError:@"服务异常，请稍后再试"];
        }
    }];
}

+(void) code401 {
    
    [UserInfo sharedUserInfo].isShake = NO;
    
    [[RCIM sharedRCIM] logout];
    /**
     *  清除Cookie,如比在用户重新登录的时候需要用的着
     */
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *_tmpArray = [NSArray arrayWithArray:[cookieStorage cookies]];
    for (id obj in _tmpArray) {
        [cookieStorage deleteCookie:obj];
    }
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.YGShareExtension"];
    [userDefaults setObject:@"" forKey:@"memberId"];
    [userDefaults synchronize];
    
    // 退出登录
#pragma mark - 推送,用户退出,别名去掉
    
    [JPUSHService setAlias:@"" callbackSelector:nil object:self];
    [JPUSHService cleanTags:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
        NSLog(@"%tu,%@,%tu",iResCode,iTags,seq);
    } seq:1];
    
    
    [UserInfo sharedUserInfo].userDic = @{};
    [UserInfo sharedUserInfo].token = @"";
    [[UserInfo sharedUserInfo] saveToSandbox];
    [[UserInfo sharedUserInfo] loadInfoFromSandbox];
    
    
    UIViewController *topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topRootViewController.presentedViewController)
    {
        topRootViewController = topRootViewController.presentedViewController;
    }
    YGLoginViewController *loginVC = [YGLoginViewController  new];
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    if (![[UserInfo jsd_getCurrentViewController] isKindOfClass:[YGLoginViewController class]]) {
        [topRootViewController presentViewController:navc animated:YES completion:nil];
    }

}

#pragma mark --获取天气
+(void)WeatherDataParameters:(NSDictionary *)parameters
             callback:(MyCallback)callback {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString* URLString = [NSString stringWithFormat:@"%@",@"https://api.seniverse.com/v3/weather/now.json?"];
    
    [manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(responseObject);
        NSLog(@"天气%@",responseObject);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",task);
        NSLog(@"%@",error);

    }];
}

+(void)getfindByAppVersioncallback:(MyCallback)callback{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.HTTPShouldHandleCookies = YES;
    [[UserInfo sharedUserInfo] loadInfoFromSandbox];
    
    NSString* URLString = [NSString stringWithFormat:@"%@%@",_V2URL,@"/versionUpdate/findIOSVersionUpdate"];
    [manager GET:URLString parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        callback(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
        
    }];
}

#pragma mark -- 上传文件
+(void)uploadfiles:(NSString *)files
              images:(NSArray *)images
              type:(NSString *)type
          callback:(MyCallback)callback{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary * requestParameters = @{@"siteId":[UserInfo sharedUserInfo].userDic[@"siteId"],@"createPerson":[UserInfo sharedUserInfo].userDic[@"userName"],@"orgId":[UserInfo sharedUserInfo].userDic[@"orgId"],@"type":[type length] > 0?type:@""};
    
    NSString* URLString = [NSString stringWithFormat:@"%@%@",_YGURL,@"file/uploadFile"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // 设置时间格式
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    NSLog(@"%@",URLString);
    
    [manager POST:URLString parameters:requestParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < images.count; i++) {
            
            UIImage *image = images[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:files fileName:fileName mimeType:@"image/jpeg/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSHTTPURLResponse  *responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode == 401) {
            [YGHttpRequest code401];
        }
    }];
}

#pragma mark --  人脸识别上传
+(void)faceimagebase64:(NSString *)imagebase64
              callback:(MyCallback)callback {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary * requestParameters = @{@"Cookie":[UserInfo sharedUserInfo].cookie,@"imgBase64":imagebase64
                                         };
    NSString* URLString = [NSString stringWithFormat:@"%@%@",@"http://47.106.120.66:8082/v2/",@"face/verificationApi"];
    
    [manager POST:URLString parameters:requestParameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        NSHTTPURLResponse  *responses = (NSHTTPURLResponse *)task.response;
        if (responses.statusCode == 401) {
            [YGHttpRequest code401];
        }
    }];
}


#pragma mark -- 发现上传图片
+(void)saveTopicuploadfiles:(NSString *)files
                     images:(NSArray *)images
                   callback:(MyCallback)callback {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary * requestParameters = @{@"siteId":[UserInfo sharedUserInfo].userDic[@"siteId"],@"orgId":[UserInfo sharedUserInfo].userDic[@"orgId"],@"type":@"likSpace-app-topic",@"createPerson":[UserInfo sharedUserInfo].userDic[@"userName"]};
    
    NSString* URLString = [NSString stringWithFormat:@"%@%@",_YGURL,@"file/uploadFile"];
    
    [manager POST:URLString parameters:requestParameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < images.count; i++) {
            
            UIImage *image = images[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
            
            // 在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            // 要解决此问题，
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString  stringWithFormat:@"%@.jpg", dateString];
            /*
             *该方法的参数
             1. appendPartWithFileData：要上传的照片[二进制流]
             2. name：对应网站上[upload.php中]处理文件的字段（比如upload）
             3. fileName：要保存在服务器上的文件名
             4. mimeType：上传的文件的类型
             */
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg/png"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        callback(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
        
    }];
}

@end
