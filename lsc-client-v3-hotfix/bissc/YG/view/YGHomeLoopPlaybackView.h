//
//  YGHomeLoopPlaybackView.h
//  clientservice
//
//  Created by 龙广发 on 2018/11/2.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGPageControl.h"


@class YGHomeLoopPlaybackView;
@protocol YGHomeLoopPlayScrollViewDelegate <NSObject>
/** 点击图片回调 */
- (void)cycleScrollView:(YGHomeLoopPlaybackView *)YGcycleScrollView didSelectItemAtIndex:(NSInteger)index;
@end


@interface YGHomeLoopPlaybackView : UIView

//*代理方法
@property (nonatomic ,weak) id<YGHomeLoopPlayScrollViewDelegate> delegate;


@property(nonatomic,strong)YGPageControl *pageControl;

@property (nonatomic ,strong) UIScrollView *scrollView;

//初始化方法 withPlaceHoderl:(UIImage *)image{

-(instancetype)initWithFrame:(CGRect)frame imageGroups:(NSMutableArray<NSString *> *)imageGroups;
-(instancetype)initWithFrame:(CGRect)frame imageGroups:(NSMutableArray<NSString *> *)imageGroups withPlaceHoderl:(UIImage *)image;
@end
