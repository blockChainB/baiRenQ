//
//  SplashScreenDataManager.m
//  启动屏加启动广告页
//
//  Created by WOSHIPM on 16/8/29.
//  Copyright © 2016年 WOSHIPM. All rights reserved.
//

#import "SplashScreenDataManager.h"
#import "SplashScreenView.h"
@implementation SplashScreenDataManager
/**
 *  判断文件是否存在
 */
+ (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = FALSE;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
    
}

/**
 *  初始化广告页面
 */
+ (void)getAdvertisingImageData
{
    
    [YGHttpRequest GETDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"index/getAdvertising"] Parameters:nil callback:^(id obj) {
        NSLog(@"%@",obj);
        BOOL istrue = [obj[@"success"] boolValue];
        if (istrue) {//请求成功
            
            NSString *imageUrl = obj[@"data"][@"templateOneAdvertising"][@"img"];
            NSString  *imgLinkUrl = obj[@"data"][@"templateOneAdvertising"][@"url"];
            NSString  *imgTitle = obj[@"data"][@"templateOneAdvertising"][@"title"];
            NSString  *imgCount = obj[@"data"][@"templateOneAdvertising"][@"count"];

            // 获取图片名
            NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
            NSString *imageName = stringArr.lastObject;
            
            [UserInfo sharedUserInfo].advertisementImageUrl = imageUrl;
            [UserInfo sharedUserInfo].advertisementUrl = imgLinkUrl;
            [UserInfo sharedUserInfo].advertisementTitle = imgTitle;
            [UserInfo sharedUserInfo].advertisementCount = imgCount;

//            [UserInfo sharedUserInfo].AdDic = obj[@"data"][@"templateOneAdvertising"];
            
            [[UserInfo sharedUserInfo] saveToSandbox];
            [[UserInfo sharedUserInfo] loadInfoFromSandbox];
            // 拼接沙盒路径
//            NSString *filePath = [self getFilePathWithImageName:imageName];
            
            [self downloadAdImageWithUrl:imageUrl imageName:imageName imgLinkUrl:imgLinkUrl title:imgTitle];
        }
        
    }];

}

/**
 *  下载新的图片
 */
+ (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName imgLinkUrl:(NSString *)imgLinkUrl title:(NSString *)title
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        
        NSString *filePath = [self getFilePathWithImageName:imageName]; // 保存文件的名称
        [UIImageJPEGRepresentation(image, 0) writeToFile:filePath atomically:YES];
        
        if ([UIImageJPEGRepresentation(image, 0) writeToFile:filePath atomically:YES]) {
            
            // 保存成功
            //判断保存下来的图片名字和本地沙盒中存在的图片是否一致，如果不一致，说明图片有更新，此时先删除沙盒中的旧图片，如果一致说明是删除缓存后再次下载，这时不需要进行删除操作，否则找不到已保存的图片
            if (![imageName isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:adImageName] ]) {
                [self deleteOldImage];
            }
           
            [[NSUserDefaults standardUserDefaults] setValue:imageName forKey:adImageName];
            [[NSUserDefaults standardUserDefaults] setValue:imgLinkUrl forKey:adUrl];
            [[NSUserDefaults standardUserDefaults] setValue:title forKey:adtitle];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
        }else{
            NSLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
+ (void)deleteOldImage
{
    NSString *imageName = [[NSUserDefaults standardUserDefaults] valueForKey:adImageName];
    
    if (imageName) {
        
        NSString *filePath = [self getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:adImageName];
        [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:adUrl];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

/**
 *  根据图片名拼接文件路径
 */
+ (NSString *)getFilePathWithImageName:(NSString *)imageName
{
    if (imageName) {
        NSString *paths = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) lastObject];
        NSString *filePath = [paths stringByAppendingPathComponent:imageName];
        return filePath;
    }
    return nil;
}


@end
