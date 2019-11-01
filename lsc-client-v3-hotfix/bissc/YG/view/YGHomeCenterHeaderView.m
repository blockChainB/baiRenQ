//
//  YGHomeCenterHeaderView.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/2.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGHomeCenterHeaderView.h"

@implementation YGHomeCenterHeaderView

-(instancetype) initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = appBgRGBColor;
        [self createUI];
        [self Masonry];
    }
    return self;
}

-(void) createUI {
    
    [self addSubview:self.bgView];
    [self addSubview:self.ygkLabel];
    [self addSubview:self.image1];
    [self addSubview:self.image2];
    [self addSubview:self.image3];
    [self addSubview:self.image4];
    
    [self addSubview:self.label1];
    [self addSubview:self.label2];
    [self addSubview:self.label3];
    [self addSubview:self.label4];
    
    [self addSubview:self.newsView];
    [self.newsView addSubview:self.newsImage];
    [self.newsView addSubview:self.newsLabel];
    [self.newsView addSubview:self.nextBtn];
    
    [self.bgView addSubview:self.titleLB];
}

-(void) Masonry {
    
    [self.ygkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(26*_Scaling);
        make.width.mas_offset(80*_Scaling);
        make.height.mas_offset(15*_Scaling);
        make.left.mas_offset(15*_Scaling);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(1     *_Scaling);
        make.width.mas_offset(__kWidth);
        make.height.mas_offset(51*_Scaling);
        make.left.mas_offset(0*_Scaling);
    }];
    
    [self.titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-7*_Scaling);
        make.width.mas_offset(80*_Scaling);
        make.height.mas_offset(17*_Scaling);
        make.left.mas_offset(15*_Scaling);
    }];
    
    [self.image1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(23*_Scaling);
        make.height.mas_offset(19*_Scaling);
        make.top.mas_offset(168*_Scaling);
        make.left.mas_offset((__kWidth/4.0 - 23*_Scaling)/2.0);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(__kWidth/4.0);
        make.height.mas_offset(19*_Scaling);
        make.top.mas_offset(196*_Scaling);
        make.centerX.mas_equalTo(self.image1);
    }];
    
    [self.image2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(23*_Scaling);
        make.height.mas_offset(19*_Scaling);
        make.top.mas_offset(168*_Scaling);
        make.left.mas_offset((__kWidth/4.0 - 23*_Scaling)/2.0 +__kWidth/4.0);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(__kWidth/4.0);
        make.height.mas_offset(19*_Scaling);
        make.top.mas_offset(196*_Scaling);
        make.centerX.mas_equalTo(self.image2);
    }];
    
    [self.image3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(23*_Scaling);
        make.height.mas_offset(19*_Scaling);
        make.top.mas_offset(168*_Scaling);
        make.left.mas_offset((__kWidth/4.0 - 23*_Scaling)/2.0 +__kWidth/4.*2);
    }];
    
    [self.label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(__kWidth/4.0);
        make.height.mas_offset(19*_Scaling);
        make.top.mas_offset(196*_Scaling);
        make.centerX.mas_equalTo(self.image3);
    }];
    
    [self.image4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(23*_Scaling);
        make.height.mas_offset(19*_Scaling);
        make.top.mas_offset(168*_Scaling);
        make.left.mas_offset((__kWidth/4.0 - 23*_Scaling)/2.0 +__kWidth/4.*3);
    }];
    
    [self.label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(__kWidth/4.0);
        make.height.mas_offset(19*_Scaling);
        make.top.mas_offset(196*_Scaling);
        make.centerX.mas_equalTo(self.image4);
    }];
    
    [self.newsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(__kWidth - 30*_Scaling);
        make.height.mas_offset(25*_Scaling);
        make.top.mas_equalTo(self.label1.mas_bottom).mas_offset(16*_Scaling);
        make.centerX.mas_equalTo(self);
    }];
    
    [self.newsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(13*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.centerY.mas_equalTo(self.newsView);
        make.left.mas_offset(7*_Scaling);
    }];
    
    [self.newsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(__kWidth - 68*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.centerY.mas_equalTo(self.newsView);
        make.left.mas_equalTo(self.newsImage.mas_right).mas_offset(9*_Scaling);
    }];
    
    [self.nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(5*_Scaling);
        make.height.mas_offset(8*_Scaling);
        make.centerY.mas_equalTo(self.newsView);
        make.right.mas_offset(-21*_Scaling);
    }];
    
}

