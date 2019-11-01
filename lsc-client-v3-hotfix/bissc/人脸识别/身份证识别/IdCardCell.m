//
//  IdCardCell.m
//  clientservice
//
//  Created by 龙广发 on 2018/9/7.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "IdCardCell.h"

@implementation IdCardCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightLabel];
        
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
            make.left.mas_offset(15*_Scaling);
            make.width.mas_offset(160*_Scaling);
            make.height.mas_offset(16*_Scaling);
            make.centerY.mas_equalTo(self.contentView);
        }];
        
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_offset(-15*_Scaling);
            make.width.mas_offset(400*_Scaling);
            make.height.mas_offset(16*_Scaling);
            make.centerY.mas_equalTo(self.contentView);
        }];
    }
    return self;
}

-(UILabel *)leftLabel {
    
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.font = [UIFont systemFontOfSize:16*_Scaling];
        _leftLabel.textColor = blackRGBColor;
        _leftLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _leftLabel;
}

-(UILabel *)rightLabel {
    
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = [UIFont systemFontOfSize:16*_Scaling];
        _rightLabel.textColor = grayRGBColor;
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}



@end
