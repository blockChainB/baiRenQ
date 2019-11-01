//
//  BaseNavigationController.m
//  clientservice
//
//  Created by 龙广发 on 2018/7/24.
//  Copyright © 湖南灵控智能科技有限公司. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.navigationBar.barTintColor = appBgRGBColor;

    self.navigationBar.translucent = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;

    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor],
                                                                      NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:18*_Scaling]}];
    
    [self.navigationBar setTintColor:[UIColor blackColor]];


    __weak typeof(self) weakSelf = self;

    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {

        self.interactivePopGestureRecognizer.delegate = weakSelf;
    }
}

#pragma mark 返回按钮
-(void)popself {
    [self popViewControllerAnimated:YES];
}

#pragma mark 创建返回按钮
-(UIBarButtonItem *)createBackButton {
    return [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ygk_back"] style:UIBarButtonItemStylePlain target:self action:@selector(popself)];
}

#pragma mark 重写方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    if (viewController.navigationItem.leftBarButtonItem == nil && [self.viewControllers count] > 1) {
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
   }
}

// 开始接收到手势的代理方法
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 判断是否是侧滑相关的手势
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        // 如果当前展示的控制器是根控制器就不让其响应
        if (self.viewControllers.count < 2 ||
            self.visibleViewController == [self.viewControllers objectAtIndex:0]) {
            return NO;
        }
    }
    return YES;
}



// 接收到多个手势的代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // 判断是否是侧滑相关手势
    if (gestureRecognizer == self.interactivePopGestureRecognizer && [gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint point = [pan translationInView:self.view];
        // 如果是侧滑相关的手势，并且手势的方向是侧滑的方向就让多个手势共存
        if (point.x > 0) {
            return YES;
        }
    }
    return NO;
}
-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self setNavigationBarHidden:NO animated:animated];
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[UIImage new]];
}
@end
