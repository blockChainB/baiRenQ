//
//  YGMapAddressCell.m
//  clientservice
//
//  Created by 龙广发 on 2019/1/7.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import "YGMapAddressCell.h"

@implementation YGMapAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.addressLable];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20*_Scaling);
        make.width.mas_offset(__kWidth - 40*_Scaling);
        make.height.mas_offset(30*_Scaling);
        make.top.mas_offset(0);
    }];
    
    [self.addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20*_Scaling);
        make.width.mas_offset(__kWidth - 40*_Scaling);
        make.height.mas_offset(20*_Scaling);
        make.top.mas_offset(30*_Scaling);
    }];

}

-(UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = kRGBColor(46, 46, 46, 1.0);
        _nameLabel.font = [UIFont systemFontOfSize:17*_Scaling];
    }
    return _nameLabel;
}
-(UILabel *)addressLable {
    
    if (!_addressLable) {
        _addressLable = [[UILabel alloc] init];
        _addressLable.textAlignment = NSTextAlignmentLeft;
        _addressLable.textColor = kRGBColor(153, 153, 153, 1.0);
        _addressLable.font = [UIFont systemFontOfSize:14*_Scaling];
    }
    return _addressLable;
}


@end
