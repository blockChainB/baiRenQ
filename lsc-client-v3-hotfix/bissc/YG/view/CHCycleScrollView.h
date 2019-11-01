//
//  CHCycleScrollView.h
//  无限滚动demo
//
//  Created by 陈浩 on 2018/4/16.
//  Copyright © 2018年 陈浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHCycleScrollView;
@protocol CHCycleScrollViewDelegate <NSObject>
/** 点击图片回调 */
- (void)cycleScrollView:(CHCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index;
@end


@interface CHCycleScrollView : UIView

//*代理方法
@property (nonatomic ,weak) id<CHCycleScrollViewDelegate> delegate;

@property(nonatomic,strong)UIPageControl  *pageControl;

@property (nonatomic ,strong) UIScrollView *scrollView;

//初始化方法

-(instancetype)initWithFrame:(CGRect)frame imageGroups:(NSMutableArray<NSString *> *)imageGroups;


//初始化方法

-(instancetype)initWithFrame:(CGRect)frame imageGroups:(NSMutableArray<NSString *> *)imageGroups nameGroups:(NSMutableArray<NSString *> *)nameGroups;

@end
