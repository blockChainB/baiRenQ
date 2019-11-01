//
//  FaceRecognitionViewController.m
//  clientservice
//
//  Created by 龙广发 on 2018/9/7.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "FaceRecognitionViewController.h"
#if !TARGET_OS_SIMULATOR
#import <IDLFaceSDK/IDLFaceSDK.h>
#endif
#import "NetAccessModel.h"
#import "UIImage+Additions.h"
#import "UIImage+Resize.h"
#import "FaceBgView.h"

@interface FaceRecognitionViewController (){
    
    UIImage* faceImage;
    
}

@property (nonatomic) BOOL shouldHandle;
@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic,strong) FaceBgView *faceBgView;


@end

@implementation FaceRecognitionViewController

-(FaceBgView *)faceBgView {
    
    if (!_faceBgView) {
        _faceBgView = [[ FaceBgView alloc] initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
        [_faceBgView.backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_faceBgView.rightBtn addTarget:self action:@selector(rightAction) forControlEvents:(UIControlEventTouchUpInside)];
        _faceBgView.titleLabel1.text = @"识别一下";
        [_faceBgView.rightBtn setBackgroundColor:[UIColor redColor]];
        
    }
    return _faceBgView;
}

-(void)rightAction {
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createIDface];
    [self.view addSubview:self.faceBgView];
}



-(void) createIDface {
    
    self.shouldHandle = YES;
}

- (void)faceProcesss:(UIImage *)image {
    
#if !TARGET_OS_SIMULATOR
    //等待相机，否则照出来的图片很容易特别黑
    if ([[NSDate date] timeIntervalSince1970] - self.startTime < 0.3) {
        return;
    }
    
    [[IDLFaceDetectionManager sharedInstance] detectTurnstileImage:image handler:^(NSDictionary *images, DetectRemindCode remindCode) {
        
        if (images != nil) {
            NSArray* faces = images[@"faces"];
            for (TrackedFaceInfoModel* face in faces) {
                
                NSLog(@"score:%f",face.score);
                
                if (face.score > 0.99) {
                    
                    [self handleFace:face andImage:image];
                }
            }
        }
        dispatch_async(dispatch_get_main_queue(), ^{
        });
    }];
#endif
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.startTime = [[NSDate date] timeIntervalSince1970];
}

- (void)handleFace:(TrackedFaceInfoModel*) face andImage:(UIImage*)image {
    if (!self.shouldHandle) {
        return;
    }

    
    CGImageRef croped;
    
    if (IS_IPHONE_X) {
        croped = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(48*_Scaling*[UIScreen mainScreen].scale, (__kHeight - (__kWidth +LGF_StatusAndNavBar_Height  + 40*_Scaling- 96*_Scaling))/2.0*[UIScreen mainScreen].scale , (__kWidth- 32*_Scaling-96*_Scaling)*[UIScreen mainScreen].scale, (__kWidth -32*_Scaling -96*_Scaling)*[UIScreen mainScreen].scale));
        
    }else {
        if ( __kWidth == 375) {
            croped = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(48*_Scaling*[UIScreen mainScreen].scale, (__kHeight - (__kWidth- 96*_Scaling) + 100*_Scaling)/2.0*[UIScreen mainScreen].scale , (__kWidth-96*_Scaling + 100*_Scaling)*[UIScreen mainScreen].scale, (__kWidth  -96*_Scaling + 120*_Scaling)*[UIScreen mainScreen].scale));
        }else{
            croped = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(48*_Scaling*[UIScreen mainScreen].scale, (__kHeight - (__kWidth +64- 96*_Scaling))/2.0*[UIScreen mainScreen].scale , (__kWidth- 32*_Scaling-96*_Scaling)*[UIScreen mainScreen].scale, (__kWidth -32*_Scaling -96*_Scaling)*[UIScreen mainScreen].scale));
        }
    }
    UIImage* ui = [UIImage imageWithCGImage:croped];
    self.shouldHandle = NO;
    [YGHttpRequest faceimagebase64:[ui base64EncodedString] callback:^(id obj) {
        
        BOOL istrue = [obj[@"success"] boolValue];
        if (istrue) {
            [MBProgressHUD showSuccess:obj[@"msg"]];
            if ([self.status isEqualToString:@"1"]) {
                UIViewController *controller = self.navigationController.viewControllers[1];
                [self.navigationController popToViewController:controller animated:YES];
            }else {
                NSLog(@"设置密码");
            }
        }else {
            [MBProgressHUD showError:obj[@"msg"]];
            self.shouldHandle = YES;
        }
    }];
}

#pragma mark -- 返回
-(void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}




@end
