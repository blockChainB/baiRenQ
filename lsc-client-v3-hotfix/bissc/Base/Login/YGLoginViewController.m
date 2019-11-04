//
//  YGLoginViewController.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/29.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGLoginViewController.h"
#import "TabBarViewController.h"

#import <WechatOpenSDK/WXApi.h>
#import "YGForgetViewController.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface YGLoginViewController ()<WXApiDelegate,UITextFieldDelegate,RCIMUserInfoDataSource>

@property(nonatomic,strong) UILabel *titleLB;
@property(nonatomic,strong) UIImageView *iconImg;
@property(nonatomic,strong) UILabel *contentLB;

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIView *lineView;
@property(nonatomic,strong) UIButton *loginBtn;
@property(nonatomic,strong) UIButton *forgetPasswordBtn;
@property(nonatomic,strong) UIButton *visitorsLoginBtn;

@property(nonatomic,strong) UIImageView *phoneImg;
@property(nonatomic,strong) UIImageView *passwordImg;

@property(nonatomic,strong) UIButton *deletedBtn;
@property(nonatomic,strong) UIButton *eyeBtn;

@property(nonatomic,strong) UITextField *phoneTF;
@property(nonatomic,strong) UITextField *passwordTF;

@property(nonatomic,strong) UIView *lineView2;
@property(nonatomic,strong) UILabel *login;
@property(nonatomic,strong) UIButton *wechatBtn;

@property(nonatomic,strong) UIButton *dismissBtn;

@end


@implementation  YGLoginViewController


-(UIButton *)dismissBtn {
    
    if (!_dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dismissBtn setBackgroundImage:[UIImage imageNamed:@"XX"] forState:(UIControlStateNormal)];
        [_dismissBtn addTarget:self action:@selector(dismissBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _dismissBtn;
}

-(void) dismissBtnAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    self.view.backgroundColor = appBgRGBColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(successLogin) name:@"successLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(registerLogin:) name:@"registerLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXErrCodeUserCancel) name:@"aouthError" object:nil];
    
    
    [self createUI];
}

-(void)WXErrCodeUserCancel {
    
    [MBProgressHUD hideGifHUDForView:self.view];
    [MBProgressHUD showError:@"用户点击取消，微信授权失败"];
}

-(void) viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}


