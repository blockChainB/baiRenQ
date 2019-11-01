//
//  YGMineController.m
//  bissc
//
//  Created by 龙广发 on 2019/9/27.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import "YGMineController.h"
#import "YGMineErImgVC.h"
@interface YGMineController ()

@end

@implementation YGMineController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = appBgRGBColor;
    [self createUI];
}
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)createUI{
    UIScrollView *sv = [[UIScrollView alloc] init];
    [self.view addSubview:sv];
    UIView *svHeight = [[UIView alloc] init];
    UIView *svContentView = [[UIView alloc] init];
    [sv addSubview:svHeight];
    [sv addSubview:svContentView];
    svContentView.backgroundColor = appBgRGBColor;
    
    UIView *headView = [[UIView alloc] init];
    headView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    headView.layer.cornerRadius=5;
    headView.layer.masksToBounds = true;
    [svContentView addSubview:headView];
    
    UILabel *headViewNamelable = [[UILabel alloc] init];
    headViewNamelable.textColor = [UIColor blackColor];
    headViewNamelable.text  = @"张饭饭";
    [headViewNamelable setFont:[UIFont fontWithName:@"Arial-BoldMT" size:18*_Scaling]];;
    [headView addSubview:headViewNamelable];
    
    UIImageView *hdImg = [[UIImageView alloc] init];
    [headView addSubview:hdImg];
    [hdImg sd_setImageWithURL:[NSURL URLWithString:@"www.baidu.com"] placeholderImage:[UIImage imageNamed:@"图层 4"]];
    
    
    UILabel *headViewTitlelable = [[UILabel alloc] init];
    headViewTitlelable.textColor = [UIColor colorWithHexString:@"#CCCCCC"];
    headViewTitlelable.text  = @"爱设计科技公司·总经理";
    [headViewTitlelable setFont:[UIFont systemFontOfSize:12*_Scaling]];
    [headView addSubview:headViewTitlelable];
    
    
    UIImageView *erImg = [[UIImageView alloc] init];
    [headView addSubview:erImg];
    erImg.image =[UIImage imageNamed:@"图层 5"];
    erImg.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapErImg:)];
    [erImg addGestureRecognizer:tap];
    
    
    UIImageView *hdLogeImg = [[UIImageView alloc] init];
    [headView addSubview:hdLogeImg];
    hdLogeImg.image =[UIImage imageNamed:@"图层 6"];
    
    //cell emailCellView
    UIView *emailCellView = [self createCellViewImgName:@"图层 7" title:@"邮件"];
    emailCellView.tag = 1000;
    [svContentView addSubview:emailCellView];
    
    
    UIView *docCellView = [self createCellViewImgName:@"图层 9" title:@"文档"];
    docCellView.tag = 1001;
    [svContentView addSubview:docCellView];
    
    
    
    UIView *orderCellView = [self createCellViewImgName:@"图层 11" title:@"订单"];
    orderCellView.tag = 1002;
    [svContentView addSubview:orderCellView];
    
    
    UIView *settingCellView = [self createCellViewImgName:@"矢量智能对象" title:@"设置"];
    settingCellView.tag = 1003;
    [svContentView addSubview:settingCellView];
    
    
    UIView *feedbackCellView = [self createCellViewImgName:@"图层 12" title:@"反馈"];
    feedbackCellView.tag = 1004;
    [svContentView addSubview:feedbackCellView];
    
    
    
    //laout  orderCellView  settingCellView  feedbackCellView
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
    //headView
    [headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.top.mas_equalTo(28*_Scaling);
        make.height.mas_equalTo(175*_Scaling);
        
    }];
    
    [headViewNamelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20*_Scaling);
        make.top.mas_equalTo(31*_Scaling);
        make.height.mas_equalTo(17*_Scaling);
        
    }];
    [hdImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20*_Scaling);
        make.top.mas_equalTo(20*_Scaling);
        make.height.width.mas_equalTo(50*_Scaling);
    }];
    [headViewTitlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20*_Scaling);
        make.top.mas_equalTo(59*_Scaling);
        make.height.mas_equalTo(17*_Scaling);
        make.right.mas_lessThanOrEqualTo(-80*_Scaling);
    }];
    [erImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20*_Scaling);
        make.bottom.mas_equalTo(-17*_Scaling);
        make.height.width.mas_equalTo(25*_Scaling);
    }];
    [hdLogeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20*_Scaling);
        make.bottom.mas_equalTo(-17*_Scaling);
        make.width.mas_equalTo(55*_Scaling);
        make.height.mas_equalTo(29*_Scaling);
    }];
    
    //emailCellView
    
    [emailCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.top.mas_equalTo(220*_Scaling);
        make.height.mas_equalTo(45*_Scaling);
        
    }];
    
    [docCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.top.mas_equalTo(270*_Scaling);
        make.height.mas_equalTo(45*_Scaling);
        
    }];
    
    [orderCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.top.mas_equalTo(320*_Scaling);
        make.height.mas_equalTo(45*_Scaling);
        
    }];
    
    [settingCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.top.mas_equalTo(370*_Scaling);
        make.height.mas_equalTo(45*_Scaling);
        
    }];
    
    [feedbackCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(GAP);
        make.right.mas_equalTo(-GAP);
        make.top.mas_equalTo(420*_Scaling);
        make.height.mas_equalTo(45*_Scaling);
        
    }];
    
    
    //svHeight servicBtn
    [svHeight mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(sv);
        make.bottom.mas_equalTo(feedbackCellView);
    }];
    
}
- (UIView *)createCellViewImgName:(NSString *)imgName title:(NSString *)title{
    UIView *cellView = [[UIView alloc] init];
    cellView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    
    UIImageView *emailCellImg = [[UIImageView alloc] init];
    [cellView addSubview:emailCellImg];
    emailCellImg.image =[UIImage imageNamed:imgName];
    
    
    UILabel *emailCellLable = [[UILabel alloc] init];
    emailCellLable.textColor = [UIColor colorWithHexString:@"#000000"];
    emailCellLable.text  = title;
    [emailCellLable setFont:[UIFont systemFontOfSize:16*_Scaling]];
    [cellView addSubview:emailCellLable];
    
    
    
    UIImageView *emailCellRightImg = [[UIImageView alloc] init];
    [cellView addSubview:emailCellRightImg];
    emailCellRightImg.image =[UIImage imageNamed:@"图层 15"];
    [emailCellImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(6*_Scaling);
        make.height.width.mas_equalTo(25*_Scaling);
        make.centerY.mas_equalTo(cellView);
    }];
    [emailCellLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(44*_Scaling);
        make.height.mas_equalTo(15*_Scaling);
        make.centerY.mas_equalTo(cellView);
    }];
    [emailCellRightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-GAP);
        //        make.height.mas_equalTo(13*_Scaling);
        //        make.width.mas_equalTo(7*_Scaling);
        make.centerY.mas_equalTo(cellView);
    }];
    
    UITapGestureRecognizer *emailCellTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCell:)];
    cellView.userInteractionEnabled = YES;
    [cellView addGestureRecognizer:emailCellTap];
    
    cellView.layer.cornerRadius=5;
    cellView.layer.masksToBounds = true;
    
    return cellView;
}
// event
- (void)tapErImg:(UITapGestureRecognizer *)tap{
    NSLog(@"tapErImg:(UITapGestureRecognizer");
    YGMineErImgVC *vc = [[YGMineErImgVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (void)tapCell:(UITapGestureRecognizer *)tap{
    NSLog(@"tapCell:(UITapGestureRecognizer,%ld",tap.view.tag);
}
@end
