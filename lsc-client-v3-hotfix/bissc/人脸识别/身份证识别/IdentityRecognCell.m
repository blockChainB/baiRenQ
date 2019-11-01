//
//  IdentityRecognCell.m
//  clientservice
//
//  Created by 龙广发 on 2018/9/20.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "IdentityRecognCell.h"

@implementation IdentityRecognCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
  
        self.contentView.backgroundColor = tableViewRGBColor;
        
        [self.contentView addSubview:self.bgView];
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titlLabel];
        [self.bgView addSubview:self.status];

        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_offset(15*_Scaling);
            make.top.mas_offset(20*_Scaling);
            make.width.mas_offset(__kWidth - 30*_Scaling);
            make.height.mas_offset(158*_Scaling);
            make.centerX.mas_equalTo(self.contentView);
        }];
  
        [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_offset(-12*_Scaling);
            make.top.mas_offset(20*_Scaling);
            make.width.mas_offset(100*_Scaling);
            make.height.mas_offset(16*_Scaling);
        }];

    }
    return self;
}

-(UIView *)bgView {
    
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 8.0*_Scaling;
    }
    return _bgView;
}

-(UIImageView *)imgView {
    
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

-(UILabel *)titlLabel {
    
    if (!_titlLabel) {
        _titlLabel = [[UILabel alloc] init];
        _titlLabel.font = [UIFont systemFontOfSize:16*_Scaling];
        _titlLabel.textColor = blackRGBColor;
        _titlLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titlLabel;
}

-(UILabel *)status {
    
    if (!_status) {
        _status = [[UILabel alloc] init];
        _status.font = [UIFont systemFontOfSize:16*_Scaling];
        _status.textAlignment = NSTextAlignmentRight;
    }
    return _status;
}

@end
