//
//  XieyiViewController.m
//  clientservice
//
//  Created by 龙广发 on 2018/10/6.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "XieyiViewController.h"

#import <WebKit/WebKit.h>
@interface XieyiViewController ()<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate>

@property(nonatomic,strong)WKWebView *webView;
@property (strong, nonatomic) UIProgressView *progressView;
@property (assign, nonatomic) BOOL allowZoom;

@end

@implementation XieyiViewController




-(void) backAction {

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"用户协议";;
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame =CGRectMake(0,0, 20, 20);
    //    [rightBtn setTitle:@"搜索" forState:(UIControlStateNormal)];
    [leftBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:(UIControlStateNormal)];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    UIBarButtonItem  *leftBar = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.navigationItem.leftBarButtonItem = leftBar;
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 10;
    configuration.preferences = preferences;
    
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, __kWidth , __kHeight) configuration:configuration];
    self.webView.scrollView.delegate = self;
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.likone.cn/help/app/help_app_register.html"]]];
    
    //开了支持滑动返回
    self.allowZoom = YES;
    
    [self.view addSubview:self.webView];
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 1)];
    self.progressView.trackTintColor = [UIColor grayColor]; // 设置进度条的色彩
    self.progressView.progressTintColor = [UIColor blackColor];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    [self.progressView setProgress:0.1 animated:YES];
    
    [self.view addSubview:self.progressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = self.webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
                
            }];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}




// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{//这里修改导航栏的标题，动态改变
    
    //加载完成后隐藏progressView
    self.progressView.hidden = YES;

    
}


// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    self.progressView.hidden = YES;
    [MBProgressHUD showError:@"加载失败"];

    
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}




- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    
    
    return nil;
}

@end
