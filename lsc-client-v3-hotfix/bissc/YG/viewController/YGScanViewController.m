//
//  YGScanViewController.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/9.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGScanViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LCQRCodeUtil.h"
#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <Photos/Photos.h>
#define TOP 137 *_Scaling
#define LEFT 54 *_Scaling
#define kScanRect CGRectMake(LEFT, TOP, __kWidth - 108*_Scaling, __kWidth - 108*_Scaling)

//#import "YGUserDyController.h"
@interface YGScanViewController ()<AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    int num;
    BOOL upOrdown;
    CAShapeLayer *cropLayer;
}

@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;

@property (strong,nonatomic)UILabel * titleLB;
@property (strong,nonatomic)UILabel * titleLB2;
@property (strong,nonatomic)UILabel * titleLB3;
@property (strong,nonatomic)UIView * bgView;


@property (nonatomic, strong) UIImageView * line;
@property (nonatomic, strong) NSTimer * timer;

@end

@implementation YGScanViewController

-(UIView *)bgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0*_Scaling, __kWidth, __kHeight )];
    }
    return _bgView;
}


-(void) viewWillDisappear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = appBgRGBColor;
//    [self.view addSubview:self.navagationView];
    self.title = @"扫一扫";
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"ygk_scan_photo"] forState:(UIControlStateNormal)];
    rightBtn.frame = CGRectMake(0, 0, 17, 14);
    [rightBtn addTarget:self action:@selector(rightAction) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem  *rightBar = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBar;
    [self configView];
    
    if ([self isCanUsePhotos] == NO) {
        [MBProgressHUD showError:@"请去设置中开启相册权限！"];
    }else {
        [self setupCamera];
    }

     
    [self.view addSubview:self.titleLB];
    [self.view addSubview:self.titleLB2];
    [self.view addSubview:self.titleLB3];


}

-(UILabel *)titleLB {
    
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 160*_Scaling - LGF_StatusAndNavBar_Height, __kWidth, 18*_Scaling)];
        _titleLB.text = @"探索云谷各种精彩";
        _titleLB.textAlignment = NSTextAlignmentCenter;
        _titleLB.font = [UIFont systemFontOfSize:18*_Scaling];
        _titleLB.textColor = [UIColor whiteColor];
    }
    return _titleLB;
}

-(UILabel *)titleLB2 {
    
    if (!_titleLB2) {
        _titleLB2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 488*_Scaling- LGF_StatusAndNavBar_Height, __kWidth, 13*_Scaling)];
        _titleLB2.text = @"二维码放入框内";
        _titleLB2.textAlignment = NSTextAlignmentCenter;
        _titleLB2.font = [UIFont systemFontOfSize:13*_Scaling];
        _titleLB2.textColor = [UIColor whiteColor];
    }
    return _titleLB2;
}
-(UILabel *)titleLB3 {
    
    if (!_titleLB3) {
        _titleLB3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 510*_Scaling- LGF_StatusAndNavBar_Height, __kWidth, 13*_Scaling)];
        _titleLB3.text = @"可扫描活动、专题、奖券、礼品等业务";
        _titleLB3.textAlignment = NSTextAlignmentCenter;
        _titleLB3.font = [UIFont systemFontOfSize:13*_Scaling];
        _titleLB3.textColor = [UIColor whiteColor];
    }
    return _titleLB3;
}
//#pragma mark --  上导航栏视图
//-(YGNavagationView *)navagationView {
//
//    if (!_navagationView) {
//        _navagationView = [[YGNavagationView alloc] initWithFrame:CGRectMake(0, 0, __kWidth, 75*_Scaling)];
//        _navagationView.titleName.text = @"扫一扫";
//        _navagationView.userInteractionEnabled = YES;
//        [_navagationView.backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
//    }
//    return _navagationView;
//}

-(void)backAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)configView{
    
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:kScanRect];
    imageView.image = [UIImage imageNamed:@"ygk_scan_矩形"];
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP+10, (__kWidth-96*_Scaling), 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [self setCropRect:kScanRect];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, (__kWidth-96*_Scaling), 2);
        if (2*num == 200) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(LEFT, TOP+10+2*num, (__kWidth-96*_Scaling), 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
}