-(void) createUI {
    
    
    UIScrollView *sv = [[UIScrollView alloc] init];
    [self.view addSubview:sv];
    UIView *svHeight = [[UIView alloc] init];
    UIView *svContentView = [[UIView alloc] init];
    [sv addSubview:svHeight];
    [sv addSubview:svContentView];
    svContentView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];;
    
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    
    //laout
    [sv mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        //        make.bottom.left.right.mas_equalTo(0);
        //        make.top.mas_equalTo(91*_Scaling);
        
        
    }];
    
    
    [svContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sv);
        make.width.equalTo(sv);
        make.height.equalTo(svHeight);
    }];
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = [UIFont fontWithName:@"Arial-BoldMT" size:20*_Scaling];
    
    _titleLB.textColor = [UIColor colorWithHexString:@"#222222"];
    //        _titleLB.textAlignment = NSTextAlignmentCenter;
    _titleLB.text = @"您好!\n欢迎来到云谷客";
    _titleLB.numberOfLines = 2;
    [svContentView addSubview:_titleLB];
    
    
    _contentLB = [[UILabel alloc] init];
    _contentLB.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    _contentLB.textAlignment = NSTextAlignmentCenter;
    _contentLB.text = @"账号";
    _contentLB.font=[UIFont systemFontOfSize:12*_Scaling];
    [svContentView addSubview:_contentLB];
    
    
    _phoneTF = [[UITextField alloc] init];
    _phoneTF.placeholder = @"请输入手机号码";
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.font=[UIFont systemFontOfSize:13*_Scaling];
    [_phoneTF addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    
    [svContentView addSubview:_phoneTF];
    
    _lineView = [[UIView alloc] init];
    _lineView.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    [svContentView addSubview:_lineView];
    
    
    
    UILabel *pwdLB = [[UILabel alloc] init];
    pwdLB.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    pwdLB.textAlignment = NSTextAlignmentCenter;
    pwdLB.text = @"密码";
    pwdLB.font=[UIFont systemFontOfSize:12*_Scaling];
    [svContentView addSubview:pwdLB];
    
    _passwordTF = [[UITextField alloc] init];
    _passwordTF.placeholder = @"请输入密码";
    _passwordTF.secureTextEntry = YES;
    _passwordTF.font=[UIFont systemFontOfSize:13*_Scaling];
    [svContentView addSubview:_passwordTF];
    
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    [svContentView addSubview:lineView2];
    
    
    _loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_loginBtn setBackgroundColor:[UIColor colorWithHexString:@"#1C99FF"]];
    _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18*_Scaling];
    _loginBtn.layer.cornerRadius = 5*_Scaling;
    _loginBtn.layer.masksToBounds = YES;
    [_loginBtn addTarget:self action:@selector(loginAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [svContentView addSubview:_loginBtn];
    
    _forgetPasswordBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetPasswordBtn setTitle:@"忘记密码?" forState:(UIControlStateNormal)];
    [_forgetPasswordBtn setTitleColor:[UIColor colorWithHexString:@"#1C99FF"] forState:UIControlStateNormal];
    _forgetPasswordBtn.titleLabel.font = [UIFont systemFontOfSize:12*_Scaling];
    [_forgetPasswordBtn addTarget:self action:@selector(forgetAction) forControlEvents:(UIControlEventTouchUpInside)];
    [svContentView addSubview:_forgetPasswordBtn];
    
    
    
    ///other #EEEEEE
    
    _lineView2 = [[UIView alloc] init];
    _lineView2.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [svContentView addSubview:_lineView2];
    
    UILabel *otherStyleLB = [[UILabel alloc] init];
    otherStyleLB.textColor = [UIColor colorWithHexString:@"#999999"];
    otherStyleLB.textAlignment = NSTextAlignmentCenter;
    otherStyleLB.text = @"其他方式";
    otherStyleLB.font=[UIFont systemFontOfSize:12*_Scaling];
    [svContentView addSubview:otherStyleLB];
    
   UIView *lineView2Right = [[UIView alloc] init];
    lineView2Right.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    [svContentView addSubview:lineView2Right];
    

    UIButton *qqLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    qqLoginBtn.tag = 1000;
    [qqLoginBtn setImage:[UIImage imageNamed:@"qqLogin"] forState:UIControlStateNormal];
    [qqLoginBtn addTarget:self action:@selector(qqLoginBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [svContentView addSubview:qqLoginBtn];
    
    UIButton *wxLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    wxLoginBtn.tag = 1001;
    [wxLoginBtn setImage:[UIImage imageNamed:@"wxLogin"] forState:UIControlStateNormal];
    [wxLoginBtn addTarget:self action:@selector(qqLoginBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [svContentView addSubview:wxLoginBtn];
    
    
    UIButton *webLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    webLoginBtn.tag = 1002;
    [webLoginBtn setImage:[UIImage imageNamed:@"webLogin"] forState:UIControlStateNormal];
    [webLoginBtn addTarget:self action:@selector(qqLoginBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [svContentView addSubview:webLoginBtn];
    

    //    _login = [[UILabel alloc] initWithFrame:CGRectMake((__kWidth - 60*_Scaling)/2.0,_loginBtn.bottom + 97*_Scaling,  60*_Scaling, 12*_Scaling)];
    //    _login.font = [UIFont systemFontOfSize:12*_Scaling];
    //    _login.textColor = kRGBColor(200, 200, 200, 1.0);
    //    _login.backgroundColor = appBgRGBColor;
    //    _login.textAlignment = NSTextAlignmentCenter;
    //    _login.text = @"快速登录";
    //    [self.view addSubview:_login];
    //
    //
    //    _wechatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _wechatBtn.frame = CGRectMake((__kWidth - 44*_Scaling)/2.0, _loginBtn.bottom + 129*_Scaling , 44*_Scaling, 44*_Scaling);
    //    [_wechatBtn setBackgroundImage:[UIImage imageNamed:@"ygk_login_wechat"] forState:(UIControlStateNormal)];
    //    [_wechatBtn addTarget:self action:@selector(wechatLoginAction) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.view addSubview:_wechatBtn];
    
    
    
    
    [_titleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(104*_Scaling);
    }];
    
    [_contentLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(211*_Scaling);
    }];
    
    
    [_phoneTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(237*_Scaling);
        make.right.mas_equalTo(-24*_Scaling);
        make.height.mas_equalTo(13*_Scaling);
    }];
    
    [_lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(256*_Scaling);
        make.right.mas_equalTo(-24*_Scaling);
        make.height.mas_equalTo(0.5*_Scaling);
    }];
    
    [pwdLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(286*_Scaling);
    }];
    [_passwordTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(313*_Scaling);
        make.right.mas_equalTo(-24*_Scaling);
        make.height.mas_equalTo(13*_Scaling);
    }];
    [lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(331*_Scaling);
        make.right.mas_equalTo(-24*_Scaling);
        make.height.mas_equalTo(0.5*_Scaling);
    }];
    [_forgetPasswordBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(347*_Scaling);
        make.right.mas_equalTo(-24*_Scaling);
        make.height.mas_equalTo(12*_Scaling);
    }];
    
    [_loginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(422*_Scaling);
        make.right.mas_equalTo(-24*_Scaling);
        make.height.mas_equalTo(44*_Scaling);
    }];
    
    
    ///other  _lineView2
    [_lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(37*_Scaling);
        make.top.mas_equalTo(521*_Scaling);
        make.width.mas_equalTo(115*_Scaling);
        make.height.mas_equalTo(0.5*_Scaling);
    }];
    
    
    [otherStyleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(164*_Scaling);
        make.top.mas_equalTo(516*_Scaling);
        
        make.height.mas_equalTo(12*_Scaling);
    }];
    
    
        [lineView2Right mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-37*_Scaling);
            make.top.mas_equalTo(521*_Scaling);
            make.width.mas_equalTo(115*_Scaling);
            make.height.mas_equalTo(0.5*_Scaling);
        }];
    ///wxLogin
    //qqLoginBtn  wxLoginBtn   webLoginBtn
    
    
    [qqLoginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(107*_Scaling);
        make.top.mas_equalTo(546*_Scaling);
        make.width.mas_equalTo(33*_Scaling);
        make.height.mas_equalTo(33*_Scaling);
    }];
    
    [wxLoginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(171*_Scaling);
        make.top.mas_equalTo(546*_Scaling);
        make.width.mas_equalTo(33*_Scaling);
        make.height.mas_equalTo(33*_Scaling);
    }];
    [webLoginBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(234*_Scaling);
        make.top.mas_equalTo(546*_Scaling);
        make.width.mas_equalTo(33*_Scaling);
        make.height.mas_equalTo(33*_Scaling);
    }];
    //svHeight servicBtn
    [svHeight mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(sv);
        make.bottom.mas_equalTo(qqLoginBtn);
    }];
    
    
    
    
    
    //
    //    _titleLB = [[UILabel alloc] initWithFrame:CGRectMake(100*_Scaling, 43*_Scaling, __kWidth - 200*_Scaling, 18*_Scaling)];
    //    _titleLB.font = [UIFont systemFontOfSize:18*_Scaling];
    //    _titleLB.textColor = kRGBColor(46, 46, 46, 1.0);
    //    _titleLB.textAlignment = NSTextAlignmentCenter;
    //    _titleLB.text = @"登录";
    //    [self.view addSubview:_titleLB];
    //
    //
    //
    //
    //
    //    _iconImg = [[UIImageView alloc] initWithFrame:CGRectMake((__kWidth - 90*_Scaling)/2.0, _titleLB.bottom + 20*_Scaling, 90*_Scaling, 90*_Scaling)];
    //    _iconImg.image = [UIImage imageNamed:@"ygk_login_icon"];
    //    [self.view addSubview:_iconImg];
    //
    
    //
    //    _bgView = [[UIView alloc] initWithFrame:CGRectMake(38*_Scaling, _iconImg.bottom + 70*_Scaling, __kWidth - 76*_Scaling, 106*_Scaling)];
    //    _bgView.layer.cornerRadius = 5*_Scaling;
    //    _bgView.layer.masksToBounds = YES;
    //    _bgView.layer.borderColor = kRGBColor(214, 214, 214, 1.0).CGColor;
    //    _bgView.layer.borderWidth = 1.0*_Scaling;
    //    [self.view addSubview:_bgView];
    //
    //    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0*_Scaling,53*_Scaling, __kWidth - 76*_Scaling, 1*_Scaling)];
    //    _lineView.backgroundColor = kRGBColor(214, 214, 214, 1.0);
    //    [self.bgView addSubview:_lineView];
    //
    //
    //
    //    _phoneImg= [[UIImageView alloc] initWithFrame:CGRectMake(12*_Scaling, 13*_Scaling, 25*_Scaling, 25*_Scaling)];
    //    _phoneImg.image = [UIImage imageNamed:@"ygk_login_phone"];
    //    [self.bgView addSubview:_phoneImg];
    //
    //    _passwordImg= [[UIImageView alloc] initWithFrame:CGRectMake(12*_Scaling, 68*_Scaling, 25*_Scaling, 25*_Scaling)];
    //    _passwordImg.image = [UIImage imageNamed:@"ygk_login_password"];
    //    [self.bgView addSubview:_passwordImg];
    //
    //    _deletedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _deletedBtn.frame = CGRectMake(_bgView.right - 80*_Scaling, 17*_Scaling , 25*_Scaling, 25*_Scaling);
    //    [_deletedBtn setBackgroundImage:[UIImage imageNamed:@"ygk_login_deleted"] forState:(UIControlStateNormal)];
    //    [_deletedBtn addTarget:self action:@selector(deletedAction) forControlEvents:(UIControlEventTouchUpInside)];
    //    _deletedBtn.hidden = YES;
    //    [self.bgView addSubview:_deletedBtn];
    //
    //    _eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _eyeBtn.frame = CGRectMake(_bgView.right - 80*_Scaling, 68*_Scaling , 25*_Scaling, 25*_Scaling);
    //    [_eyeBtn setBackgroundImage:[UIImage imageNamed:@"ygk_login_eye"] forState:(UIControlStateNormal)];
    //    [_eyeBtn addTarget:self action:@selector(eyeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //
    //    [self.bgView addSubview:_eyeBtn];
    //
    //    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(57*_Scaling, 11*_Scaling, 200*_Scaling, 30*_Scaling)];
    //    _phoneTF.placeholder = @"请输入手机号码";
    //    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    //    [_phoneTF addTarget:self action:@selector(textField1TextChange:) forControlEvents:UIControlEventEditingChanged];
    //
    //    [self.bgView addSubview:_phoneTF];
    //
    //
    //    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(57*_Scaling, 65*_Scaling, 200*_Scaling, 30*_Scaling)];
    //    _passwordTF.placeholder = @"请输入密码";
    //    _passwordTF.secureTextEntry = YES;
    //    [self.bgView addSubview:_passwordTF];
    //
    //
    
    //
    //    _visitorsLoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _visitorsLoginBtn.frame = CGRectMake(38*_Scaling, _loginBtn.bottom + 20*_Scaling , 60*_Scaling, 16*_Scaling);
    //    [_visitorsLoginBtn setTitle:@"游客登录" forState:(UIControlStateNormal)];
    //    [_visitorsLoginBtn setTitleColor:grayRGBColor forState:UIControlStateNormal];
    //    _visitorsLoginBtn.hidden = YES;
    //    _visitorsLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14*_Scaling];
    //    [_visitorsLoginBtn addTarget:self action:@selector(visitorsLoginBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.view addSubview:_visitorsLoginBtn];
    //
    //
    
    //
    //
    //    if ([self.status isEqualToString:@"2"]) {
    ////        [self.view addSubview:self.dismissBtn];
    ////
    ////        [self.dismissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    ////            make.width.height.mas_offset( 17*_Scaling);
    ////            make.top.mas_offset(35*_Scaling);
    ////            make.left.mas_offset(22*_Scaling);
    ////        }];
    //    }
    
}
#pragma mark -- 游客模式
-(void) visitorsLoginBtnAction {
    
    [self.phoneTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    
    [UserInfo sharedUserInfo].cookie = @"";
    [UserInfo sharedUserInfo].isShake = NO;
    [[UserInfo sharedUserInfo] saveToSandbox];
    [[UserInfo sharedUserInfo] loadInfoFromSandbox];
    NSString *file = [NSTemporaryDirectory() stringByAppendingPathComponent:@"YGMineDic.data"];
    [NSKeyedArchiver archiveRootObject:@"" toFile:file];
    
    TabBarViewController *tabar = [[TabBarViewController alloc] init];
    self.view.window.rootViewController = tabar;
}

#pragma mark -- 忘记密码
-(void) forgetAction {

    
        
    NSLog(@"forgetAction");
    YGForgetViewController *controller = [[YGForgetViewController alloc] init];
    controller.status = @"1";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
    
}



#pragma mark -- 登录
-(void) loginAction {
//    deviceUUID
    NSString * password = [UserInfo sha224:@"13265636826"];
//     @"pwd":password
    NSDictionary *dic = @{
                          @"deviceUUID":[UserInfo deviceUUID],
                          @"name":[UIDevice currentDevice].name
                          
                          };
    [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",@"http://192.168.31.114:8082",@"/api/v1/login/sign"] Parameters:dic callback:^(id obj) {
        NSLog(@"obj",obj);
        
    } ];
    
    
    
//    TabBarViewController *tabar = [[TabBarViewController alloc] init];
//
//    self.view.window.rootViewController = tabar;
    
    return;
    
    
    [self.phoneTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    
    if (![UserInfo checkTelNumber:self.phoneTF.text]) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
    }else if (self.passwordTF.text.length == 0){
        [MBProgressHUD showError:@"请输入密码"];
    }else {
        
        [MBProgressHUD showGifToView:self.view];
        
        NSString * password = [UserInfo sha224:self.passwordTF.text];
        
        NSDictionary *dic1 = @{@"mobile":self.phoneTF.text,@"password":password};
        [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"login/sigin"] Parameters:dic1 callback:^(id obj) {
            NSLog(@"%@",obj);
            
            NSDictionary *dic = [NSDictionary changeType:obj];
            
            BOOL istrue   = [obj[@"success"] boolValue];
            [MBProgressHUD hideGifHUDForView:self.view];
            if (istrue) {
                
                NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.YGShareExtension"];
                [userDefaults setObject:dic[@"data"][@"id"] forKey:@"memberId"];
                [userDefaults synchronize];
                [UserInfo sharedUserInfo].siteID = dic[@"data"][@"siteId"];
                [UserInfo sharedUserInfo].token = dic[@"data"][@"token"];
                
                [UserInfo sharedUserInfo].userDic = dic[@"data"];
                [UserInfo sharedUserInfo].isShake = YES;
                
                [[UserInfo sharedUserInfo] saveToSandbox];
                [[UserInfo sharedUserInfo] loadInfoFromSandbox];
                
                TabBarViewController *tabar = [[TabBarViewController alloc] init];
                self.view.window.rootViewController = tabar;
                
#pragma mark - 推送别名设置
                [JPUSHService setAlias:[UserInfo sharedUserInfo].userDic[@"mobile"] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
                } seq:0];
                [JPUSHService setTags:[NSSet setWithObject:@"yunggu"] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
                    
                } seq:0];
            }else {
                [MBProgressHUD showError:dic[@"msg"]];
                
            }
        }];
    }
}

