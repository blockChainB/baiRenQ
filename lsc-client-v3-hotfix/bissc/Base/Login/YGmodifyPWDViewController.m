//
//  YGmodifyPWDViewController.m
//  bissc
//
//  Created by 龙广发 on 2019/10/14.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import "YGmodifyPWDViewController.h"


#import "YGForgetViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
//#import "GTMBase64.h"
#import "TabBarViewController.h"
// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
@interface YGmodifyPWDViewController (){
    int second;
}

@property(nonatomic,strong) UILabel *titleLB;


@property(nonatomic,strong) UIButton *deletedBtn;
@property(nonatomic,strong) UIButton *eyeBtn;
@property(nonatomic,strong) UIButton *codeBtn;

@property(nonatomic,strong) UIView *phoneView;
@property(nonatomic,strong) UIView *codeView;
@property(nonatomic,strong) UIView *passwordView;
@property(nonatomic,strong) UIView *companyCodeView;



@property(nonatomic,strong) UITextField *phoneTF;
@property(nonatomic,strong) UITextField *passwordTF;
@property(nonatomic,strong) UITextField *codeTF;
@property(nonatomic,strong) UITextField *companyCodeTF;

@property(nonatomic,strong) UIButton *okBtn;
@property (nonatomic ,strong) NSTimer *timer;    //   定时器
@property(nonatomic,strong) UIButton *backBtn;


@end

