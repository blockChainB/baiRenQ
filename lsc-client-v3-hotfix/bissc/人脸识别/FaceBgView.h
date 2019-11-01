//
//  FaceBgView.h
//  clientservice
//
//  Created by 龙广发 on 2018/9/1.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FaceBgView : UIView

// 拍照录入 UI
@property(nonatomic,strong) UIImageView *leftTopImageView;
@property(nonatomic,strong) UIImageView *leftBottomImageView;
@property(nonatomic,strong) UIImageView *rightTopImageView;
@property(nonatomic,strong) UIImageView *rightBottomImageView;


@property(nonatomic,strong) UIView *leftView;
@property(nonatomic,strong) UIView *rightView;
@property(nonatomic,strong) UIView *topView;
@property(nonatomic,strong) UIView *bottomView;

@property(nonatomic,strong) UILabel *titleLabel1;
@property(nonatomic,strong) UILabel *titleLabel2;

@property(nonatomic,strong) UIImageView *imageView;

@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton *doneBtn;
@property(nonatomic,strong) UIButton *backBtn;


@property(nonatomic,strong) UILabel *leftLabel;
@property(nonatomic,strong) UILabel *englishleftLabel;

@property(nonatomic,strong) UILabel *rightLabel;
@property(nonatomic,strong) UILabel *englishrightLabel;

@property(nonatomic,strong) UIImageView *titleImageV;

@property(nonatomic,strong) UIButton *rightBtn;


@end
