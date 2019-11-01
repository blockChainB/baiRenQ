//
//  YGHtmlViewController.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/9.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGHtmlViewController.h"
#import "Reachability.h"

#import <WebKit/WebKit.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface YGHtmlViewController ()<WKNavigationDelegate,WKUIDelegate,UIScrollViewDelegate,WKScriptMessageHandler>
@property(nonatomic,strong)WKWebView *webView;
@property (strong, nonatomic) UIProgressView *progressView;
@property (assign, nonatomic) BOOL allowZoom;
@property (assign, nonatomic) BOOL istitle;

@end

@implementation YGHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    self.view.backgroundColor = [UIColor whiteColor];
    
    [UserInfo sharedUserInfo].isAdStr = @"";
    [[UserInfo sharedUserInfo] saveToSandbox];
    [[UserInfo sharedUserInfo] loadInfoFromSandbox];

    self.istitle = NO;
    self.allowZoom = YES;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"ygk_InfomationDetail_分享"] forState:(UIControlStateNormal)];
    [rightBtn addTarget:self action:@selector(rightBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    rightBtn.frame = CGRectMake(0, 0, 16, 16);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];


    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    //fixbug <header class="mui-bar mui-bar-nav"> @"$('meta[name=description]').remove();$(document.getElementsByClassName('mui-bar mui-bar-nav')).remove();$('header').remove(); $('head').append( '<meta name=\"viewport\" content=\"width=device-width, initial-scale=1,user-scalable=no\">' );";
    
    
    WKUserContentController *userController = [WKUserContentController new];
    NSString *js = @"$('.mui-bar').remove();$('.mui-bar-nav').remove();";
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:NO];
    [userController addUserScript:script];
    [userController addScriptMessageHandler:self name:@"openInfo"];
    
    
    configuration.userContentController = userController;
    
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 10;
    configuration.preferences = preferences;
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, __kWidth , __kHeight- LGF_StatusAndNavBar_Height ) configuration:configuration];

    self.webView.scrollView.delegate = self;
    [self.webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];

    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?ss=22",_V2h5URL,@"html5/getFair"]]]];
    
    if ([self.status isEqualToString:@"88"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&type=2&siteId=%@",self.url,[UserInfo sharedUserInfo].siteID]]]];
        
    }else if ([self.status isEqualToString:@"99"]) {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.url]]]];
    }else if ([self.status isEqualToString:@"100"]) {
        [MBProgressHUD showGifToView:self.webView];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@?memberId=%@&siteId=%@&type=2&companyId=%@&isAdmin=%@",self.url,[UserInfo sharedUserInfo].userDic[@"id"],[UserInfo sharedUserInfo].siteID,[UserInfo sharedUserInfo].userDic[@"companyId"],[[UserInfo sharedUserInfo].userDic[@"companyRole"] isEqualToString:@"admin"]?@"1":@"0"]]]];
        
    }else {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?memberId=%@&siteId=%@&phoneType=%@&phoneVersion=%@&netWork=%@&orgId=%@&id=%@",_V2h5URL,@"html5/getNewsDetails",[UserInfo sharedUserInfo].userDic[@"id"],[UserInfo sharedUserInfo].siteID,@"IOS",[UserInfo deviceUUID],[self getReachableVia],@"",self.infomationID]]]];
    }
    
    self.webView.navigationDelegate = self;
    //    self.webView.scrollView.delegate = self;
    self.webView.UIDelegate = self;
    //开了支持滑动返回
    
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


