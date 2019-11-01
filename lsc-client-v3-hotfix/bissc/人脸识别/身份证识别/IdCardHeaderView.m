//
//  IdCardHeaderView.m
//  clientservice
//
//  Created by 龙广发 on 2018/9/7.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "IdCardHeaderView.h"

@implementation IdCardHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.frontImageView];
        [self addSubview:self.backImageView];
        [self addSubview:self.frontLabel];
        [self addSubview:self.backLabel];
        
        [self.frontImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(23*_Scaling);
            make.left.mas_offset(10*_Scaling);
            make.width.mas_offset(__kWidth/2.0 - 14*_Scaling);
            make.height.mas_offset(107*_Scaling);
        }];
        
        [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(23*_Scaling);
            make.right.mas_offset(-10*_Scaling);
            make.width.mas_offset(__kWidth/2.0 - 14*_Scaling);
            make.height.mas_offset(107*_Scaling);
        }];
        
        [self.frontLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.frontImageView.mas_bottom).mas_offset(8*_Scaling);
            make.left.mas_offset(0*_Scaling);
            make.width.mas_offset(__kWidth/2.0);
            make.height.mas_offset(16*_Scaling);
        }];
        
        [self.backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.frontImageView.mas_bottom).mas_offset(8*_Scaling);
            make.right.mas_offset(0*_Scaling);
            make.width.mas_offset(__kWidth/2.0);
            make.height.mas_offset(16*_Scaling);
            
        }];

    }
    return self;
}

-(UIImageView *)frontImageView {
    
    if (!_frontImageView) {
        _frontImageView = [[UIImageView alloc] init];
        _frontImageView.image = [UIImage imageNamed:@"身份证正面"];
    }
    return _frontImageView;
}

-(UIImageView *)backImageView {
    
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"身份证反面"];
    }
    return _backImageView;
}
-(UILabel *)frontLabel {
    
    if (!_frontLabel) {
        _frontLabel = [[UILabel alloc] init];
        _frontLabel.text = @"人头面";
        _frontLabel.textAlignment = NSTextAlignmentCenter;
        _frontLabel.textColor = blackRGBColor;
    }
    return _frontLabel;
}

-(UILabel *)backLabel {
    
    if (!_backLabel) {
        _backLabel = [[UILabel alloc] init];
        _backLabel.text = @"国徽面";
        _backLabel.textAlignment = NSTextAlignmentCenter;
        _backLabel.textColor = blackRGBColor;
    }
    return _backLabel;
}



@end
