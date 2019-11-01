//
//  UIButton+WebCache.m
//  clientservice
//
//  Created by 龙广发 on 2018/9/12.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "UIButton+WebCache.h"

@implementation UIButton (WebCache)

- (void)xr_setButtonImageWithUrl:(NSString *)urlStr {
    
    
    
    NSURL * url = [NSURL URLWithString:urlStr];
    
    
    
    // 根据图片的url下载图片数据
    
    
    
    dispatch_queue_t xrQueue = dispatch_queue_create("loadImage", NULL); // 创建GCD线程队列
    
    
    
    dispatch_async(xrQueue, ^{
        
        // 异步下载图片

        UIImage * img = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
        // 主线程刷新UI
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            [self setImage:img forState:UIControlStateNormal];
            
        });
        
        
        
    });
    
}



@end
