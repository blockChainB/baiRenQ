//
//  FaceIDController.m
//  clientservice
//
//  Created by 龙广发 on 2018/9/1.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "FaceIDController.h"
#if !TARGET_OS_SIMULATOR
#import <IDLFaceSDK/IDLFaceSDK.h>
#endif
#import "NetAccessModel.h"
#import "UIImage+Additions.h"
#import "UIImage+Resize.h"
#import "FaceBgView.h"
#import "FaceRecognitionViewController.h"

//#define UI_IS_IPHONE6           (UI_IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)


@interface FaceIDController (){
    
    UIImage* faceImage;

}
@property (nonatomic,copy) NSString *ImageUrl;

@property (nonatomic) BOOL shouldHandle;
@property (nonatomic) NSTimeInterval startTime;
@property (nonatomic,strong) FaceBgView *faceBgView;

@end

@implementation FaceIDController

-(FaceBgView *)faceBgView {
    
    if (!_faceBgView) {
        _faceBgView = [[ FaceBgView alloc] initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
        [_faceBgView.backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_faceBgView.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_faceBgView.doneBtn addTarget:self action:@selector(doneAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_faceBgView.rightBtn addTarget:self action:@selector(rightAction) forControlEvents:(UIControlEventTouchUpInside)];

    }
    return _faceBgView;
}

-(void)rightAction {
    

    FaceRecognitionViewController *controller = [[FaceRecognitionViewController alloc] init];
    controller.hidesBottomBarWhenPushed = YES;
    controller.status = @"1";
    [self.navigationController pushViewController:controller animated:YES];
    
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

    
    if (IS_IPHONE_X || IS_IPHONE_Xr || IS_IPHONE_Xs || IS_IPHONE_Xs_Max) {
        
        croped = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(48*_Scaling*[UIScreen mainScreen].scale, (__kHeight - (__kWidth +LGF_StatusAndNavBar_Height  + 40*_Scaling- 96*_Scaling))/2.0*[UIScreen mainScreen].scale , (__kWidth- 32*_Scaling-96*_Scaling)*[UIScreen mainScreen].scale, (__kWidth -32*_Scaling -96*_Scaling)*[UIScreen mainScreen].scale));

        
    }else if (__kWidth == 414){
        
        if ([[UserInfo iphoneType] isEqualToString:@"iPhone 6 Plus"] || [[UserInfo iphoneType] isEqualToString:@"iPhone 6s Plus"] ) {
            
            croped = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(48*[UIScreen mainScreen].scale*0.5625, (__kHeight - (__kWidth +LGF_StatusAndNavBar_Height- 96))/2.0*[UIScreen mainScreen].scale*0.65 , (__kWidth- 32-96)*[UIScreen mainScreen].scale*0.62, (__kWidth -32 -96)*[UIScreen mainScreen].scale*0.62));
            
        }else {
            croped = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(48*_Scaling*[UIScreen mainScreen].scale, (__kHeight - (__kWidth +LGF_StatusAndNavBar_Height- 96*_Scaling))/2.0*[UIScreen mainScreen].scale , (__kWidth- 32*_Scaling-96*_Scaling)*[UIScreen mainScreen].scale, (__kWidth -32*_Scaling -96*_Scaling)*[UIScreen mainScreen].scale));
        }


    }else {
        if ([[UserInfo iphoneType] isEqualToString:@"iPhone 6"] || [[UserInfo iphoneType] isEqualToString:@"iPhone 6s"] ) {
            croped = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(48*_Scaling*[UIScreen mainScreen].scale, (__kHeight - (__kWidth- 96*_Scaling))/2.0*[UIScreen mainScreen].scale , (__kWidth-96*_Scaling)*[UIScreen mainScreen].scale, (__kWidth  -96*_Scaling )*[UIScreen mainScreen].scale));
        }else {
            croped = CGImageCreateWithImageInRect(image.CGImage, CGRectMake(60*_Scaling*[UIScreen mainScreen].scale, (__kHeight - (__kWidth- 96*_Scaling) + 120*_Scaling)/2.0*[UIScreen mainScreen].scale , (__kWidth-96*_Scaling + 120*_Scaling)*[UIScreen mainScreen].scale, (__kWidth  -96*_Scaling + 120*_Scaling)*[UIScreen mainScreen].scale));
        }
    }
    
    
    UIImage* ui = [UIImage imageWithCGImage:croped];
    faceImage = ui;
    

    self.shouldHandle = NO;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{//只留下主线程返回的进度数据
        self.faceBgView.imageView.image = ui;
        self.faceBgView.cancelBtn.hidden = NO;
        self.faceBgView.doneBtn.hidden = NO;
        self.ImageUrl = [ui base64EncodedString];

    }];
    
}


-(UIImage *)clipImage:(UIImage *)image imageoritation:(UIImageOrientation)oritation withRect:(CGRect)rect
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], rect);
    UIImage *clipImage = [UIImage imageWithCGImage:imageRef scale:image.scale orientation:oritation];//UIImageOrientationLeft
    CGImageRelease(imageRef);
    return clipImage;
    
}

#pragma mark -- 返回
-(void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark -- 取消
-(void) cancelAction {
    
    
    self.faceBgView.cancelBtn.hidden = YES;
    self.faceBgView.doneBtn.hidden = YES;
    self.faceBgView.imageView.image = [UIImage imageNamed:@""];
    
    int64_t delayInSeconds = 2.0; // 延迟的时间
    
    /*
     *  delta:
     *
     *  @parameter 1.时间参照，从此刻开始计时
     *  @parameter 2.延时多久，此处为秒级，还有纳秒等: 10ull * NSEC_PER_MSEC
     */
    
    __weak typeof(self)weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf delayMethod];
    });
}

-(void) delayMethod {
    self.shouldHandle = YES;
    
}

#pragma mark --上传
-(void) doneAction {
    
    self.faceBgView.cancelBtn.hidden = YES;
    self.faceBgView.doneBtn.hidden = YES;
    
    NSDictionary *dic = @{@"memberId":[UserInfo sharedUserInfo].userDic[@"id"],@"siteId":[UserInfo sharedUserInfo].siteID,@"imgBase64":self.ImageUrl};
    [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"setting/uploadFace"] Parameters:dic callback:^(id obj) {
        NSLog(@"%@",obj);
        BOOL istrue   = [obj[@"success"] boolValue];
        if (istrue) {
            [MBProgressHUD showSuccess:obj[@"msg"]];
            UIViewController *controller = self.navigationController.viewControllers[1];
            [self.navigationController popToViewController:controller animated:YES];
        }else {
            [MBProgressHUD showError:obj[@"msg"]];
            [self cancelAction];
        }
    }];
}

@end
