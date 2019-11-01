//
//  YGHomeLoopPlaybackView.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/2.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGHomeLoopPlaybackView.h"
#define UIScreenW [UIScreen mainScreen].bounds.size.width

@interface YGHomeLoopPlaybackView ()<UIScrollViewDelegate>


@property (nonatomic ,strong) NSTimer *timer;    //   定时器
@property (nonatomic,assign) CGFloat oldContentOffsetX;
@property (nonatomic,strong) NSMutableArray *imgArr;//图片数组
@property (nonatomic,strong) NSMutableArray *nameArr;//名字数组
@property (nonatomic,strong) UIImage *PlaceHoderlImage;//图片数组
@end
@implementation YGHomeLoopPlaybackView


-(instancetype)init {
    
    if (self = [super init]) {
        
        self.userInteractionEnabled = NO;
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame imageGroups:(NSMutableArray<NSString *> *)imageGroups{
    if (self = [super initWithFrame:frame]) {
        
        _imgArr = imageGroups;
        
        [self initView];
        
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame imageGroups:(NSMutableArray<NSString *> *)imageGroups withPlaceHoderl:(UIImage *)image{
    if (self = [super initWithFrame:frame]) {
        
        _imgArr = imageGroups;
        self.PlaceHoderlImage =image;
        [self initView];
        
    }
    return self;
}



-(void)initView{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrollView.delegate = self;
//    self.scrollView.backgroundColor = kRGBColor(255, 255, 255, 1.0);
    self.scrollView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    if (_imgArr.count == 1) {
        
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake( 15*_Scaling, 4*_Scaling, UIScreenW - 30*_Scaling, self.frame.size.height - 8*_Scaling)];
        imgView.layer.cornerRadius = 5.0*_Scaling;
        imgView.layer.masksToBounds = YES;
        imgView.userInteractionEnabled = YES;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [imgView addGestureRecognizer:tap];
        // 2. 设置图片
        NSString *imageName ;
        imgView.tag = 0;
        if ([_imgArr[0] isKindOfClass:[NSDictionary class]]) {
            imageName = _imgArr[0][@"img"];
        }else {
            imageName = _imgArr[0];
        }
        
        [imgView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:[UIImage imageNamed:@"组 44"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
        }];
        
        // 3. 添加imageView 到 scrollView上
        [self.scrollView addSubview:imgView];
        // 设置scrollView的contentSize
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width * _imgArr.count, 0);
        
        
        
    }else if (_imgArr.count == 0){
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake( 15*_Scaling, 4*_Scaling, UIScreenW - 30*_Scaling, self.frame.size.height - 8*_Scaling)];
        imgView.layer.cornerRadius = 5.0*_Scaling;
        imgView.layer.masksToBounds = YES;
        imgView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [imgView addGestureRecognizer:tap];

        imgView.image = [UIImage imageNamed:@"ygk_轮播默认"];

        
        // 3. 添加imageView 到 scrollView上
        [self.scrollView addSubview:imgView];
        // 设置scrollView的contentSize
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width , 0);
        
        
    }else {
        NSLog(@"%ld",_imgArr.count);
        for (int i = 0; i< _imgArr.count +1; i++) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((UIScreenW *i) + 15*_Scaling, 4*_Scaling, UIScreenW - 30*_Scaling, self.frame.size.height - 8*_Scaling)];
            imgView.tag = i;
            imgView.layer.cornerRadius = 5.0*_Scaling;
            imgView.layer.masksToBounds = YES;
            imgView.userInteractionEnabled = YES;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
            [imgView addGestureRecognizer:tap];
            // 2. 设置图片
            NSString *imageName ;
            
            if ([_imgArr[0] isKindOfClass:[NSDictionary class]]) {
                if (i == _imgArr.count) {
                    imageName = _imgArr[0][@"img"];
                }else
                {
                    imageName = _imgArr[i][@"img"];
                }
                
            }else {
                if (i == _imgArr.count) {
                    imageName = _imgArr[0];
                }else
                {
                    imageName = _imgArr[i];
                }
            }
            
            
            [imgView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:self.PlaceHoderlImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                
            }];
            // 3. 添加imageView 到 scrollView上
            [self.scrollView addSubview:imgView];
            
        }
        // 设置scrollView的contentSize
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width * (_imgArr.count + 1), 0);
        
    }
    
    
    
    // 隐藏水平滚动指示器
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // 设置分页属性
    // 分页是通过 scrollView的width 来确定，这样的话，当滑动的时候，图片被滑动一半的时候，图片会立即切换成新的图片
    self.scrollView.pagingEnabled = YES;
    
    [self addSubview:self.scrollView];
    
    
    self.pageControl = [[YGPageControl alloc] initWithFrame:CGRectMake(0, 10, __kWidth, 5)];
    self.pageControl.numberOfPages = _imgArr.count;