@implementation YGmodifyPWDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = appBgRGBColor;
    second = 60;
    
    [self createUI];
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
    svContentView.backgroundColor = [UIColor colorWithHexString:@"##FFFFFF"];;
    
    
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
    
    
    
    UILabel *contentLB = [[UILabel alloc] init];
    contentLB.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    contentLB.textAlignment = NSTextAlignmentCenter;
    contentLB.text = @"账号";
    contentLB.font=[UIFont systemFontOfSize:14*_Scaling];
    [svContentView addSubview:contentLB];
    
    
    _phoneTF = [[UITextField alloc] init];
    _phoneTF.placeholder = @"请输入手机号码";
    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    _phoneTF.font=[UIFont systemFontOfSize:16*_Scaling];
    
    UIButton *openEye = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [getVetfiyBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    //    [getVetfiyBtn setTitleColor:[UIColor colorWithHexString:@"#007AFF"] forState:UIControlStateNormal];
    //    getVetfiyBtn.titleLabel.font = [UIFont systemFontOfSize:12*_Scaling];
    [openEye setImage:[UIImage imageNamed:@"openEye"] forState:UIControlStateNormal];
    [openEye addTarget:self action:@selector(openEyeClick) forControlEvents:(UIControlEventTouchUpInside)];
    [svContentView addSubview:openEye];
    
    
    
    [svContentView addSubview:_phoneTF];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    [svContentView addSubview:lineView];
    
    
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
    
    
    UIButton *nexBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [nexBtn setTitle:@"提交" forState:(UIControlStateNormal)];
    [nexBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    //    [nexBtn setBackgroundColor:[UIColor colorWithHexString:@"#1C99FF"]]; #EEEEEE
    [nexBtn setBackgroundColor:[UIColor colorWithHexString:@"#007AFF"]];
    nexBtn.titleLabel.font = [UIFont systemFontOfSize:16*_Scaling];
    nexBtn.layer.cornerRadius = 5*_Scaling;
    nexBtn.layer.masksToBounds = YES;
    [nexBtn addTarget:self action:@selector(nextAction) forControlEvents:(UIControlEventTouchUpInside)];
    
    [svContentView addSubview:nexBtn];
//    closeEye openEye
    
    UIButton *closeEye = [UIButton buttonWithType:UIButtonTypeCustom];
//    [getVetfiyBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
//    [getVetfiyBtn setTitleColor:[UIColor colorWithHexString:@"#007AFF"] forState:UIControlStateNormal];
//    getVetfiyBtn.titleLabel.font = [UIFont systemFontOfSize:12*_Scaling];
    [closeEye setImage:[UIImage imageNamed:@"closeEye"] forState:UIControlStateNormal];
    [closeEye addTarget:self action:@selector(closeEyeAction) forControlEvents:(UIControlEventTouchUpInside)];
    [svContentView addSubview:closeEye];
    
    
    
    [_titleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(40*_Scaling);
    }];
    
    [contentLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(114*_Scaling);
    }];
    
    
    [_phoneTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(148*_Scaling);
        make.right.mas_equalTo(-60*_Scaling);
        make.height.mas_equalTo(16*_Scaling);
    }];
    [openEye mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(148*_Scaling);
        make.right.mas_equalTo(-24*_Scaling);
        make.height.mas_equalTo(16*_Scaling);
    }];
    
    
    [lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(172*_Scaling);
        make.right.mas_equalTo(-24*_Scaling);
        make.height.mas_equalTo(0.5*_Scaling);
    }];
    
    [pwdLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(199*_Scaling);
    }];
    [_passwordTF mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(232*_Scaling);
        make.right.mas_equalTo(-24*_Scaling);
        make.height.mas_equalTo(16*_Scaling);
    }];
    [lineView2 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(256*_Scaling);
        make.right.mas_equalTo(-24*_Scaling);
        make.height.mas_equalTo(0.5*_Scaling);
    }];
    
    
    //nexBtn getVetfiyBtn   UIView *lineView2
    
    [closeEye mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(234*_Scaling);
        make.right.mas_equalTo(-24*_Scaling);
        make.height.mas_equalTo(12*_Scaling);
    }];
    
    [nexBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24*_Scaling);
        make.top.mas_equalTo(307*_Scaling);
        make.right.mas_equalTo(-24*_Scaling);
        make.height.mas_equalTo(44*_Scaling);
    }];
    
    
    
    
    //svHeight servicBtn
    UIView *lastView = nexBtn;
    [svHeight mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(sv);
        make.bottom.mas_equalTo(lastView);
    }];
    
    
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_backBtn setBackgroundImage:[UIImage imageNamed:@"返回-2"] forState:(UIControlStateNormal)];
    _backBtn.frame = CGRectMake(10*_Scaling, 40*_Scaling, 20*_Scaling, 25*_Scaling);
    [_backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_backBtn];
    
    
    _titleLB = [[UILabel alloc] init];
    _titleLB.font = [UIFont fontWithName:@"Arial-BoldMT" size:18*_Scaling];
    
    _titleLB.textColor = kRGBColor(46, 46, 46, 1.0);
    _titleLB.textAlignment = NSTextAlignmentCenter;
    _titleLB.text = @"修改登陆密码";
    
    [self.view addSubview:_titleLB];
    [_titleLB mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(40*_Scaling);
    }];
    
    //
    //    _phoneView = [[UIView alloc] initWithFrame:CGRectMake(38*_Scaling, _titleLB.bottom + 29*_Scaling, __kWidth - 76*_Scaling, 54*_Scaling)];
    //    _phoneView.layer.cornerRadius = 5*_Scaling;
    //    _phoneView.layer.masksToBounds = YES;
    //    _phoneView.layer.borderColor = kRGBColor(214, 214, 214, 1.0).CGColor;
    //    _phoneView.layer.borderWidth = 1.0;
    //    [self.view addSubview:_phoneView];
    //
    //
    //    _phoneTF = [[UITextField alloc] initWithFrame:CGRectMake(17*_Scaling, 12*_Scaling, 250*_Scaling, 30*_Scaling)];
    //    _phoneTF.placeholder = @"请输入手机号码";
    //    _phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    //
    //    [self.phoneView addSubview:_phoneTF];
    //
    //    _deletedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _deletedBtn.frame = CGRectMake(__kWidth - 77*_Scaling, _phoneView.top + 18*_Scaling , 20*_Scaling, 20*_Scaling);
    //    [_deletedBtn setBackgroundImage:[UIImage imageNamed:@"ygk_login_deleted"] forState:(UIControlStateNormal)];
    //    [_deletedBtn addTarget:self action:@selector(deletedAction) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.view addSubview:_deletedBtn];
    //
    //    _codeView = [[UIView alloc] initWithFrame:CGRectMake(38*_Scaling, _phoneView.bottom + 10*_Scaling, 172*_Scaling, 52*_Scaling)];
    //    _codeView.layer.cornerRadius = 5*_Scaling;
    //    _codeView.layer.masksToBounds = YES;
    //    _codeView.layer.borderColor = kRGBColor(214, 214, 214, 1.0).CGColor;
    //    _codeView.layer.borderWidth = 1.0;
    //    [self.view addSubview:_codeView];
    //
    //    _codeTF = [[UITextField alloc] initWithFrame:CGRectMake(17*_Scaling, 12*_Scaling, 250*_Scaling, 30*_Scaling)];
    //    _codeTF.placeholder = @"请输入验证码";
    //    [self.codeView addSubview:_codeTF];
    //
    //    _codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _codeBtn.frame = CGRectMake(__kWidth - 147*_Scaling, _phoneView.bottom + 10*_Scaling , 109*_Scaling, 52*_Scaling);
    //    _codeBtn.titleLabel.font = [UIFont systemFontOfSize:16*_Scaling];
    //    [_codeBtn setTitleColor:goldRGBColor forState:(UIControlStateNormal)];
    //    [_codeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
    //    _codeBtn.layer.cornerRadius = 5*_Scaling;
    //    _codeBtn.layer.masksToBounds = YES;
    //    _codeBtn.layer.borderColor = goldRGBColor.CGColor;
    //    _codeBtn.layer.borderWidth = 1.0;
    //    [_codeBtn addTarget:self action:@selector(codeAction) forControlEvents:(UIControlEventTouchUpInside)];
    //    [self.view addSubview:_codeBtn];
    //
    //    _passwordView = [[UIView alloc] initWithFrame:CGRectMake(38*_Scaling, _codeView.bottom + 10*_Scaling, __kWidth - 76*_Scaling, 54*_Scaling)];
    //    _passwordView.layer.cornerRadius = 5*_Scaling;
    //    _passwordView.layer.masksToBounds = YES;
    //    _passwordView.layer.borderColor = kRGBColor(214, 214, 214, 1.0).CGColor;
    //    _passwordView.layer.borderWidth = 1.0;
    //    [self.view addSubview:_passwordView];
    //
    //    _passwordTF = [[UITextField alloc] initWithFrame:CGRectMake(17*_Scaling, 12*_Scaling, 250*_Scaling, 30*_Scaling)];
    //    _passwordTF.placeholder = @"请设置登录密码";
    //    _passwordTF.secureTextEntry = YES;
    //
    //    [self.passwordView addSubview:_passwordTF];
    //
    //
    //
    //    _eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _eyeBtn.frame = CGRectMake(__kWidth - 77*_Scaling, _passwordView.top + 18*_Scaling , 20*_Scaling, 20*_Scaling);
    //    [_eyeBtn setBackgroundImage:[UIImage imageNamed:@"ygk_login_eye"] forState:(UIControlStateNormal)];
    //    [_eyeBtn addTarget:self action:@selector(eyeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    //
    //    [self.view addSubview:_eyeBtn];
    //
    //
    //    _companyCodeView = [[UIView alloc] init];
    //    _companyCodeView.layer.cornerRadius = 5*_Scaling;
    //    _companyCodeView.layer.masksToBounds = YES;
    //    _companyCodeView.layer.borderColor = kRGBColor(214, 214, 214, 1.0).CGColor;
    //    _companyCodeView.layer.borderWidth = 1.0;
    //
    //    _companyCodeTF = [[UITextField alloc] init];
    //    _companyCodeTF.placeholder = @"请输入公司编码";
    //
    //
    ////
    //    _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [_okBtn setTitle:@"确定" forState:(UIControlStateNormal)];
    //    [_okBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    //    [_okBtn setBackgroundColor:goldRGBColor];
    //    _okBtn.titleLabel.font = [UIFont systemFontOfSize:18*_Scaling];
    //    _okBtn.layer.cornerRadius = 5*_Scaling;
    //    _okBtn.layer.masksToBounds = YES;
    //    [_okBtn addTarget:self action:@selector(okAction) forControlEvents:(UIControlEventTouchUpInside)];
    //
    //    if ([self.status isEqualToString:@"1"]) {
    //        _okBtn.frame = CGRectMake(38*_Scaling, _passwordView.bottom + 21*_Scaling , __kWidth - 76*_Scaling, 49*_Scaling);
    //    }else {
    //        [self.view addSubview:_companyCodeView];
    //        [self.companyCodeView addSubview:_companyCodeTF];
    //        _companyCodeView.frame = CGRectMake(38*_Scaling, _passwordView.bottom + 10*_Scaling, __kWidth - 76*_Scaling, 54*_Scaling);
    //        _companyCodeTF.frame = CGRectMake(17*_Scaling, 12*_Scaling, 250*_Scaling, 30*_Scaling);
    //        _okBtn.frame = CGRectMake(38*_Scaling, _companyCodeView.bottom + 21*_Scaling , __kWidth - 76*_Scaling, 49*_Scaling);
    //    }
    //
    //    [self.view addSubview:_okBtn];
    //
}

