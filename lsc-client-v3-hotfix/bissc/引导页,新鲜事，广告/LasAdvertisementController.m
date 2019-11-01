//
//  LasAdvertisementController.m
//  WBHManageClient
//
//  Created by 龙广发 on 2019/6/21.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import "LasAdvertisementController.h"
#import "SplashScreenDataManager.h"

@interface LasAdvertisementController ()

@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) UIButton *countButton;
@property (nonatomic, strong) NSTimer *countTimer;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSDictionary *dataDic;

@end

@implementation LasAdvertisementController

- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (void)guidePageControllerWithImageUrl:(NSDictionary *)adDic {
    
    _dataDic = adDic;
    
    _adImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
    _adImageView.image = [UIImage imageNamed:[SplashScreenDataManager getFilePathWithImageName:[adDic[@"imgFilePath"] componentsSeparatedByString:@"/"].lastObject]];
    _adImageView.userInteractionEnabled = YES;
    [self.view addSubview:_adImageView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_adImageView addGestureRecognizer:tap];
    
    // 2.跳过按钮
    _countButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _countButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 84, 30, 60, 30);
    [_countButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    _countButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_countButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _countButton.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
    _countButton.layer.cornerRadius = 4;

    [self.view addSubview:_countButton];
    
    [_countButton setTitle:[NSString stringWithFormat:@"跳过%ld",(long)[_dataDic[@"count"] intValue]] forState:UIControlStateNormal];
    
    [self startTimer];

}


// 定时器倒计时
- (void)startTimer
{
    _count = [_dataDic[@"count"] intValue];
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}

-(void)tapAction {
    
    [self.countTimer invalidate];
    self.countTimer = nil;

    if ([_dataDic[@"imgLinkUrl"] length] > 0) {
        
        [UserInfo sharedUserInfo].isAdStr = _dataDic[@"imgLinkUrl"];
        [[UserInfo sharedUserInfo] saveToSandbox];
        [[UserInfo sharedUserInfo] loadInfoFromSandbox];
     }
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(touchAction)]) {
        [self.delegate touchAction];
    }
}
- (void)countDown
{
    _count --;
    [self.countButton setTitle:[NSString stringWithFormat:@"跳过%ld",(long)_count] forState:UIControlStateNormal];
    if (_count == 0) {
        [self dismiss];
    }
}

-(void)dismiss {
    
    [self.countTimer invalidate];
    self.countTimer = nil;

    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(touchAction)]) {
        [self.delegate touchAction];
    }
}
@end
