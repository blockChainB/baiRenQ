//
//  YGHomeygkCell.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/2.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGHomeygkCell.h"

@implementation YGHomeygkCell

-(instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 3.0*_Scaling;
        self.layer.masksToBounds = YES;
        [self createUI];
        [self Masonry];
        
        
    }
    return self;
    
}

-(void) createUI {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.icoImageView];
    [self addSubview:self.vipImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.okBtn];
    
}

-(void) Masonry {
    
    [self.icoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_offset(38*_Scaling);
        make.height.mas_offset(38*_Scaling);
        make.top.mas_offset(9*_Scaling);
        make.centerX.mas_equalTo(self);
        
    }];
    
    [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_offset(15*_Scaling);
        make.height.mas_offset(15*_Scaling);
        make.top.mas_equalTo(self.icoImageView.mas_top).mas_offset(24*_Scaling);
        make.left.mas_equalTo(self.icoImageView.mas_left).mas_offset(24*_Scaling);

    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_offset(112*_Scaling);
        make.height.mas_offset(14*_Scaling);
        make.top.mas_equalTo(self.icoImageView.mas_bottom).mas_offset(7*_Scaling);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_offset(112*_Scaling);
        make.height.mas_offset(11*_Scaling);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(4*_Scaling);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_offset(58*_Scaling);
        make.height.mas_offset(20*_Scaling);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(13*_Scaling);
    }];
    
}

-(UIImageView *)icoImageView {
    
    if (!_icoImageView) {
        _icoImageView = [[UIImageView alloc] init];
        _icoImageView.layer.cornerRadius = 19*_Scaling;
        _icoImageView.layer.masksToBounds = YES;
    }
    return _icoImageView;
}

-(UIImageView *)vipImageView {
    
    if (!_vipImageView) {
        _vipImageView = [[UIImageView alloc] init];
        _vipImageView.layer.cornerRadius = 15/2.0*_Scaling;
        _vipImageView.layer.masksToBounds = YES;
        _vipImageView.image = [UIImage imageNamed:@"ygk_小v"];
    }
    return _vipImageView;
}

-(UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14*_Scaling];
        _nameLabel.textColor = kRGBColor(0, 0, 0, 1.0);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
    
}

-(UILabel *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:11*_Scaling];
        _contentLabel.textColor = kRGBColor(153, 153, 153, 1.0);
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

-(UIButton *)okBtn {
    
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:11*_Scaling];
        [_okBtn setBackgroundColor:[UIColor whiteColor]];
        _okBtn.layer.cornerRadius = 5.0*_Scaling;
        _okBtn.layer.masksToBounds = YES;
        _okBtn.layer.borderColor = kRGBColor(0, 0, 0, 1.0).CGColor;
        _okBtn.layer.borderWidth = 0.5*_Scaling;
//        [_okBtn setTitle:@"+ 关注" forState:(UIControlStateNormal)];
        [_okBtn setTitleColor:kRGBColor(0, 0, 0, 1.0) forState:(UIControlStateNormal)];
        [_okBtn addTarget:self action:@selector(didfollowMoment:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _okBtn;
}

-(void)setModel:(HomeModel *)model {
    _model = model;
    
    [_icoImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"ygk_默认头像"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    
    _nameLabel.text = [NSString stringWithFormat:@"%@",model.name];
    
    if (model.isAttention == YES) {
        [_okBtn setTitle:@"已关注" forState:(UIControlStateNormal)];
    }else {
        [_okBtn setTitle:@"+ 关注" forState:(UIControlStateNormal)];
    }
    
    if ([model.isVip isEqualToString:@"1"]) {
        _vipImageView.hidden = NO;
    }else {
        _vipImageView.hidden = YES;
    }
}


// 关注
- (void)didfollowMoment:(UIButton *)sender
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(ygkFollowMoment:)]) {
            [self.delegate ygkFollowMoment:self];
        }
    });
}

@end






@implementation YGNewUsersCell