- (void)getVetfiyBtnClick:(UIButton *)btn{
    NSLog(@"getVetfiyBtnClick");
}

#pragma mark -- 删除
-(void)deletedAction {
    
    self.phoneTF.text = @"";
    
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
- (void)closeEyeAction{
    NSLog(@"closeEyeAction");
}
- (void)openEyeClick{
    NSLog(@"openEyeClick");
}
#pragma  mark -- 确定 --
-(void)nextAction {
    
    [self.phoneTF resignFirstResponder];
    [self.codeTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    [self.companyCodeTF resignFirstResponder];
    
    if (![UserInfo checkTelNumber:self.phoneTF.text]) {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
    }else if (self.codeTF.text.length == 0){
        [MBProgressHUD showError:@"请输入验证码"];
    }else if (self.passwordTF.text.length == 0){
        [MBProgressHUD showError:@"请输入密码"];
    }else if (self.companyCodeTF.text.length == 0){
        [MBProgressHUD showError:@"请输入公司编码"];
    }else {
        [MBProgressHUD showGifToView:self.view];
        
        NSString * password = [UserInfo sha224:self.passwordTF.text];
        
        if ([self.status isEqualToString:@"1"]) {
            
            NSDictionary *dic1 = @{@"vvCode":self.codeTF.text,@"passWord":password,@"mobile":self.phoneTF.text};
            [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"setting/settingPassword"] Parameters:dic1 callback:^(id obj) {
                NSLog(@"%@",obj);
                [MBProgressHUD hideGifHUDForView:self.view];
                BOOL istrue   = [obj[@"success"] boolValue];
                if (istrue) {
                    [MBProgressHUD showSuccess:obj[@"msg"]];
                    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                }else {
                    [MBProgressHUD showError:obj[@"msg"]];
                }
            }];
            
        }else {
            
//            NSDictionary *dic1 = @{@"vvCode":self.codeTF.text,@"passWord":password,@"openId":self.dataDic[@"openid"],@"mobile":self.phoneTF.text,@"ccCode":self.companyCodeTF.text,@"sex":self.dataDic[@"sex"],@"headimgurl":self.dataDic[@"headimgurl"],@"unionid":self.dataDic[@"unionid"],@"nickname":self.dataDic[@"nickname"]};
//            [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"login/register"] Parameters:dic1 callback:^(id obj) {
//                NSLog(@"%@",obj);
//                BOOL istrue = [obj[@"success"] boolValue];
//                [MBProgressHUD hideGifHUDForView:self.view];
//
//                if (istrue) {//请求成功
//                    [self logoinMoblie:self.phoneTF.text password:password];
//                }else {
//                    [MBProgressHUD showError:obj[@"msg"]];
//                }
//            }];
            
        }
    }
}

#pragma mark -- 获取验证码
-(void)codeAction {
    
    if ([UserInfo checkTelNumber:self.phoneTF.text]) {
        [MBProgressHUD showGifToView:self.view];
        NSDictionary *dic = @{@"phone":self.phoneTF.text};
        [YGHttpRequest GETDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"login/getVerificationCode"] Parameters:dic callback:^(id obj) {
            NSLog(@"%@",obj);
            BOOL istrue   = [obj[@"success"] boolValue];
            [MBProgressHUD hideGifHUDForView:self.view];
            if (istrue) {
                self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(addRippleLayer) userInfo:nil repeats:YES];
                [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
                
                [MBProgressHUD showSuccess:obj[@"msg"]];
            }else {
                [MBProgressHUD showError:obj[@"msg"]];
            }
        }];
        
    }else {
        [MBProgressHUD showError:@"请输入正确的手机号码"];
    }
}

