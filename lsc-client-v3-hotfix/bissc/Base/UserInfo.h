//
//  UserInfo.h
//  clientservice
//
//  Created by 龙广发 on 2018/8/9.
//  Copyright © 湖南灵控智能科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Singleton.h"

@interface UserInfo : NSObject
singleton_interface(UserInfo)


@property (nonatomic,assign)BOOL isShake;// 摇一摇
@property (nonatomic,assign)BOOL isWallet;//

@property (nonatomic,copy)NSString  *imToken;

@property (nonatomic,copy)NSString  *advertisementImageUrl;
@property (nonatomic,copy)NSString  *advertisementUrl;
@property (nonatomic,copy)NSString  *advertisementTitle;
@property (nonatomic,copy)NSString  *advertisementCount;

@property (nonatomic,copy)NSString *isAdStr;//跳转广告
@property (nonatomic,assign)BOOL isPushAppStore;//显示版本升级


@property (nonatomic,copy)NSString  *username;
@property (nonatomic,copy)NSString  *password;
@property (nonatomic,copy)NSString  *memberId;

@property (nonatomic,copy)NSString  *memberType;

@property (nonatomic,copy)NSString  *siteID;
@property (nonatomic,copy)NSString  *phone;
@property (nonatomic,copy)NSString  *siteName;

@property (nonatomic,copy)NSString  *openID;
@property (nonatomic,copy)NSString  *employeeName;
@property (nonatomic,copy)NSString  *employeeid;
@property (nonatomic,copy)NSString  *companyName;

@property (nonatomic,copy)NSString  *gkey;
@property (nonatomic,copy)NSString  *gIv;

@property (nonatomic,copy)NSString  *cookie;

@property (nonatomic,copy)NSString  *payPasswordStatus; //1 已设置支付密码。2.未设置
@property (nonatomic,copy)NSString  *walletStatus; //1 已开通。2.未开通

@property (nonatomic,copy)NSString  *AOIName;

@property (nonatomic,copy)NSString *openTime;//

@property (nonatomic,copy)NSString *orderType;//订单类型

@property (nonatomic,copy)NSString  *token;

@property (nonatomic,copy)NSString *momentType;// 1 动态。2.需求
@property (nonatomic,copy)NSString  *printingUrl;//云打印

@property (nonatomic,strong)NSDictionary  *notificationUserInfo;//推送哪里来

@property (nonatomic,strong)NSDictionary  *notificationDic;//推送内容

@property (nonatomic,assign)BOOL opendetailComment;//动态详情评论

@property (nonatomic,strong)NSDictionary  *AdDic;//广告

@property (nonatomic,assign)BOOL RCIMLogin;//融云登录

@property (nonatomic,strong)NSDictionary  *userDic;//用户信息

@property (nonatomic,assign)BOOL isFacePhoto;//人脸上传

@property (nonatomic,assign)BOOL isIdCard;//身份证上传

-(void)saveToSandbox;
-(void)loadInfoFromSandbox;
-(void)saveRegisterInfoToSandbox;

//获取当前时间戳
+ (NSString *)currentTimeStr;
#pragma mark -- 获取当前时间
+(NSString*)getCurrentTimes;
+(NSString*)getCurrentTimes:(NSString *) type;
#pragma mark -- 获取当前月份
+(NSString *)MonthdateString;
#pragma mark -- 获取当前日期
+(NSString *)DaydateString;
#pragma mark -- 时间戳转时间
+(NSString *) timeStampString:(NSString *)str ;

#pragma mark -- 获取当前时间戳
+(NSString *)getNowTimeTimestamp;
#pragma mark -- 时间戳转时间
+(NSString *) timeStampString:(NSString *)str type:(NSString *)type ;
#pragma mark-- 根据经纬度计算距离
+ (float)getDistance:(float)lat1 lng1:(float)lng1 lat2:(float)lat2 lng2:(float)lng2;


// 读取本地JSON文件
+ (NSArray *)readLocalFileWithName:(NSString *)name;
//拨打电话
+ (void)callPhone:(NSString *)phoneNum;

+ (BOOL)checkTelNumber:(NSString *) telNumber;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//根据高度求label 宽度
+ (CGFloat)getWidthWithText:(NSString *)text height:(CGFloat)height font:(CGFloat)font;

+ (NSString *)iphoneType;



+ (NSString *)deviceUUID;

//根据宽度求高度  content 计算的内容  width 计算的宽度 font字体大小
+ (CGFloat)getLabelHeightWithText:(NSString *)text width:(CGFloat)width font: (CGFloat)font;

//p标签转字符串
+(NSString *)filterHTMLString:(NSString *)html;

+(NSString *)getZZwithString:(NSString *)string;

//重新登录
+(void) code401;
//date 转字符串
+ (NSString *)time_dateToString:(NSDate *)date;

#pragma mark -- 分享下载
+(void) shareAction;

//判断是否有emoji
+(BOOL)stringContainsEmoji:(NSString *)string;

+ (NSString *)urlValidation:(NSString *)string;

+ (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect;

+ (NSString *)timeStrToTimestamp:(NSString *)timeStr format:(NSString *)format;

//密码加密
+ (NSString*) sha256:(NSString *)string;
+ (NSString*)sha224:(NSString *)string;

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

+ (UIViewController *)jsd_getCurrentViewController;

//时间戳转NSDate
+(NSDate *)UTCDateFromTimeStamap:(NSString *)timeStamap;

//字符串转NSDate
+(NSDate *)nsstringConversionNSDate:(NSString *)dateStr;
@end
