//
//  YGHomeCell1.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/2.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGHomeCell1.h"

@implementation YGHomeCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        [self Masonry];
        
    }
    return self;
}

-(void) createUI {
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.dateLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.okBtn];

    [self addSubview:self.headerImg];
    
}

-(void) Masonry {
    
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15*_Scaling);
        make.width.mas_offset(76*_Scaling);
        make.height.mas_offset(90*_Scaling);
        make.top.mas_offset(18*_Scaling);
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_offset(16*_Scaling);
        make.width.mas_offset(__kWidth - 106*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.top.mas_equalTo(self.headerImg.mas_top).mas_offset(13*_Scaling);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_offset(16*_Scaling);
        make.width.mas_offset(__kWidth - 106*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(8*_Scaling);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_offset(16*_Scaling);
        make.width.mas_offset(__kWidth - 106*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(7*_Scaling);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_offset(16*_Scaling);
        make.width.mas_offset(__kWidth - 106*_Scaling);
        make.height.mas_offset(10*_Scaling);
        make.bottom.mas_equalTo(self.headerImg.mas_bottom).mas_offset(0*_Scaling);
    }];

    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15*_Scaling);
        make.width.mas_offset(58*_Scaling);
        make.height.mas_offset(20*_Scaling);
        make.bottom.mas_offset(-19*_Scaling);
    }];

}

-(UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16*_Scaling];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

-(UILabel *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:12*_Scaling];
        _contentLabel.textColor = kRGBColor(153, 153, 153, 1.0);
        
    }
    return _contentLabel;
}

-(UILabel *)dateLabel {
    
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = [UIFont systemFontOfSize:12*_Scaling];
        _dateLabel.textColor = kRGBColor(153, 153, 153, 1.0);
    }
    return _dateLabel;
}

-(UILabel *)moneyLabel {
    
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.font = [UIFont systemFontOfSize:12*_Scaling];
        _moneyLabel.textColor = kRGBColor(255, 0, 0, 1.0);
    }
    return _moneyLabel;
}

-(UIButton *)okBtn {
    
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_okBtn setTitle:@"立即报名" forState:(UIControlStateNormal)];
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:11*_Scaling];
        _okBtn.layer.cornerRadius = 5.0*_Scaling;
        _okBtn.layer.masksToBounds = YES;
        _okBtn.layer.borderColor = kRGBColor(0, 0, 0, 1.0).CGColor;
        _okBtn.layer.borderWidth = 0.5*_Scaling;
        [_okBtn setTitleColor:kRGBColor(0, 0, 0, 1.0) forState:(UIControlStateNormal)];

    }
    return _okBtn;
}

-(UIImageView *)headerImg {
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc] init];
        _headerImg.layer.cornerRadius = 3.0*_Scaling;
        _headerImg.layer.masksToBounds = YES;
    }
    return _headerImg;
}



@end



@implementation YGHomeCell2

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        [self Masonry];
        
    }
    return self;
}

-(void) createUI {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.dateLabel];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.okBtn];
    
    [self.contentView addSubview:self.headerImg];
    
}

-(void) Masonry {
    
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15*_Scaling);
        make.width.mas_offset(75*_Scaling);
        make.height.mas_offset(80*_Scaling);
        make.top.mas_offset(18*_Scaling);
    }];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_offset(16*_Scaling);
        make.width.mas_offset(__kWidth - 106*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.top.mas_equalTo(self.headerImg.mas_top).mas_offset(0*_Scaling);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_offset(16*_Scaling);
        make.width.mas_offset(__kWidth - 106*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(15*_Scaling);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_offset(16*_Scaling);
        make.width.mas_offset(__kWidth - 106*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.top.mas_equalTo(self.contentLabel.mas_bottom).mas_offset(6*_Scaling);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_offset(16*_Scaling);
        make.width.mas_offset(__kWidth - 181*_Scaling);
        make.height.mas_offset(10*_Scaling);
        make.bottom.mas_equalTo(self.headerImg.mas_bottom).mas_offset(0*_Scaling);
    }];
    
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15*_Scaling);
        make.width.mas_offset(58*_Scaling);
        make.height.mas_offset(20*_Scaling);
        make.bottom.mas_offset(-19*_Scaling);
    }];
    
}

-(UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16*_Scaling];
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

-(UILabel *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:12*_Scaling];
        _contentLabel.textColor = kRGBColor(153, 153, 153, 1.0);
        
    }
    return _contentLabel;
}

-(UILabel *)dateLabel {
    
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = [UIFont systemFontOfSize:12*_Scaling];
        _dateLabel.textColor = kRGBColor(153, 153, 153, 1.0);
    }
    return _dateLabel;
}

-(UILabel *)moneyLabel {
    
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.textAlignment = NSTextAlignmentLeft;
        _moneyLabel.font = [UIFont systemFontOfSize:12*_Scaling];
        _moneyLabel.textColor = kRGBColor(254, 0, 0, 1.0);
    }
    return _moneyLabel;
}

