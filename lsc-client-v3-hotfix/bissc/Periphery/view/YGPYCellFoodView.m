//
//  YGPYCellFoodView.m
//  bissc
//
//  Created by 龙广发 on 2019/9/29.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import "YGPYCellFoodView.h"
@interface YGPYCellFoodView ()

//@property(nonatomic,strong) UILabel *styleLabel1;
//@property(nonatomic,strong) UILabel *styleLabel2;
@end

@implementation YGPYCellFoodView

//@property(nonatomic,strong) YGPYCellModel *model;
//@property(nonatomic,strong) UIImageView *foodIcon;
//@property(nonatomic,strong) UILabel *nameLabel;
//
//@property(nonatomic,strong) UIButton *yyBtn;
//@property(nonatomic,strong) UILabel *styleLabel2;
//@property(nonatomic,strong) UIImageView *addressIcon;
//@property(nonatomic,strong) UILabel *addressLabel;

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.foodIcon];
        [self addSubview:self.nameLabel];
        [self addSubview:self.yyBtn];
        
        [self addSubview:self.styleLabel];
        [self addSubview:self.styleLabel1];
        [self addSubview:self.styleLabel2];
        [self addSubview:self.addressIcon];
        [self addSubview:self.addressLabel];
        [self addSubview:self.lineView];
        [self.foodIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(83*_Scaling);
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(GAP);
            make.height.mas_equalTo(70*_Scaling);
        }];
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(96*_Scaling);
            make.top.mas_equalTo((8+GAP)*_Scaling);
            make.height.mas_offset(14*_Scaling);
            
        }];
        
        [self.yyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(0*_Scaling);
            make.width.mas_equalTo(50*_Scaling);
            make.height.mas_offset(25*_Scaling);
            make.top.mas_equalTo((13+GAP)*_Scaling);
        }];
        
        //        [self addSubview:self.styleLabel];
        //        [self addSubview:self.styleLabel1];
        //        [self addSubview:self.styleLabel2];
        //        [self addSubview:self.addressIcon];
        //        [self addSubview:self.addressLabel];
        
        [self.styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(96*_Scaling);
            make.width.mas_equalTo(50*_Scaling);
            make.height.mas_offset(18*_Scaling);
            make.top.mas_equalTo((29+GAP)*_Scaling);
        }];
        [self.styleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo((96+50+10)*_Scaling);
            make.width.mas_equalTo(50*_Scaling);
            make.height.mas_offset(18*_Scaling);
            make.top.mas_equalTo((29+GAP)*_Scaling);
        }];
        [self.styleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo((96+100+10+10)*_Scaling);
            make.width.mas_equalTo(50*_Scaling);
            make.height.mas_offset(18*_Scaling);
            make.top.mas_equalTo((29+GAP)*_Scaling);
        }];
        //        [self addSubview:self.addressIcon];
        //        [self addSubview:self.addressLabel];
        [self.addressIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(96*_Scaling);
            make.width.mas_equalTo(9*_Scaling);
            make.height.mas_offset(12*_Scaling);
            make.top.mas_equalTo((58+GAP)*_Scaling);
        }];
        [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(118*_Scaling);
            
            make.height.mas_offset(12*_Scaling);
            make.top.mas_equalTo((58+GAP)*_Scaling);
        }];
        //fixbug
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(1);
            make.top.mas_equalTo(95*_Scaling);
        }];
    }
    return self;
}

-(UILabel *)lineView {
    
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
        
    }
    return _lineView;
}


-(UIImageView *)addressIcon{
    if(!_addressIcon){
        _addressIcon = [[UIImageView alloc] init];
        _addressIcon.image = [UIImage imageNamed:@" 定位"];
    }
    return _addressIcon;
}
-(UIImageView *)foodIcon {
    
    if (!_foodIcon) {
        _foodIcon = [[UIImageView alloc] init];
        _foodIcon.image = [UIImage imageNamed:@"烧鹅"];
        //        _foodIcon.backgroundColor = tableViewRGBColor;
        //        _textView.layer.cornerRadius = 18*_Scaling;
        //        _textView.layer.masksToBounds = YES;
        //        _textView.layer.borderColor = tableViewRGBColor.CGColor;
        //        _textView.layer.borderWidth = 1.0;
        //        _textView.contentInset = UIEdgeInsetsMake(5, 10, 0, 0);
        //        _textView.font = [UIFont systemFontOfSize:14*_Scaling];
        //        _textView.returnKeyType = UIReturnKeyDone;
    }
    return _foodIcon;
}
-(UILabel *)nameLabel {
    
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.textColor = blackRGBColor;
        _nameLabel.font = [UIFont systemFontOfSize:14*_Scaling];
    }
    return _nameLabel;
}