#pragma mark -- 微信登录
-(void)wechatLoginAction {
    
    if ([WXApi isWXAppInstalled]) {
        SendAuthReq *req = [[SendAuthReq alloc] init];
        req.scope        = @"snsapi_userinfo";
        req.state           = @"123";
        [WXApi sendReq:req completion:nil];
        [MBProgressHUD showGifToView:self.view];
    }else {
        [self sendLoginMsgToWweiXinWebPage];
    }
}


- (void) sendLoginMsgToWweiXinWebPage {
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo";
    req.state = @"pedometer_binding";
    [WXApi sendAuthReq:req viewController:self delegate:self completion:nil];
   
}


#pragma mark -- 删除  //
-(void)deletedAction {
    
    self.phoneTF.text = @"";
    
}
-(void)qqLoginBtnClick:(UIButton *)sender {
    NSLog(@"qqLoginBtnClick %ldouble",(long)sender.tag);
}
#pragma mark -- 密码明文
-(void)eyeAction:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.passwordTF.secureTextEntry = NO;
    }else {
        self.passwordTF.secureTextEntry = YES;
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.phoneTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    
}

#pragma mark --登录
-(void)successLogin {
    
#pragma mark - 推送别名设置
    [JPUSHService setAlias:[UserInfo sharedUserInfo].userDic[@"mobile"] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
    } seq:0];
    
    [JPUSHService setTags:[NSSet setWithObject:@"yunggu"] completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
    } seq:0];
    
    TabBarViewController *tabar = [[TabBarViewController alloc] init];
    
    self.view.window.rootViewController = tabar;
}

#pragma mark -- 去绑定手机号码
-(void) registerLogin:(NSNotification *)noti {
    
    [MBProgressHUD hideGifHUDForView:self.view];
    YGForgetViewController *controller = [[YGForgetViewController alloc] init];
    controller.status = @"2";
    controller.dataDic = noti.object;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)textField1TextChange:(UITextField *)textField{
    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    if (textField.text.length == 0) {
        self.deletedBtn.hidden = YES;
    }else {
        self.deletedBtn.hidden = NO;
    }
}
@end