-(UIButton *)okBtn {
    
    if (!_okBtn) {
        _okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okBtn setTitle:@"立即收听" forState:(UIControlStateNormal)];
        _okBtn.titleLabel.font = [UIFont systemFontOfSize:11*_Scaling];
        _okBtn.layer.cornerRadius = 5.0*_Scaling;
        _okBtn.layer.masksToBounds = YES;
        _okBtn.layer.borderColor = kRGBColor(0, 0, 0, 1.0).CGColor;
        _okBtn.layer.borderWidth = 0.5*_Scaling;
        [_okBtn setTitleColor:kRGBColor(0, 0, 0, 1.0) forState:(UIControlStateNormal)];
        
    }
    return _okBtn;
}

-(UIImageView *)headerImg {
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc] init];
        _headerImg.layer.cornerRadius = 3.0*_Scaling;
        _headerImg.layer.masksToBounds = YES;
    }
    return _headerImg;
}

-(void)setModel:(HomeModel *)model {
    
    _model = model;
    
    
    [_headerImg sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:[UIImage imageNamed:@"ygk_正方形默认"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    _titleLabel.text = model.title;
    _contentLabel.text = model.subheading;
    
    _dateLabel.text = [NSString stringWithFormat:@"共%ld集",[model.classroomDetails count]];
    
    if ([model.isCharge isEqualToString:@"free"]) {
        _moneyLabel.text = @"免费";
    }else if ([model.isCharge isEqualToString:@"charge"]){
        _moneyLabel.text = [NSString stringWithFormat:@"%.2f¥",[model.price floatValue]];
    }else if ([model.isCharge isEqualToString:@"vip"]){
        _moneyLabel.text = @"vip免费";
    }
    
}


@end



@implementation YGHomeCell3

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        [self Masonry];
        
    }
    return self;
}

-(void) createUI {
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.dateLabel1];
    [self addSubview:self.img];
    [self addSubview:self.dateLabel];
    
    
    [self addSubview:self.headerImg];
    
}

-(void) Masonry {
    
    [self.headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15*_Scaling);
        make.width.mas_offset(90*_Scaling);
        make.height.mas_offset(92*_Scaling);
        make.top.mas_offset(18*_Scaling);
    }];
    
    

    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_offset(10*_Scaling);
        make.width.mas_offset(__kWidth - 132*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.top.mas_equalTo(self.headerImg.mas_bottom).mas_offset(-40*_Scaling);
    }];
    
    [self.dateLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_offset(10*_Scaling);
        make.width.mas_offset(50*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.bottom.mas_equalTo(self.headerImg.mas_bottom).mas_offset(0*_Scaling);
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_offset(58*_Scaling);
        make.width.mas_offset(14*_Scaling);
        make.height.mas_offset(14*_Scaling);
        make.bottom.mas_equalTo(self.headerImg.mas_bottom).mas_offset(0*_Scaling);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImg.mas_right).mas_offset(77*_Scaling);
        make.width.mas_offset(__kWidth - 190*_Scaling);
        make.height.mas_offset(12*_Scaling);
        make.bottom.mas_equalTo(self.headerImg.mas_bottom).mas_offset(0*_Scaling);
    }];
    
    
}

-(UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16*_Scaling];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

-(UILabel *)contentLabel {
    
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.font = [UIFont systemFontOfSize:12*_Scaling];
        _contentLabel.textColor = kRGBColor(153, 153, 153, 1.0);
        
    }
    return _contentLabel;
}

-(UILabel *)dateLabel {
    
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textAlignment = NSTextAlignmentLeft;
        _dateLabel.font = [UIFont systemFontOfSize:12*_Scaling];
        _dateLabel.textColor = kRGBColor(183, 145, 83, 1.0);
    }
    return _dateLabel;
}

-(UILabel *)dateLabel1 {
    
    if (!_dateLabel1) {
        _dateLabel1 = [[UILabel alloc] init];
        _dateLabel1.textAlignment = NSTextAlignmentLeft;
        _dateLabel1.font = [UIFont systemFontOfSize:12*_Scaling];
        _dateLabel1.textColor = kRGBColor(183, 145, 83, 1.0);
        _dateLabel1.text = @"转载自：";
    }
    return _dateLabel1;
}

-(UIImageView *)img {
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.image = [UIImage imageNamed:@"ygk_资讯图标"];
    }
    return _img;
}

-(UIImageView *)headerImg {
    if (!_headerImg) {
        _headerImg = [[UIImageView alloc] init];
        _headerImg.layer.cornerRadius = 3.0*_Scaling;
        _headerImg.layer.masksToBounds = YES;
    }
    return _headerImg;
}

-(void)setModel:(HomeModel *)model {
    _model = model;
    
    
    [_headerImg sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:@"ygk_正方形默认"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    _titleLabel.text = model.title;
    
    CGFloat height = [UserInfo getLabelHeightWithText:_titleLabel.text width:__kWidth - 132*_Scaling font:16*_Scaling];
    if (height > 40*_Scaling) {
        height = 40*_Scaling;
    }
    _titleLabel.frame =  CGRectMake(116*_Scaling, 21*_Scaling, __kWidth - 132*_Scaling, height);
    _contentLabel.text = model.subHead;
    _dateLabel.text = [NSString stringWithFormat:@"%@ | %@",model.reprint,[UserInfo timeStampString:model.createTime type:@"YYYY-MM-dd"]];
    
}



@end
