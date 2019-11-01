//
//  YGHttpRequest.h
//  clientservice
//
//  Created by 龙广发 on 2018/11/1.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^MyCallback)(id obj);
typedef void (^ErrorCallback)(id obj);

@interface YGHttpRequest : NSObject

#pragma mark -- Post 请求
+(void)POSTDataUrl:(NSString *)url
        Parameters:(NSDictionary *)parameters
          callback:(MyCallback)callback;

#pragma mark -- GET 请求
+(void)GETDataUrl:(NSString *)url
       Parameters:(NSDictionary *)parameters
         callback:(MyCallback)callback;


#pragma mark --获取天气
+(void)WeatherDataParameters:(NSDictionary *)parameters
                    callback:(MyCallback)callback;

+(void)getfindByAppVersioncallback:(MyCallback)callback;

#pragma mark -- 上传文件
+(void)uploadfiles:(NSString *)files
              images:(NSArray *)images
              type:(NSString *)type
          callback:(MyCallback)callback;

#pragma mark --  人脸识别上传
+(void)faceimagebase64:(NSString *)imagebase64
              callback:(MyCallback)callback;

#pragma mark -- 发现上传图片
+(void)saveTopicuploadfiles:(NSString *)files
                     images:(NSArray *)images
                   callback:(MyCallback)callback;

@end
