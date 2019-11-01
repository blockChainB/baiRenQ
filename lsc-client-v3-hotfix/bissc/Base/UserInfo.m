//
//  UserInfo.m
//  clientservice
//
//  Created by 龙广发 on 2018/8/9.
//  Copyright © 湖南灵控智能科技有限公司. All rights reserved.
//

#import "UserInfo.h"
#define  Shake @"isShake"
#define  Wallet @"isWallet"

#define  userName @"username"
#define  passWord @"password"
#define  memberid @"memberId"
#define  siteid @"siteid"
#define  siteNm @"siteName"

#define  openid @"openid"
#define  tel @"tel"
#define  employeename @"employeeName"
#define  employeeID @"employeeID"
#define  companyname @"companyName"
#define  gKey @"gkey"
#define  giv @"giv"
#define  Cookie @"cookie"
#define  membertype @"memberType"
#define  passwordStatus @"payPasswordStatus"
#define  walletstatus @"walletStatus"
#define  opentime @"opentime"
#define  momenttype @"momentType"
#define  printingurl @"printingUrl"
#define  notification @"notificationUserInfo"
#define  notificationdic @"notificationDic"
#define  RIMLogin @"RCIMLogin"
#define  aoiName @"AOIName"
#define  ordertype @"orderType"
#define  userdic @"userDic"
#define  faceAuth @"faceAuth"
#define  idCardAuth @"idCardAuth"
#define  IMtoken @"imToken"
#import "YGLoginViewController.h"
#import "sys/utsname.h"
#define  Token @"token"

#define  advertisementImage @"advertisementImageUrl"
#define  AdvertisementUrl @"advertisementUrl"
#define  AdvertisementTitle @"advertisementTitle"
#define  AdvertisementCount @"advertisementCount"

#define  isAdPush @"isAd"
#define  isAppStore @"isPushAppStore"
#define  adDic @"addic"

@implementation UserInfo
singleton_implementation(UserInfo)

-(void)saveToSandbox {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.isShake forKey:Shake];
    [defaults setBool:self.isWallet forKey:Wallet];
    [defaults setBool:self.RCIMLogin forKey:RIMLogin];

    [defaults setObject:self.username forKey:userName];
    [defaults setObject:self.password forKey:passWord];
    [defaults setObject:self.memberId forKey:memberid];
    [defaults setObject:self.siteID forKey:siteid];
    [defaults setObject:self.siteName forKey:siteNm];
    [defaults setObject:self.orderType forKey:ordertype];

    [defaults setObject:self.openID forKey:openid];
    [defaults setObject:self.phone forKey:tel];
    [defaults setObject:self.employeeName forKey:employeename];
    [defaults setObject:self.employeeid forKey:employeeID];
    [defaults setObject:self.companyName forKey:companyname];
    [defaults setObject:self.gkey forKey:gKey];
    [defaults setObject:self.gIv forKey:giv];
    [defaults setObject:self.cookie forKey:Cookie];
    [defaults setObject:self.memberType forKey:membertype];
    [defaults setObject:self.payPasswordStatus forKey:passwordStatus];
    [defaults setObject:self.walletStatus forKey:walletstatus];
    [defaults setObject:self.openTime forKey:opentime];
    [defaults setObject:self.momentType forKey:momenttype];
    [defaults setObject:self.printingUrl forKey:printingurl];

    [defaults setObject:self.notificationUserInfo forKey:notification];
    [defaults setObject:self.notificationDic forKey:notificationdic];
    [defaults setObject:self.AOIName forKey:aoiName];
    
    [defaults setObject:self.userDic forKey:@"userDic"];
    [defaults setBool:self.isFacePhoto forKey:faceAuth];
    [defaults setBool:self.isIdCard forKey:idCardAuth];
    [defaults setObject:self.imToken forKey:IMtoken];

    [defaults setObject:self.advertisementImageUrl forKey:advertisementImage];
    [defaults setObject:self.advertisementUrl forKey:AdvertisementUrl];
    [defaults setObject:self.advertisementTitle forKey:AdvertisementTitle];
    [defaults setObject:self.advertisementCount forKey:AdvertisementCount];

    [defaults setObject:self.isAdStr forKey:isAdPush];
    [defaults setBool:self.isPushAppStore forKey:isAppStore];
    [defaults setObject:self.AdDic forKey:adDic];

    [defaults setObject:self.token forKey:Token];

}
-(void)loadInfoFromSandbox{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.isShake = [defaults boolForKey:Shake];
    self.isWallet = [defaults boolForKey:Wallet];
    self.RCIMLogin = [defaults boolForKey:RIMLogin];

    self.username = [defaults objectForKey:userName];
    self.password = [defaults objectForKey:passWord];
    self.memberId = [defaults objectForKey:memberid];
    self.siteID = [defaults objectForKey:siteid];
    self.siteName = [defaults objectForKey:siteNm];
    self.token = [defaults objectForKey:Token];

    self.openID = [defaults objectForKey:openid];
    self.orderType = [defaults objectForKey:ordertype];

    self.phone = [defaults objectForKey:tel];
    self.employeeName = [defaults objectForKey:employeename];
    self.employeeid = [defaults objectForKey:employeeID];
    self.companyName = [defaults objectForKey:companyname];
    self.gIv = [defaults objectForKey:giv];
    self.gkey = [defaults objectForKey:gKey];
    self.cookie = [defaults objectForKey:Cookie];
    self.memberType = [defaults objectForKey:membertype];
    self.payPasswordStatus = [defaults objectForKey:passwordStatus];
    self.walletStatus = [defaults objectForKey:walletstatus];
    self.openTime = [defaults objectForKey:opentime];
    self.momentType = [defaults objectForKey:momenttype];
    self.printingUrl = [defaults objectForKey:printingurl];
    self.notificationUserInfo = [defaults objectForKey:notification];
    self.notificationDic = [defaults objectForKey:notificationdic];
    self.AdDic   = [defaults objectForKey:adDic];
    self.AOIName = [defaults objectForKey:aoiName];
    self.userDic = [defaults objectForKey:@"userDic"];

    self.imToken = [defaults objectForKey:IMtoken];
    
    self.isFacePhoto = [defaults boolForKey:faceAuth];
    self.isIdCard = [defaults boolForKey:idCardAuth];
    
    self.advertisementImageUrl = [defaults objectForKey:advertisementImage];
    self.advertisementUrl = [defaults objectForKey:AdvertisementUrl];
    self.advertisementTitle = [defaults objectForKey:AdvertisementTitle];
    self.advertisementCount = [defaults objectForKey:AdvertisementCount];

    self.isAdStr = [defaults objectForKey:isAdPush];
    self.isPushAppStore = [defaults boolForKey:isAppStore];


}

