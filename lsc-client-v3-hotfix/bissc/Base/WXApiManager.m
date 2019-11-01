//
//  WXApiManager.m
//  SDKSample
//
//  Created by Jeason on 16/07/2015.
//
//

#import "WXApiManager.h"
#import "BaseNavigationController.h"
//#import "MineModel.h"
@implementation WXApiManager

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付成功成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"successPay" object:nil];
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"用户已取消"];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 102;
        [alert show];
        
    }else  if ([resp isKindOfClass:[SendAuthResp class]]){
        switch (resp.errCode) {
            case WXSuccess:
            {
                // 返回成功，获取Code
                SendAuthResp *sendResp = resp;
                NSString *code = sendResp.code;
                
                NSDictionary *dic = @{@"code":code};

                [YGHttpRequest GETDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"login/wxLogin"] Parameters:dic callback:^(id obj) {
                    NSLog(@"%@",obj);
                    BOOL istrue   = [obj[@"success"] boolValue];
                    if (istrue) {//请求成功
                        
                        NSString *file = [NSTemporaryDirectory() stringByAppendingPathComponent:@"MineDic.data"];
                        [NSKeyedArchiver archiveRootObject:obj[@"data"][@"memberInfo"] toFile:file];
                        NSDictionary *dic2 = [NSDictionary changeType:obj[@"data"]];
                        BOOL isState  = [obj[@"data"][@"isLogin"] boolValue];
                        if (!isState) {
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"registerLogin" object:obj[@"data"][@"wxUser"]];
                        }else{

                            [UserInfo sharedUserInfo].siteID = dic2[@"memberInfo"][@"siteId"];
                            [UserInfo sharedUserInfo].token = dic2[@"memberInfo"][@"token"];

                            [UserInfo sharedUserInfo].userDic = dic2[@"memberInfo"];
                            [UserInfo sharedUserInfo].isShake = YES;
                            
                            NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.YGShareExtension"];
                            [userDefaults setObject:dic2[@"memberInfo"][@"id"] forKey:@"memberId"];
                            [userDefaults synchronize];
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"successLogin" object:nil];
                        }
                        [UserInfo sharedUserInfo].openID = [NSString stringWithFormat:@"%@",dic2[@"memberInfo"][@"openId"]];
                        [[UserInfo sharedUserInfo] saveToSandbox];
                        [[UserInfo sharedUserInfo] loadInfoFromSandbox];
                    }
                    
                }];
 
            }
                break;
                
            default:
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                                message:@"微信授权失败!"
                                                               delegate:self
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil, nil];
                [alert show];
            }
                break;
        }
        
    }
}

- (void)onReq:(BaseReq *)req {


}



@end
