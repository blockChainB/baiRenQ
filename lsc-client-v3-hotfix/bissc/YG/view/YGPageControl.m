//
//  YGPageControl.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/2.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGPageControl.h"

@implementation YGPageControl
#define dotW 22
#define magrin 1

- (instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    
    [self updateDots];
}


- (void)updateDots{
    
    
    for (int i = 0; i < [self.subviews count]; i++) {
        
        UIImageView *dot = [self imageViewForSubview:[self.subviews objectAtIndex:i] currPage:i];
        
        if (i == self.currentPage){
            dot.image = self.currentImage;
            dot.size = self.currentImageSize;
//            [dot setFrame:CGRectMake(i*20, dot.frame.origin.y, 20, 2)];

        }else{
            dot.image = self.inactiveImage;
            dot.size = self.inactiveImageSize;
//            [dot setFrame:CGRectMake(i*20, dot.frame.origin.y, 20, 2)];
        }
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //计算圆点间距
    CGFloat marginX = dotW + magrin;
    
    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 1 ) * marginX;
    
    //设置新frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    
    //设置居中
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotW)];
        }else {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotW)];
        }
    }
}

- (UIImageView *)imageViewForSubview:(UIView *)view currPage:(int)currPage{
    UIImageView *dot = nil;
    if ([view isKindOfClass:[UIView class]]) {
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                dot = (UIImageView *)subview;
                break;
            }
        }
        if (dot == nil) {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, view.frame.size.width, view.frame.size.height)];
            
            [view addSubview:dot];
        }
    }else {
        dot = (UIImageView *)view;
    }
    
    return dot;
    
}
@end