-(void)saveRegisterInfoToSandbox
{
    
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];

    NSDictionary* dict = [defs dictionaryRepresentation];

    for(id key in dict) {

        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    
}


- (void)resetDefaults {
    
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    
    NSDictionary* dict = [defs dictionaryRepresentation];
    
    for(id key in dict) {
        
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
    
    
}


#pragma mark -- 时间戳转时间
+(NSString *) timeStampString:(NSString *)str type:(NSString *)type {
    
    
    NSTimeInterval interval    = [str doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
     
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:type];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

+(NSString *) timeStampString:(NSString *)str {

    
    NSTimeInterval interval    = [str doubleValue] / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}


#pragma mark-- 根据经纬度计算距离
+ (float)getDistance:(float)lat1 lng1:(float)lng1 lat2:(float)lat2 lng2:(float)lng2
{
    //地球半径
    int R = 6378137;
    //将角度转为弧度
    float radLat1 = [self radians:lat1];
    float radLat2 = [self radians:lat2];
    float radLng1 = [self radians:lng1];
    float radLng2 = [self radians:lng2];
    //结果
    float s = acos(cos(radLat1)*cos(radLat2)*cos(radLng1-radLng2)+sin(radLat1)*sin(radLat2))*R;
    //精度
    s = round(s* 10000)/10000;
    return  round(s);
}
+ (float)radians:(float)degrees{
    return (degrees*3.14159265)/180.0;
}

+(NSString*)getCurrentTimes{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    
    return currentTimeString;
    
}

+(NSString *) MonthdateString {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"MM"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    if ([currentTimeString isEqualToString:@"01"]) {
        currentTimeString = @"Jan";
    }else if ([currentTimeString isEqualToString:@"02"]){
        currentTimeString = @"Feb";
    }else if ([currentTimeString isEqualToString:@"03"]){
        currentTimeString = @"Mar";
    }else if ([currentTimeString isEqualToString:@"04"]){
        currentTimeString = @"Apr";
    }else if ([currentTimeString isEqualToString:@"05"]){
        currentTimeString = @"May";
    }else if ([currentTimeString isEqualToString:@"06"]){
        currentTimeString = @"Jun";
    }else if ([currentTimeString isEqualToString:@"07"]){
        currentTimeString = @"Jul";
    }else if ([currentTimeString isEqualToString:@"08"]){
        currentTimeString = @"Aug";
    }else if ([currentTimeString isEqualToString:@"09"]){
        currentTimeString = @"Sep";
    }else if ([currentTimeString isEqualToString:@"10"]){
        currentTimeString = @"Oct";
    }else if ([currentTimeString isEqualToString:@"11"]){
        currentTimeString = @"Nov";
    }else if ([currentTimeString isEqualToString:@"12"]){
        currentTimeString = @"Dec";
    }
    
        
    return currentTimeString;
}

//获取当前时间戳
+ (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}


#pragma mark -- 获取当前日期
+(NSString *)DaydateString {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"dd"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
}



// 读取本地JSON文件
+ (NSArray *)readLocalFileWithName:(NSString *)name {
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}


+ (void)callPhone:(NSString *)phoneNum {
    
    
    
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phoneNum];
    
    /// 解决iOS10及其以上系统弹出拨号框延迟的问题
    /// 方案一
    /// 10及其以上系统
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        // Fallback on earlier versions
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
    
}


+(NSString*)getCurrentTimes:(NSString *) type{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:type];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    
    return currentTimeString;
    
}

