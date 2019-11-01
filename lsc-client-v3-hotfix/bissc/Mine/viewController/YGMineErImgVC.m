//
//  YGMineErImgVC.m
//  bissc
//
//  Created by 龙广发 on 2019/10/11.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import "YGMineErImgVC.h"

@interface YGMineErImgVC ()
@property(nonatomic,strong) UIButton *backBtn;
@property(nonatomic,strong) UIButton *rightBtn;
@end

@implementation YGMineErImgVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的名片";
    self.view.backgroundColor = appBgRGBColor;
     self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.backBtn];
     self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    [self configUI];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:false animated:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
     [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
-(void)configUI{
    UIScrollView *sv = [[UIScrollView alloc] init];
    [self.view addSubview:sv];
    UIView *svHeight = [[UIView alloc] init];
    UIView *svContentView = [[UIView alloc] init];
    [sv addSubview:svHeight];
    [sv addSubview:svContentView];
    svContentView.backgroundColor = appBgRGBColor;
    
    
     UIView *topView = [[UIView alloc] init];
    topView.layer.cornerRadius=2.5 *_Scaling;
    topView.layer.masksToBounds=YES;
    topView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
     [svContentView addSubview:topView];
    
    
    UIImageView *hdImg = [[UIImageView alloc] init];
    [topView addSubview:hdImg];
    [hdImg sd_setImageWithURL:[NSURL URLWithString:@"www.baidu.com"] placeholderImage:[UIImage imageNamed:@"er_icon"]];
    ///// headViewNamelable  headViewTitlelable
    UILabel *headViewNamelable = [[UILabel alloc] init];
    headViewNamelable.textColor = [UIColor blackColor];
    headViewNamelable.text  = @"张饭饭";
    [headViewNamelable setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18*_Scaling]];;
    [topView addSubview:headViewNamelable];
    
    
    
    
    UILabel *headViewTitlelable = [[UILabel alloc] init];
    headViewTitlelable.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    headViewTitlelable.text  = @"爱设计科技公司·总经理";
    [headViewTitlelable setFont:[UIFont systemFontOfSize:12*_Scaling]];
    [topView addSubview:headViewTitlelable];
    
    UIImageView *hdImger = [[UIImageView alloc] init];
    [topView addSubview:hdImger];
    [hdImger sd_setImageWithURL:[NSURL URLWithString:@"www.baidu.com"] placeholderImage:[UIImage imageNamed:@"mine图层 12"]];
    
    //////
    
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveBtn setTitle:@"保存到手机" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor colorWithHexString:@"#000000"] forState:UIControlStateNormal];
    [saveBtn setBackgroundColor:[UIColor colorWithHexString:@"#FFFFFF"]];
    saveBtn.layer.cornerRadius=2.5 *_Scaling;
    saveBtn.layer.masksToBounds=YES;
    saveBtn.tag = 1000;
    [saveBtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [svContentView addSubview:saveBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    shareBtn.layer.cornerRadius=2.5 *_Scaling;
    shareBtn.layer.masksToBounds=YES;
    [shareBtn setBackgroundColor:[UIColor colorWithHexString:@"#157DFB"]];
    [shareBtn setTitleColor:[UIColor colorWithHexString:@"#FFFFFF"] forState:UIControlStateNormal];
    shareBtn.tag = 10001;
    [shareBtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
    [svContentView addSubview:shareBtn];
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
    
    
    [topView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.height.mas_equalTo(480*_Scaling);
        make.top.mas_equalTo(10*_Scaling);
    }];
    //
    [hdImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(334*_Scaling);
        make.top.mas_equalTo(0*_Scaling);
    }];
     // headViewNamelable  headViewTitlelable
    [headViewNamelable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20*_Scaling);
        
        make.height.mas_equalTo(18*_Scaling);
        make.top.mas_equalTo(390*_Scaling);
    }];
    [headViewTitlelable mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20*_Scaling);
        
        make.height.mas_equalTo(16*_Scaling);
        make.top.mas_equalTo(420*_Scaling);
    }];
    [hdImger mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20*_Scaling);
         make.width.mas_equalTo(100*_Scaling);
        make.height.mas_equalTo(100*_Scaling);
        make.bottom.mas_equalTo(-20*_Scaling);
    }];
    //
    [saveBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        make.width.mas_equalTo(160*_Scaling);
        make.height.mas_equalTo(40*_Scaling);
        make.top.mas_equalTo(520*_Scaling);
    }];
    
    [shareBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-GAP);
        make.width.mas_equalTo(160*_Scaling);
        make.height.mas_equalTo(40*_Scaling);
        make.top.mas_equalTo(520*_Scaling);
    }];
    
    //svHeight servicBtn
    [svHeight mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(sv);
        make.bottom.mas_equalTo(saveBtn);
    }];
    
    

}
- (void)save:(UIButton *)btn{
    NSLog(@"%ld",btn.tag);
}
-(UIButton *)backBtn {
    
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"返回-2"] forState:(UIControlStateNormal)];
        _backBtn.frame = CGRectMake(10*_Scaling, 40*_Scaling, 20*_Scaling, 25*_Scaling);
        [_backBtn addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _backBtn;
}
-(UIButton *)rightBtn {
    
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setBackgroundImage:[UIImage imageNamed:@"图层 13"] forState:(UIControlStateNormal)];
        _rightBtn.frame = CGRectMake(10*_Scaling, 40*_Scaling, 20*_Scaling, 25*_Scaling);
        [_rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _rightBtn;
}
-(void) rightBtnClick:(UIButton *)btn {
    
    NSLog(@"rightBtnClick");
}
-(void) backAction {
    
    [self.navigationController popViewControllerAnimated:YES];

}
@end
