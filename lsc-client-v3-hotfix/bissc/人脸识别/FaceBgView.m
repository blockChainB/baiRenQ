//
//  FaceBgView.m
//  clientservice
//
//  Created by 龙广发 on 2018/9/1.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "FaceBgView.h"
#define Width (__kWidth -96)

@implementation FaceBgView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self createbgUI];
        [self Masonry];

    }
    return self;
}

-(void) createbgUI {
    
    [self addSubview:self.leftView];
    [self addSubview:self.rightView];
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    
    [self addSubview:self.titleLabel1];
    [self addSubview:self.titleLabel2];
    [self addSubview:self.cancelBtn];
    
    [self.cancelBtn addSubview:self.leftLabel];
    [self.cancelBtn addSubview:self.englishleftLabel];
    
    [self addSubview:self.doneBtn];
    [self.doneBtn addSubview:self.rightLabel];
    [self.doneBtn addSubview:self.englishrightLabel];
    
    [self addSubview:self.imageView];
    [self addSubview:self.titleImageV];
    
    [self addSubview:self.leftTopImageView];
    [self addSubview:self.rightTopImageView];
    [self addSubview:self.leftBottomImageView];
    [self addSubview:self.rightBottomImageView];
    [self addSubview:self.backBtn];
    [self addSubview:self.rightBtn];

    
}
-(void) Masonry {
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(12);
        make.top.mas_offset(35);
        make.width.height.mas_offset(24);
    }];
    [self.titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(102);
        make.height.mas_offset(18);
        make.width.mas_offset(__kWidth);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel1.mas_bottom).mas_offset(4);
        make.height.mas_offset(10);
        make.width.mas_offset(__kWidth);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.width.mas_offset(48);
        make.height.mas_offset(Width);
        make.top.mas_offset((__kHeight - Width)/2.0);

    }];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.width.mas_offset(48);
        make.height.mas_offset(Width);
        make.top.mas_offset((__kHeight - Width)/2.0);
    }];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.width.mas_offset(__kWidth);
        make.centerX.mas_equalTo(self);
        make.height.mas_offset((__kHeight - Width)/2.0);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.width.mas_offset(__kWidth);
        make.centerX.mas_equalTo(self);
        make.height.mas_offset((__kHeight - Width)/2.0);
    }];
    
    [self.leftTopImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_offset(48);
        make.top.mas_offset((__kHeight - Width)/2.0);
        make.width.height.mas_offset(26);
    }];

    [self.rightTopImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.mas_offset(-48);
        make.top.mas_offset((__kHeight - Width)/2.0);
        make.width.height.mas_offset(26);
    }];

    [self.leftBottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_offset(48);
        make.bottom.mas_offset(-(__kHeight - Width)/2.0);
        make.width.height.mas_offset(26);
    }];

    [self.rightBottomImageView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.mas_offset(-48);
        make.bottom.mas_offset(-(__kHeight - Width)/2.0);
        make.width.height.mas_offset(26);
    }];

    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(Width);
        make.centerX.mas_equalTo(self);
        make.top.mas_offset((__kHeight - Width)/2.0);
    }];

    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(75);
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(63);
        make.width.mas_offset(80);
        make.height.mas_offset(32);
    }];



    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-75);
        make.top.mas_equalTo(self.imageView.mas_bottom).mas_offset(63);
        make.width.mas_offset(80);
        make.height.mas_offset(32);
    }];


    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-12);
        make.top.mas_offset(35);
        make.height.mas_offset(24);
        make.height.mas_offset(80);

    }];

}

-(UIImageView *)leftTopImageView {
    
    if (!_leftTopImageView) {
        _leftTopImageView = [[UIImageView alloc] init];
        _leftTopImageView.image = [UIImage imageNamed:@"左上"];
    }
    return _leftTopImageView;
}

-(UIImageView *)rightTopImageView {
    
    if (!_rightTopImageView) {
        _rightTopImageView = [[UIImageView alloc] init];
        _rightTopImageView.image = [UIImage imageNamed:@"右上"];
    }
    return _rightTopImageView;
}


-(UIImageView *)leftBottomImageView {
    
    if (!_leftBottomImageView) {
        _leftBottomImageView = [[UIImageView alloc] init];
        _leftBottomImageView.image = [UIImage imageNamed:@"左下"];
    }
    return _leftBottomImageView;
}

-(UIImageView *)rightBottomImageView {
    
    if (!_rightBottomImageView) {
        _rightBottomImageView = [[UIImageView alloc] init];
        _rightBottomImageView.image = [UIImage imageNamed:@"右下"];
    }
    return _rightBottomImageView;
}

-(UIButton *)backBtn {
    
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"白色返回"] forState:(UIControlStateNormal)];
    }
    return _backBtn;
}


-(UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
    
}

-(UIButton *)cancelBtn {
    
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.hidden = YES;
        _cancelBtn.layer.cornerRadius = 16;
        _cancelBtn.layer.masksToBounds = YES;
        _cancelBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _cancelBtn.layer.borderWidth = 1.0;
        [_cancelBtn setTitle:@"重拍" forState:(UIControlStateNormal)];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}


-(UIButton *)doneBtn {
    
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _doneBtn.layer.cornerRadius = 16;
        _doneBtn.layer.masksToBounds = YES;
        [_doneBtn setBackgroundColor:[UIColor whiteColor]];
        [_doneBtn setTitle:@"确认" forState:(UIControlStateNormal)];
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_doneBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _doneBtn.hidden = YES;
    }
    return _doneBtn;
}


-(UILabel *)titleLabel1 {
    
    if (!_titleLabel1) {
        _titleLabel1 = [[UILabel alloc] init];
        _titleLabel1.textColor = [UIColor whiteColor];
        _titleLabel1.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel1.textAlignment = NSTextAlignmentCenter;
        _titleLabel1.text = @"拍照采集";
    }
    return _titleLabel1;
}


-(UIImageView *)titleImageV {
    
    if (!_titleImageV) {
        _titleImageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLabel1.frame.origin.x - 40, 80, 42, 42)];
        _titleImageV.image = [UIImage imageNamed:@"2"];
    }
    return _titleImageV;
}

-(UILabel *)titleLabel2 {
    
    if (!_titleLabel2) {
        _titleLabel2 = [[UILabel alloc] init];
        _titleLabel2.textColor = [UIColor whiteColor];
        _titleLabel2.font = [UIFont systemFontOfSize:12];
        _titleLabel2.textAlignment = NSTextAlignmentCenter;
        _titleLabel2.text = @"input invitation code";
    }
    return _titleLabel2;
}

-(UIView *)leftView {
    
    if (!_leftView) {
        _leftView = [[UIView alloc] init];
        _leftView.backgroundColor = [UIColor blackColor];
        _leftView.alpha = .8;
    }
    return _leftView;
}

-(UIView *)rightView {
    
    if (!_rightView) {
        _rightView = [[UIView alloc] init];
        _rightView.backgroundColor = [UIColor blackColor];
        _rightView.alpha = .8;
    }
    return _rightView;
}


-(UIView *)topView {
    
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor blackColor];
        _topView.alpha = .8;
    }
    return _topView;
}


-(UIView *)bottomView {
    
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor blackColor];
        _bottomView.alpha = .8;
    }
    return _bottomView;
}

-(UIButton *)rightBtn {
    
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.hidden = YES;
        [_rightBtn setTitle:@"识别一下" forState:(UIControlStateNormal)];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _rightBtn;
}


@end