-(UIButton *)yyBtn {
    
    if (!_yyBtn) {
        _yyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _yyBtn.layer.cornerRadius= 2.5;
        _yyBtn.layer.masksToBounds = YES;
        [_yyBtn setTitle:@"已预约" forState:UIControlStateSelected];
        [_yyBtn setTitle:@"预约" forState:UIControlStateNormal];
        _yyBtn.titleLabel.font = [UIFont systemFontOfSize:14*_Scaling];
        //        yyBtnClickBlock
        [_yyBtn addTarget:self action:@selector(yyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _yyBtn;
}
-(void)yyBtnClick:(UIButton *)btn{
    !self.yyBtnClickBlock? :self.yyBtnClickBlock(self.model);
}

-(UILabel *)styleLabel {
    
    if (!_styleLabel) {
        _styleLabel = [[UILabel alloc] init];
        _styleLabel.textAlignment = NSTextAlignmentCenter;
        
        _styleLabel.layer.cornerRadius = 2.5*_Scaling;
        _styleLabel.layer.masksToBounds = YES;
        _styleLabel.layer.borderColor = [UIColor colorWithHexString:@"#666666"].CGColor;
        _styleLabel.layer.borderWidth = 1.0;
        
        _styleLabel.font = [UIFont systemFontOfSize:12*_Scaling];
        _styleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _styleLabel.font = [UIFont systemFontOfSize:12*_Scaling];
    }
    return _styleLabel;
}
-(UILabel *)styleLabel1 {
    
    if (!_styleLabel1) {
        _styleLabel1 = [[UILabel alloc] init];
        _styleLabel1.textAlignment = NSTextAlignmentCenter;
        
        _styleLabel1.layer.cornerRadius = 2.5*_Scaling;
        _styleLabel1.layer.masksToBounds = YES;
        _styleLabel1.layer.borderColor = [UIColor colorWithHexString:@"#666666"].CGColor;
        _styleLabel1.layer.borderWidth = 1.0;
        
        _styleLabel1.font = [UIFont systemFontOfSize:12*_Scaling];
        _styleLabel1.textColor = [UIColor colorWithHexString:@"#666666"];
        _styleLabel1.font = [UIFont systemFontOfSize:12*_Scaling];
    }
    return _styleLabel1;
}

-(UILabel *)styleLabel2 {
    
    if (!_styleLabel2) {
        _styleLabel2 = [[UILabel alloc] init];
        _styleLabel2.textAlignment = NSTextAlignmentCenter;
        
        _styleLabel2.layer.cornerRadius = 2.5*_Scaling;
        _styleLabel2.layer.masksToBounds = YES;
        _styleLabel2.layer.borderColor = [UIColor colorWithHexString:@"#666666"].CGColor;
        _styleLabel2.layer.borderWidth = 1.0;
        
        _styleLabel2.font = [UIFont systemFontOfSize:12*_Scaling];
        _styleLabel2.textColor = [UIColor colorWithHexString:@"#666666"];
        _styleLabel2.font = [UIFont systemFontOfSize:12*_Scaling];
    }
    return _styleLabel2;
}


-(UILabel *)addressLabel {
    
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc] init];
        _addressLabel.textAlignment = NSTextAlignmentLeft;
        _addressLabel.textColor =  [UIColor colorWithHexString:@"#CCCCCC"];;
        _addressLabel.font = [UIFont systemFontOfSize:12*_Scaling];
    }
    return _addressLabel;
}



-(void)setModel:(YGPYCellModel *)model{
    _model = model;
    [_foodIcon sd_setImageWithURL:[NSURL URLWithString:model.foodImage] placeholderImage:[UIImage imageNamed:@"烧鹅"] options:nil];
    
    _nameLabel.text = model.foodName;
    _yyBtn.selected = model.isSeltedYY;
    _styleLabel.text = model.foodStyle;
    _styleLabel1.text = model.foodStyle1;
    _styleLabel2.text = model.foodStyle2;
    _addressLabel.text = model.address;
    _lineView.hidden = model.isLast;
    !_yyBtn.selected?[_yyBtn setBackgroundColor:[UIColor colorWithHexString:@"#2E96FF"]]:[_yyBtn setBackgroundColor:[UIColor colorWithHexString:@"#EEEEEE"]];
}
@end
