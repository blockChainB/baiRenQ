//
//  SplashScreenView.m
//  启动屏加启动广告页
//
//  Created by WOSHIPM on 16/8/9.
//  Copyright © 2016年 WOSHIPM. All rights reserved.
//

#import "SplashScreenView.h"

@interface  SplashScreenView()

@property (nonatomic, strong) UIImageView *adImageView;

@property (nonatomic, strong) UIButton *countButton;

@property (nonatomic, strong) NSTimer *countTimer;

@property (nonatomic, assign) NSInteger count;
@end
 

@implementation SplashScreenView

- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 1.广告图片
        _adImageView = [[UIImageView alloc] initWithFrame:frame];
        _adImageView.userInteractionEnabled = YES;
        _adImageView.contentMode = UIViewContentModeScaleAspectFill;
        _adImageView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAdVC)];
        [_adImageView addGestureRecognizer:tap];
        
        // 2.跳过按钮
        _countButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _countButton.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 84, 30, 60, 30);
        [_countButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        _countButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [_countButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _countButton.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
        _countButton.layer.cornerRadius = 4;
        
        [self addSubview:_adImageView];
        [self addSubview:_countButton];
      
    }
    return self;
}
-(void)setImgFilePath:(NSString *)imgFilePath{
    _imgFilePath = imgFilePath;
     _adImageView.image = [UIImage imageWithContentsOfFile:_imgFilePath];
    [_adImageView sd_setImageWithURL:[NSURL URLWithString:imgFilePath] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
}
-(void)setImgDeadline:(NSString *)imgDeadline{
    _imgDeadline = imgDeadline;
}
-(void)setTitle:(NSString *)title {
    _title = title;
}

- (void)pushToAdVC{
    //点击广告图时，广告图消失，同时像首页发送通知，并把广告页对应的地址传给首页
    [self dismiss];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"tapAction" object:_imgLinkUrl userInfo:nil];
    
    NSDictionary *dic = @{@"url":_imgLinkUrl,@"title":_title};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tapAction" object:nil userInfo:dic];

}

- (void)countDown
{
    _count --;
    [self.countButton setTitle:[NSString stringWithFormat:@"跳过%ld",(long)_count] forState:UIControlStateNormal];
    if (_count == 0) {

        [self dismiss];
    }
}

- (void)showSplashScreenWithTime:(NSInteger)ADShowTime
{
    _ADShowTime = ADShowTime;
    [_countButton setTitle:[NSString stringWithFormat:@"跳过%ld",ADShowTime] forState:UIControlStateNormal];

    [self startTimer];
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    window.hidden = NO;
    [window addSubview:self];

}

// 定时器倒计时
- (void)startTimer
{
    _count = _ADShowTime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}



// 移除广告页面
- (void)dismiss
{
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}


@end
