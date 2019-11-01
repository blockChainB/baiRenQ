//
//  YGDyPostCell.m
//  clientservice
//
//  Created by 龙广发 on 2018/12/19.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGDyPostCell.h"

@implementation YGDyPostCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.addressImg];
    [self.bgView addSubview:self.contentTF];
    [self.contentView addSubview:self.editBtn];

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(17*_Scaling);
        make.width.mas_offset(200*_Scaling);
        make.height.mas_offset(23*_Scaling);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [self.addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0*_Scaling);
        make.width.height.mas_offset(18*_Scaling);
        make.height.mas_offset(25*_Scaling);
        make.centerY.mas_equalTo(self.bgView);
    }];
    
    [self.contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(18*_Scaling);
        make.height.mas_offset(22*_Scaling);
        make.width.mas_offset(170*_Scaling);
        make.centerY.mas_equalTo(self.bgView);
    }];
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(20*_Scaling);
        make.width.mas_offset(40*_Scaling);
        make.centerY.mas_equalTo(self.bgView);
        make.right.mas_offset(-14*_Scaling);
    }];

}

-(UIView *)bgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}

-(UIImageView *)addressImg {
    
    if (!_addressImg) {
        _addressImg = [[UIImageView alloc] init];
        _addressImg.image = [UIImage imageNamed:@"ygk_社群_定位"];
    }
    return _addressImg;
}

-(UITextField *)contentTF {
    
    if (!_contentTF) {
        _contentTF = [[UITextField alloc] init];
        _contentTF.textColor = kRGBColor(46, 46, 46, 1.0);
        _contentTF.font = [UIFont systemFontOfSize:16*_Scaling];
        _contentTF.textAlignment = NSTextAlignmentLeft;
        _contentTF.returnKeyType = UIReturnKeyDone;
        _contentTF.userInteractionEnabled = NO;
    }
    return _contentTF;
}

-(UIButton *)editBtn {
   
    if (!_editBtn) {
        _editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editBtn setTitle:@"编辑" forState:(UIControlStateNormal)];
        [_editBtn setTitleColor:kRGBColor(153, 153, 153, 1.0) forState:(UIControlStateNormal)];
        _editBtn.layer.cornerRadius = 2.5;
        _editBtn.layer.masksToBounds = YES;
        _editBtn.layer.borderColor = kRGBColor(153, 153, 153, 1.0).CGColor;
        _editBtn.layer.borderWidth = 1.0;
        _editBtn.titleLabel.font = [UIFont systemFontOfSize:12*_Scaling];
    }
    return _editBtn;
}







@end