-(void) addRippleLayer {
    
    second --;
    [_codeBtn setTitle:[NSString stringWithFormat:@"%ds",second] forState:(UIControlStateNormal)];
    _codeBtn.userInteractionEnabled = NO;
    
    if (second == 0) {
        _codeBtn.userInteractionEnabled = YES;
        [_codeBtn setTitle:@"重新获取" forState:(UIControlStateNormal)];
        second = 60;
        [_timer invalidate];
    }
}

-(void)viewWillDisappear:(BOOL)animated {
    
    [_timer invalidate];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.phoneTF resignFirstResponder];
    [self.passwordTF resignFirstResponder];
    [self.codeTF resignFirstResponder];
    
    
}
-(void) backAction {
    NSLog(@"backAction");
    [self.navigationController popViewControllerAnimated:YES ];
}


-(void)logoinMoblie:(NSString *)moble password:(NSString *)password {
    
    
    NSDictionary *dic1 = @{@"mobile":moble,@"password":password};
    [YGHttpRequest POSTDataUrl:[NSString stringWithFormat:@"%@%@",_YGURL,@"login/sigin"] Parameters:dic1 callback:^(id obj) {
        NSLog(@"%@",obj);
        
        NSDictionary *dic = [NSDictionary changeType:obj];
        
        BOOL istrue   = [obj[@"success"] boolValue];
        [MBProgressHUD hideGifHUDForView:self.view];
        if (istrue) {
            
            NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.YGShareExtension"];
            [userDefaults setObject:dic[@"data"][@"id"] forKey:@"memberId"];
            [userDefaults synchronize];
            
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


@end


