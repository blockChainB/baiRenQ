//
//  MBProgressHUD+MJ.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+HM.h"

@implementation MBProgressHUD (HM)
#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.2];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = YES;
    return hud;
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}


+(void) showGifToView:(UIView *)view {
    
    if (view == nil)
//    view = (UIView*)[UIApplication sharedApplication].delegate.window;
    view = [[UIApplication sharedApplication].windows lastObject];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"加载" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];

    //使用SDWebImage 放入gif 图片--(因为项目中使用的都是同一个加载动画，所以在这里我把图片写死了)
    UIImage *image = [UIImage sd_animatedGIFWithData:data];
    //自定义imageView
    UIImageView *cusImageV = [[UIImageView alloc] initWithImage:image];
    //设置hud模式
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.removeFromSuperViewOnHide = YES;
    
    //设置提示性文字
//    hud.label.text = @"正在加载中";
    //    // 设置文字大小
    //    hud.label.font = [UIFont systemFontOfSize:20];
    //    //设置文字的背景颜色
    //    //    hud.label.backgroundColor = [UIColor redColor];
    //
    //    设置方框view为该模式后修改颜色才有效果
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //设置方框view背景色
    hud.bezelView.backgroundColor = [UIColor clearColor];
    //设置总背景view的背景色，并带有透明效果
    //    hud.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    hud.customView = cusImageV;
}


+ (void)hideGifHUDForView:(UIView *)view {
    
    if (view == nil) view = (UIView*)[UIApplication sharedApplication].delegate.window;
    
    [self hideHUDForView:view animated:YES];
}




@end