//    self.pageControl.backgroundColor = [UIColor  redColor];
    self.pageControl.currentPage = 0;
    self.pageControl.userInteractionEnabled = NO;
//    self.pageControl.inactiveImage = [UIImage imageNamed:@"圆角矩形 15"];
//    self.pageControl.inactiveImageSize = CGSizeMake(20, 2);
//    self.pageControl.currentImage = [UIImage imageNamed:@"圆角矩形 15 拷贝"];
//    self.pageControl.currentImageSize = CGSizeMake(20, 2);
    [self.pageControl setValue:[UIImage imageNamed:@"圆角矩形 15"] forKeyPath:@"_currentPageImage"];
    [self.pageControl setValue:[UIImage imageNamed:@"圆角矩形 15 拷贝"] forKeyPath:@"_pageImage"];
    

//    self.pageControl.currentPageIndicatorTintColor = [UIColor clearColor];
//    self.pageControl.pageIndicatorTintColor = [UIColor clearColor];
    
    [self addSubview:self.pageControl];
    [self.pageControl mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(self);
        make.top.mas_equalTo(self.height);
    }];
    // 创建一个定时器
    
    if (_imgArr.count > 1) {
        
        [self startTimer];
        
    }
    
}



- (void)startTimer {
    // scheduled 计划
    /**
     scheduledTimerWithTimeInterval 间隔
     target     通过谁调用下面的方法
     selector   方法
     userInfo  : 传递的参数
     repeats : 是否重复执行 方法
     */
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                              target:self
                                            selector:@selector(changeImage)
                                            userInfo:nil
                                             repeats:YES];
    
    // 调整timer 的优先级
    NSRunLoop *mainLoop = [NSRunLoop mainRunLoop];
    
    [mainLoop addTimer:_timer forMode:NSRunLoopCommonModes];
}



-(void)tapGesture:(UITapGestureRecognizer *)tap{
    
    if ([_imgArr[0] isKindOfClass:[NSDictionary class]]) {
        if ([self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
            [self.delegate cycleScrollView:self didSelectItemAtIndex:tap.view.tag];
        }
    }else {
        if ([self.delegate respondsToSelector:@selector(cycleScrollView:didSelectItemAtIndex:)]) {
            [self.delegate cycleScrollView:self didSelectItemAtIndex:tap.view.tag];
        }
    }
    
    
}


- (void)changeImage {
    [self.scrollView setContentOffset:CGPointMake((self.pageControl.currentPage+1)*UIScreenW, 0) animated:YES];
}
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (_imgArr.count >1) {
        
        CGPoint point = scrollView.contentOffset;
        
        BOOL isRight = self.oldContentOffsetX < point.x;
        self.oldContentOffsetX = point.x;
        // 开始显示最后一张图片的时候切换到第二个图
        if (point.x > UIScreenW*(_imgArr.count-1)+UIScreenW*0.5 && !self.timer) {//从最后一个图片会到第一个图片
            self.pageControl.currentPage = 0;
        }else if (point.x > UIScreenW*(_imgArr.count -1) && self.timer && isRight){
            self.pageControl.currentPage = 0;
        }else{
            self.pageControl.currentPage = (point.x + UIScreenW*0.5) / UIScreenW;
        }
        // 开始显示第一张图片的时候切换到倒数第二个图
        if (point.x >= UIScreenW *_imgArr.count) {
            [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        }else if (point.x < 0) {
            [scrollView setContentOffset:CGPointMake(point.x+UIScreenW*_imgArr.count, 0) animated:NO];
        }
    }
    
}

/**
 手指开始拖动的时候, 就让计时器停止
 invalidate  无效
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 让计时器无效
    [self stopTimer];
}

/**
 手指离开屏幕的时候, 就让计时器开始工作
 */

//scrollViewDidEndDragging应该是用这个方法
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    // 让计时器开始工作
    // fire , 马上执行, 方法, 不会等间隔时间
    // 如果 timer 调用了 invalidate 方法, time就不存在了, 需要再次创建
    [self startTimer];
    
}



@end