-(void) rightBtnAction {
    
    NSArray *baseDisplaySnsPlatforms = @[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Sina)];
    
    [UMSocialUIManager setPreDefinePlatforms:baseDisplaySnsPlatforms];
    
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
        
        //创建网页内容对象
        UMShareWebpageObject*shareObject = [UMShareWebpageObject shareObjectWithTitle:@"云谷客" descr:self.titleStr thumImage:[UIImage imageNamed:@"ygk_login_icon"]];
        if ([self.status isEqualToString:@"88"] || [self.status isEqualToString:@"99"]) {
            shareObject.webpageUrl = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@?id=%@",self.url,[UserInfo sharedUserInfo].userDic[@"id"]]];

        }else {
            shareObject.webpageUrl = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%@%@?id=%@",_V2h5URL,@"html5/getNewsDetails",self.infomationID]];
        }
        
        messageObject.shareObject= shareObject;
        
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
            
            NSDictionary *dic = @{@"siteId":[UserInfo sharedUserInfo].siteID,@"memberId":[UserInfo sharedUserInfo].userDic[@"id"],@"shareUrl":[NSString stringWithFormat:@"%@?id=%@",shareObject.webpageUrl,[UserInfo sharedUserInfo].userDic[@"id"]],@"type":@"0"};
            
            [YGHttpRequest POSTDataUrl:@"share/saveShareRecord" Parameters:dic callback:^(id obj) {
                NSLog(@"%@",obj);
            }];
            
            UMSocialShareResponse *re = result;
            if (error) {
                UMSocialLogInfo(@"************Share fail with error %@*********",error);
            }else {
                
                if ([result isKindOfClass:[UMSocialShareResponse class]]) {
                    
                    UMSocialShareResponse *resp = result;
                    UMSocialLogInfo(@"response message is %@",resp.message);
                    UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                }else {
                    UMSocialLogInfo(@"response data is %@",result);
                }
            }
        }];
        
    }];
}





-(NSString *) getReachableVia {
    
    NSString *ReachableVia;
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.hcios.com"];
    
    switch([reach currentReachabilityStatus]){
            
        case ReachableViaWWAN:
            
        {
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            NSString *currentStatus = info.currentRadioAccessTechnology;
            
            
            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                
                ReachableVia = @"2G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                
                ReachableVia = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                
                ReachableVia = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                
                ReachableVia = @"3G";
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                
                ReachableVia = @"4G";
            }
        }
            break;
        case ReachableViaWiFi:
            ReachableVia = @"WIFI";
            break;
        default:
            ReachableVia = @"";
            break;
            
    }
    return ReachableVia;
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
                [MBProgressHUD hideGifHUDForView:self.webView];
            }];
        }
    }else if ([keyPath isEqualToString:@"title"]){
        
        if (object == self.webView){
            
            if (self.istitle == NO) {
                self.navigationItem.title = self.webView.title;
                self.istitle = YES;
            }
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
        
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    if (navigationType == UIWebViewNavigationTypeBackForward) {
        
        self.webView.canGoBack?[self.webView goBack]:[self.navigationController popViewControllerAnimated:YES];
        
    }
    return YES;
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
    
    self.allowZoom = NO;
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    self.progressView.hidden = YES;
    
    [MBProgressHUD showError:@"加载失败"];
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];

}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    
    if ([message.name isEqualToString:@"getCompanyDetails"]) {
        
        NSArray *array = [message.body componentsSeparatedByString:@","]; //从字符A中分隔成2个元素的数组

//        YGCompantDetailController *controller = [[YGCompantDetailController alloc] init];
//        controller.hidesBottomBarWhenPushed = YES;
//        controller.companyId = array[0];
//        controller.companyName =  array[1];
//        [self.navigationController pushViewController:controller animated:YES];
//        
    }else if ([message.name isEqualToString:@"goBackAction"]){
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([message.name isEqualToString:@"goUserHome"]){
        
//        YGUserDyController *controller = [[YGUserDyController alloc] init];
//        controller.hidesBottomBarWhenPushed = YES;
//        controller.membersId = message.body;
//        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([self.status isEqualToString:@"100"]) {
        [self.navigationController setNavigationBarHidden:YES animated:animated];
    }else {
        [self.navigationController setNavigationBarHidden:NO animated:animated];
    }
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"getCompanyDetails"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"goBackAction"];
    [self.webView.configuration.userContentController addScriptMessageHandler:self name:@"goUserHome"];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 因此这里要记得移除handlers
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"getCompanyDetails"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"goBackAction"];
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:@"goUserHome"];

}



- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    if(!self.allowZoom){
        return nil;
    }else{
        return self.webView.scrollView.subviews.firstObject;
    }
}





@end
