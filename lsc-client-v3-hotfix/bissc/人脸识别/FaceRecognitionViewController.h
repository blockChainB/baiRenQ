//
//  FaceRecognitionViewController.h
//  clientservice
//
//  Created by 龙广发 on 2018/9/7.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FaceTurnstileViewController.h"

@interface FaceRecognitionViewController : FaceTurnstileViewController

@property(nonatomic,strong) NSString *status;//1 、识别一下 、2、忘记密码
@end