#pragma 正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    NSString *pattern = @"^1+[35789]+\\d{9}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:telNumber];
    return isMatch;
}


+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]}
                                     context:nil];
    return rect.size.width;
    
}

+ (NSString *)iphoneType {
    
    
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";

    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";

    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";

    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";

    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";

    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";

    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";

    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";

    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";

    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";

    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";

    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";

    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";

    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";

    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";

    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";

    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";

    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";

    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";

    if ([platform isEqualToString:@"iPhone9,3"]) return @"iPhone 7";

    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";

    if ([platform isEqualToString:@"iPhone9,4"]) return @"iPhone 7 Plus";

    if ([platform isEqualToString:@"iPhone10,1"]) return @"iPhone 8";

    if ([platform isEqualToString:@"iPhone10,4"]) return @"iPhone 8";

    if ([platform isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";

    if ([platform isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";

    if ([platform isEqualToString:@"iPhone10,3"]) return @"iPhone X";

    if ([platform isEqualToString:@"iPhone10,6"]) return @"iPhone X";

    if([platform isEqualToString:@"iPhone11,2"])   return@"iPhone XS";
    if ([platform isEqualToString:@"iPhone11,4"])   return@"iPhone XS Max";
    if([platform isEqualToString:@"iPhone11,6"])   return@"iPhone XS Max";
    if([platform isEqualToString:@"iPhone11,8"])   return@"iPhone XR";
    


    if ([platform isEqualToString:@"iPad1,1"]) return @"iPad 1G";

    if ([platform isEqualToString:@"iPad2,1"]) return @"iPad 2";

    if ([platform isEqualToString:@"iPad2,2"]) return @"iPad 2";

    if ([platform isEqualToString:@"iPad2,3"]) return @"iPad 2";

    if ([platform isEqualToString:@"iPad2,4"]) return @"iPad 2";

    if ([platform isEqualToString:@"iPad2,5"]) return @"iPad Mini 1G";

    if ([platform isEqualToString:@"iPad2,6"]) return @"iPad Mini 1G";

    if ([platform isEqualToString:@"iPad2,7"]) return @"iPad Mini 1G";

    if ([platform isEqualToString:@"iPad3,1"]) return @"iPad 3";

    if ([platform isEqualToString:@"iPad3,2"]) return @"iPad 3";

    if ([platform isEqualToString:@"iPad3,3"]) return @"iPad 3";

    if ([platform isEqualToString:@"iPad3,4"]) return @"iPad 4";

    if ([platform isEqualToString:@"iPad3,5"]) return @"iPad 4";

    if ([platform isEqualToString:@"iPad3,6"]) return @"iPad 4";

    if ([platform isEqualToString:@"iPad4,1"]) return @"iPad Air";

    if ([platform isEqualToString:@"iPad4,2"]) return @"iPad Air";

    if ([platform isEqualToString:@"iPad4,3"]) return @"iPad Air";

    if ([platform isEqualToString:@"iPad4,4"]) return @"iPad Mini 2G";

    if ([platform isEqualToString:@"iPad4,5"]) return @"iPad Mini 2G";

    if ([platform isEqualToString:@"iPad4,6"]) return @"iPad Mini 2G";

    if ([platform isEqualToString:@"iPad4,7"]) return@"iPad Mini 3";

    if ([platform isEqualToString:@"iPad4,8"]) return@"iPad Mini 3";

    if ([platform isEqualToString:@"iPad4,9"]) return@"iPad Mini 3";

    if ([platform isEqualToString:@"iPad5,1"]) return@"iPad Mini 4";

    if ([platform isEqualToString:@"iPad5,2"]) return@"iPad Mini 4";

    if ([platform isEqualToString:@"iPad5,3"]) return @"iPad Air 2";

    if ([platform isEqualToString:@"iPad5,4"]) return @"iPad Air 2";

    if ([platform isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7";

    if ([platform isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7";

    if ([platform isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";

    if ([platform isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9";

    if ([platform isEqualToString:@"iPad6,11"]) return @"iPad 5";

    if ([platform isEqualToString:@"iPad6,12"]) return @"iPad 5";

    if ([platform isEqualToString:@"iPad7,1"]) return @"iPad Pro 12.9 2nd";

    if ([platform isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9 2nd";

    if ([platform isEqualToString:@"iPad7,3"]) return @"iPad Pro 10.5";

    if ([platform isEqualToString:@"iPad7,4"]) return @"iPad Pro 10.5";

    if ([platform isEqualToString:@"iPad7,5"]) return @"iPad 6";

    if ([platform isEqualToString:@"iPad7,6"]) return @"iPad 6";

    if ([platform isEqualToString:@"i386"])  return @"iPhone Simulator";

    if ([platform isEqualToString:@"x86_64"])  return @"iPhone Simulator";

        

    return platform;
    
}


+ (NSString *)deviceUUID {
    
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];

}


//根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font
{
    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    
    return rect.size.height;
}


+(NSString *)filterHTMLString:(NSString *)html

{
    
    NSScanner * scanner = [NSScanner scannerWithString:html];
    
    NSString * message = nil;
    
    while([scanner isAtEnd]==NO)
        
    {
        
        [scanner scanUpToString:@"<" intoString:nil];
        
        [scanner scanUpToString:@">" intoString:&message];
        
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",message] withString:@""];
        
    }
    
    return html;
}

//正则去除标签
+(NSString *)getZZwithString:(NSString *)string{
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n"
                                                                                    options:0
                                                                                      error:nil];
    string=[regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}


+(void) code401 {
    
    UIViewController *topRootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topRootViewController.presentedViewController)
    {
        topRootViewController = topRootViewController.presentedViewController;
    }
    
    YGLoginViewController *loginVC = [YGLoginViewController  new];
    loginVC.status = @"2";
    UINavigationController *navc = [[UINavigationController alloc] initWithRootViewController:loginVC];
    [topRootViewController presentViewController:navc animated:YES completion:nil];
    
}

///date转化为字符转0000-00-00 00:00

+ (NSString *)time_dateToString:(NSDate *)date{
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString* string=[dateFormat stringFromDate:date];
    
    return string;
    
}


+(void) shareAction{
    
    NSLog(@"分享");
    
    NSArray *baseDisplaySnsPlatforms = @[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)];
    
    [UMSocialUIManager setPreDefinePlatforms:baseDisplaySnsPlatforms];
    
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建网页内容对象
        UMShareWebpageObject*shareObject = [UMShareWebpageObject shareObjectWithTitle:@"云谷客" descr:[NSString stringWithFormat:@"云谷客2.0全新上线，您的好友邀请您注册！"] thumImage:[UIImage imageNamed:@"ygk_login_icon"]];
        shareObject.webpageUrl = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@?id=%@",@"http://www.likone.cn/share/index.html",[UserInfo sharedUserInfo].userDic[@"id"]]];
        messageObject.shareObject= shareObject;
        
        
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
            
            NSDictionary *dic = @{@"siteId":[UserInfo sharedUserInfo].siteID,@"memberId":[UserInfo sharedUserInfo].userDic[@"id"],@"shareUrl":[NSString stringWithFormat:@"%@?id=%@",@"http://www.likone.cn/share/index.html",[UserInfo sharedUserInfo].userDic[@"id"]],@"type":@"0"};
            
            [YGHttpRequest POSTDataUrl:@"share/saveShareRecord" Parameters:dic callback:^(id obj) {
                NSLog(@"%@",obj);
            }];
            
            NSLog(@"分享回掉：%@",result);
            UMSocialShareResponse *re = result;
            NSLog(@"分享回掉：%@",re.message);
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else {
                
                if ([result isKindOfClass:[UMSocialShareResponse class]]) {
                    
                    UMSocialShareResponse *resp = result;
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                }else {
                    UMSocialLogInfo(@"response data is %@",result);
                    
                }
                
            }
        }];
        
    }];
}

//判断是否有emoji
+(BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar high = [substring characterAtIndex: 0];
                                
                                // Surrogate pair (U+1D000-1F9FF)
                                if (0xD800 <= high && high <= 0xDBFF) {
                                    const unichar low = [substring characterAtIndex: 1];
                                    const int codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
                                    
                                    if (0x1D000 <= codepoint && codepoint <= 0x1F9FF){
                                        returnValue = YES;
                                    }
                                    
                                    // Not surrogate pair (U+2100-27BF)
                                } else {
                                    if (0x2100 <= high && high <= 0x27BF){
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}



+ (NSString *)urlValidation:(NSString *)string {
    
    NSError *error;
        // 正则1
    
    NSString *regulaStr =@"\\bhttps?://[a-zA-Z0-9\\-.]+(?::(\\d+))?(?:(?:/[a-zA-Z0-9\\-._?,'+\\&%$=~*!():@\\\\]*)+)?";

    // 正则2

    regulaStr =@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";

    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr
                                  
                                                                                                            options:NSRegularExpressionCaseInsensitive
                                  
                                                                                                              error:&error];
    
        NSArray *arrayOfAllMatches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    
        for (NSTextCheckingResult *match in arrayOfAllMatches){
        
                NSString* substringForMatch = [string substringWithRange:match.range];
        
                 NSLog(@"检测结果：%@",substringForMatch);
        
                return substringForMatch;
        
            }
    
        return @"";
    
}

/**
 *  从图片中按指定的位置大小截取图片的一部分
 *
 *  @param image UIImage image 原始的图片
 *  @param rect  CGRect rect 要截取的区域
 *
 *  @return UIImage
 */
+ (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect{
    
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x= rect.origin.x*scale,y=rect.origin.y*scale,w=rect.size.width*scale,h=rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);
    NSLog(@"%f-%f-%f-%f",x,y,w,h);
    NSLog(@"%f",scale);

    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
//    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}

//将时间字符串转换为时间戳
+ (NSString *)timeStrToTimestamp:(NSString *)timeStr format:(NSString *)format {
    
    NSDate *date = [self timeStrToDate:timeStr format:format];
    NSTimeInterval stamp = [date timeIntervalSince1970]*1000;
    
    return [NSString stringWithFormat:@"%.0f", stamp];
}

//将时间字符串转换为时间
+ (NSDate *)timeStrToDate:(NSString *)timeStr format:(NSString *)format{
    
    NSDate *date = [[self dateFormatWith:format] dateFromString:timeStr];//@"yyyy-MM-dd HH:mm:ss"
    
//    //解决8小时时差问题
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSInteger interval = [zone secondsFromGMTForDate: date];
//    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    
    return date;
}

//获取日期格式化器
+(NSDateFormatter *)dateFormatWith:(NSString *)formatStr {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:formatStr];//@"YYYY-MM-dd HH:mm:ss"
    //设置时区
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    return formatter;
}


+ (NSString*)sha224:(NSString *)string{
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    uint8_t digest[CC_SHA224_DIGEST_LENGTH];
    
    CC_SHA224(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA224_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA224_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+ (NSString*) sha256:(NSString *)string
{
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    uint8_t digest[CC_SHA256_DIGEST_LENGTH];
    
    CC_SHA256(data.bytes, data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}
#pragma mark -- 获取当前时间戳
+(NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
}

#pragma mark - 将某个时间转化成 时间戳

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    
    //时间转时间戳的方法:
    
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    return timeSp;
}

+ (UIViewController *)jsd_getCurrentViewController{
    
    UIViewController* currentViewController = [self jsd_getRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            
            UINavigationController* navigationController = (UINavigationController* )currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
            
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            
            UITabBarController* tabBarController = (UITabBarController* )currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                
                currentViewController = currentViewController.childViewControllers.lastObject;
                
                return currentViewController;
            } else {
                
                return currentViewController;
            }
        }
    }
    return currentViewController;
}

+ (UIViewController *)jsd_getRootViewController{
    
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    NSAssert(window, @"The window is empty");
    return window.rootViewController;
}

+(NSDate *)UTCDateFromTimeStamap:(NSString *)timeStamap{
    NSTimeInterval timeInterval = [timeStamap doubleValue]/1000;
     //  /1000;传入的时间戳timeStamap如果是精确到毫秒的记得要/1000
    NSDate *UTCDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return UTCDate;
 }


+(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}

@end