-(UILabel *)titleLB {
    
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.textColor = [UIColor blackColor];
        _titleLB.textAlignment = NSTextAlignmentLeft;
        _titleLB.font = [UIFont boldSystemFontOfSize:18*_Scaling];
    }
    return _titleLB;
}

-(UILabel *)ygkLabel {
    
    if (!_ygkLabel) {
        _ygkLabel = [[UILabel alloc] init];
        _ygkLabel.textColor = [UIColor blackColor];
        _ygkLabel.textAlignment = NSTextAlignmentLeft;
        _ygkLabel.font = [UIFont boldSystemFontOfSize:15*_Scaling];
        _ygkLabel.hidden = YES;
        _ygkLabel.text = @"云谷客推荐";
    }
    return _ygkLabel;
}

-(UIView *)bgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

-(UIImageView *)image1 {
    
    if (!_image1) {
        _image1 = [[UIImageView alloc] init];
        
    }
    return _image1;
}
-(UIImageView *)image2 {
    
    if (!_image2) {
        _image2 = [[UIImageView alloc] init];
        
    }
    return _image2;
}
-(UIImageView *)image3 {
    
    if (!_image3) {
        _image3 = [[UIImageView alloc] init];
        
    }
    return _image3;
}
-(UIImageView *)image4 {
    
    if (!_image4) {
        _image4 = [[UIImageView alloc] init];
        
    }
    return _image4;
}


-(UILabel *)label1 {
    
    if (!_label1) {
        _label1 = [[UILabel alloc] init];
        _label1.textColor = kRGBColor(183, 145, 83, 1.0);
        _label1.textAlignment = NSTextAlignmentCenter;
        _label1.font = [UIFont systemFontOfSize:12*_Scaling];
    }
    return _label1;
}

-(UILabel *)label2 {
    
    if (!_label2) {
        _label2 = [[UILabel alloc] init];
        _label2.textColor = kRGBColor(183, 145, 83, 1.0);
        _label2.textAlignment = NSTextAlignmentCenter;
        _label2.font = [UIFont systemFontOfSize:12*_Scaling];
    }
    return _label2;
}

-(UILabel *)label3 {
    
    if (!_label3) {
        _label3 = [[UILabel alloc] init];
        _label3.textColor = kRGBColor(183, 145, 83, 1.0);
        _label3.textAlignment = NSTextAlignmentCenter;
        _label3.font = [UIFont systemFontOfSize:12*_Scaling];
    }
    return _label3;
}

-(UILabel *)label4 {
    
    if (!_label4) {
        _label4 = [[UILabel alloc] init];
        _label4.textColor = kRGBColor(183, 145, 83, 1.0);
        _label4.textAlignment = NSTextAlignmentCenter;
        _label4.font = [UIFont systemFontOfSize:12*_Scaling];
    }
    return _label4;
}

-(UIView *)newsView {
    
    if (!_newsView) {
        _newsView = [[UIView alloc] init];
        _newsView.backgroundColor = [UIColor whiteColor];
        _newsView.layer.cornerRadius = 5.0*_Scaling;
        _newsView.layer.masksToBounds = YES;
        _newsView.hidden = YES;
    }
    return _newsView;
}

-(UIImageView *)newsImage {
    
    if (!_newsImage) {
        _newsImage = [[UIImageView alloc] init];
    }
    return _newsImage;
}

-(UILabel *)newsLabel {
    
    if (!_newsLabel) {
        _newsLabel = [[UILabel alloc] init];
        _newsLabel.textColor = kRGBColor(0, 0, 0, 1.0);
        _newsLabel.textAlignment = NSTextAlignmentLeft;
        _newsLabel.font = [UIFont systemFontOfSize:12*_Scaling];
    }
    return _newsLabel;
}

-(UIButton *)nextBtn {
    
    if (!_nextBtn) {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _nextBtn;
}
@end
