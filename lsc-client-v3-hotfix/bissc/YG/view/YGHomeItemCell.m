//
//  YGHomeItemCell.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/15.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGHomeItemCell.h"

@implementation YGHomeItemCell

-(instancetype) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        
        [self createUI];
        [self Masonry];
        
        
    }
    return self;
    
}

-(void) createUI {
    
    [self addSubview:self.icoImageView];
    [self addSubview:self.nameLabel];
    
}

-(void) Masonry {
    
    [self.icoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.height.mas_offset(20*_Scaling);
        make.top.mas_offset(18*_Scaling);
        make.left.mas_offset((__kWidth/4.0 - 20*_Scaling)/2.0);
        
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.icoImageView.mas_bottom).mas_offset(10*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.width.mas_offset(__kWidth/4.0);
        make.centerX.mas_equalTo(self.icoImageView);
    }];
    
}

-(UIImageView *)icoImageView {
    
    if (!_icoImageView) {
        _icoImageView = [[UIImageView alloc] init];
    }
    return _icoImageView;
}

-(UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:12*_Scaling];
        _nameLabel.textColor = goldRGBColor;
        
    }
    return _nameLabel;
}



@end