- (void)setCropRect:(CGRect)cropRect{
    
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, CGRectMake(0, 0*_Scaling, __kWidth, __kHeight ));
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.4];
    [cropLayer setNeedsDisplay];
    
    [self.view.layer addSublayer:cropLayer];
    
    if (self.session != nil && self.timer != nil) {
        [self.session startRunning];
        [self.timer setFireDate:[NSDate date]];
    }


}
#pragma mark -- 相机权限
- (BOOL)isCanUsePhotos {
    
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        //无权限
        return NO;
    }
    return YES;
}
- (void)setupCamera
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Device
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    self.output = [[AVCaptureMetadataOutput alloc]init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //设置扫描区域
    CGFloat top = TOP/__kHeight;
    CGFloat left = LEFT/__kWidth;
    CGFloat width = (__kWidth-96*_Scaling)/__kWidth;
    CGFloat height = (__kWidth-96*_Scaling)/__kHeight;
    ///top 与 left 互换  width 与 height 互换
    [self.output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    
    // Session
    self.session = [[AVCaptureSession alloc]init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([self.session canAddInput:self.input])
    {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.output])
    {
        [self.session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    [self.output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];
    
    // Preview
    self.preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = CGRectMake(0, 0, __kWidth, __kHeight );
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    // Start
    [self.session startRunning];
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        //停止扫描
        [self.session stopRunning];
        [self.timer setFireDate:[NSDate distantFuture]];
        
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        NSLog(@"扫描结果：%@",stringValue);
        
        NSArray *arry = metadataObject.corners;
        for (id temp in arry) {
            NSLog(@"%@",temp);
        }
        
        NSDictionary *dic = [self dictionaryWithJsonString:stringValue];
        NSLog(@"%@",dic);
        if ([dic[@"YGType"] isEqualToString:@"1"]) {
            
//            YGHtmlViewController *ctl = [[YGHtmlViewController alloc] init];
//            ctl.hidesBottomBarWhenPushed = YES;
//            ctl.status = @"99";
//            ctl.url = dic[@"YGContent"];
//            [self.navigationController pushViewController:ctl animated:YES];
        }else if ([dic[@"YGType"] isEqualToString:@"0"]){
//
//            YGUserDyController *controller = [[YGUserDyController alloc] init];
//            controller.hidesBottomBarWhenPushed = YES;
//            controller.membersId = dic[@"YGContent"];
//            [self.navigationController pushViewController:controller animated:YES];
            
        }else if ([dic[@"YGType"] isEqualToString:@"2"]){
            
//            YGCompantDetailController *controller = [[YGCompantDetailController alloc] init];
//            controller.hidesBottomBarWhenPushed = YES;
//            controller.companyId = dic[@"YGContent"];
//            controller.companyName = dic[@"YGDetails"];
//            [self.navigationController pushViewController:controller animated:YES];
        }

    } else {
        NSLog(@"无扫描信息");
        return;
    }
    
}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"无效的二维码" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self setCropRect:kScanRect];

        }]];
        [self presentViewController:alert animated:YES completion:nil];
        
        return nil;
    }
    return dic;
}
-(void) rightAction {
    
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    
    
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    //ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 照相机
    //ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    ipc.allowsEditing = YES;//启动编辑功能
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
    
}


#pragma mark -- <UIImagePickerControllerDelegate>--

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *scannedResult = @"无二维码";
    // 设置图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    if(image){
        //1. 初始化扫描仪，设置设别类型和识别质量
        CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
        //2. 扫描获取的特征组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if([features count] > 0){
            //3. 获取扫描结果
            CIQRCodeFeature *feature = [features objectAtIndex:0];
            scannedResult = feature.messageString;
        }
    }
    NSLog(@"%@",scannedResult);
    
    NSDictionary *dic = [self dictionaryWithJsonString:scannedResult];
    NSLog(@"%@",dic);
    if ([dic[@"YGType"] isEqualToString:@"1"]) {
        
//        YGHtmlViewController *ctl = [[YGHtmlViewController alloc] init];
//        ctl.hidesBottomBarWhenPushed = YES;
//        ctl.status = @"99";
//        ctl.url = dic[@"YGContent"];
//        [self.navigationController pushViewController:ctl animated:YES];
        
    }else if ([dic[@"YGType"] isEqualToString:@"0"]){
        
//        YGUserDyController *controller = [[YGUserDyController alloc] init];
//        controller.hidesBottomBarWhenPushed = YES;
//        controller.membersId = dic[@"YGContent"];
//        [self.navigationController pushViewController:controller animated:YES];
    }else if ([dic[@"YGType"] isEqualToString:@"2"]){
//
//        YGCompantDetailController *controller = [[YGCompantDetailController alloc] init];
//        controller.hidesBottomBarWhenPushed = YES;
//        controller.companyId = dic[@"YGContent"];
//        controller.companyName = dic[@"YGDetails"];
//        [self.navigationController pushViewController:controller animated:YES];
    }

    
//    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:scannedResult delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//    [alertView show];
}




-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([UIDevice currentDevice].systemVersion.floatValue < 11)
    {
        return;
    }
    if ([viewController isKindOfClass:NSClassFromString(@"PUPhotoPickerHostViewController")])
    {
        [viewController.view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop)
         {
             // iOS 11之后，图片编辑界面最上层会出现一个宽度<42的view，会遮盖住左下方的cancel按钮，使cancel按钮很难被点击到，故改变该view的层级结构
             if (obj.frame.size.width < 42)
             {
                 [viewController.view sendSubviewToBack:obj];
                 *stop = YES;
             }
         }];
    }
}



@end
