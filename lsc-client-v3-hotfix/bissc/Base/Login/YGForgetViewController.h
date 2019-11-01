//
//  YGForgetViewController.h
//  clientservice
//
//  Created by 龙广发 on 2018/11/29.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGForgetViewController : UIViewController

@property(nonatomic,copy) NSString *status; //1 忘记  2 绑定
@property(nonatomic,strong)NSDictionary  *dataDic;

@end