-(instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.layer.cornerRadius = 3.0*_Scaling;
        self.layer.masksToBounds = YES;
        [self createUI];
        [self Masonry];
        
        
    }
    return self;
    
}

-(void) createUI {
    
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.icoImageView];
    [self addSubview:self.vipImageView];

    [self addSubview:self.nameLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.okBtn];
    
}

-(void) Masonry {
    
    [self.icoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_offset(38*_Scaling);
        make.height.mas_offset(38*_Scaling);
        make.top.mas_offset(9*_Scaling);
        make.centerX.mas_equalTo(self);
        
    }];
    
    
    [self.vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_offset(15*_Scaling);
        make.height.mas_offset(15*_Scaling);
        make.top.mas_equalTo(self.icoImageView.mas_top).mas_offset(24*_Scaling);
        make.left.mas_equalTo(self.icoImageView.mas_left).mas_offset(24*_Scaling);
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_offset(112*_Scaling);
        make.height.mas_offset(14*_Scaling);
        make.top.mas_equalTo(self.icoImageView.mas_bottom).mas_offset(7*_Scaling);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_offset(112*_Scaling);
        make.height.mas_offset(11*_Scaling);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(4*_Scaling);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.mas_offset(58*_Scaling);
        make.height.mas_offset(20*_Scaling);
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(13*_Scaling);
    }];
    
}

-(UIImageView *)icoImageView {
    
    if (!_icoImageView) {
        _icoImageView = [[UIImageView alloc] init];
        _icoImageView.layer.cornerRadius = 19*_Scaling;
        _icoImageView.layer.masksToBounds = YES;
    }
    return _icoImageView;
}

-(UIImageView *)vipImageView {
    
    if (!_vipImageView) {
        _vipImageView = [[UIImageView alloc] init];
        _vipImageView.layer.cornerRadius = 15/2.0*_Scaling;
        _vipImageView.layer.masksToBounds = YES;
        _vipImageView.image = [UIImage imageNamed:@"ygk_小v"];
    }
    return _vipImageView;
}

-(UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14*_Scaling];
        _nameLabel.textColor = kRGBColor(0, 0, 0, 1.0);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
    
}

-(UILabel *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:11*_Scaling];
        _contentLabel.textColor = kRGBColor(153, 153, 153, 1.0);
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

-(UIButton *)okBtn {
    
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:11*_Scaling];
        [_okBtn setBackgroundColor:[UIColor whiteColor]];
        _okBtn.layer.cornerRadius = 5.0*_Scaling;
        _okBtn.layer.masksToBounds = YES;
        _okBtn.layer.borderColor = kRGBColor(0, 0, 0, 1.0).CGColor;
        _okBtn.layer.borderWidth = 0.5*_Scaling;
        //        [_okBtn setTitle:@"+ 关注" forState:(UIControlStateNormal)];
        [_okBtn setTitleColor:kRGBColor(0, 0, 0, 1.0) forState:(UIControlStateNormal)];
        [_okBtn addTarget:self action:@selector(didfollowMoment:) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _okBtn;
}

-(void)setModel:(HomeModel *)model {
    
    _model = model;
    
    [_icoImageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"ygk_默认头像"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    _nameLabel.text = [NSString stringWithFormat:@"%@",model.name];
//    _contentLabel.text = model.position;
    
    if (model.isAttention == YES) {
        [_okBtn setTitle:@"已关注" forState:(UIControlStateNormal)];
    }else {
        [_okBtn setTitle:@"+ 关注" forState:(UIControlStateNormal)];
    }
    
    if ([model.isVip isEqualToString:@"1"]) {
        _vipImageView.hidden = NO;
    }else {
        _vipImageView.hidden = YES;
    }
}


// 关注
- (void)didfollowMoment:(UIButton *)sender
{
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC));
    dispatch_after(when, dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(ygkNewUsersFollowMoment:)]) {
            [self.delegate ygkNewUsersFollowMoment:self];
        }
    });
}

@end
