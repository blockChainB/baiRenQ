//
//  YG_VersionUpgrade.m
//  clientservice
//
//  Created by 龙广发 on 2019/3/16.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import "YG_VersionUpgrade.h"

@implementation YG_VersionUpgrade

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.bgImgView.image = [UIImage imageNamed:@"YG_升级"];
        self.bgImgView.userInteractionEnabled = YES;
        [self addSubview:self.bgImgView];
        
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancelBtn setBackgroundImage:[UIImage imageNamed:@"YG_升级删除"] forState:UIControlStateNormal];
        [self.bgImgView addSubview:self.cancelBtn];

        self.okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bgImgView addSubview:self.okBtn];

        self.versionLabel = [[UILabel alloc] init];
        self.versionLabel.textColor = kRGBColor(51, 51, 51, 1.0);
        self.versionLabel.font = [UIFont boldSystemFontOfSize:18*_Scaling];
        self.versionLabel.textAlignment = NSTextAlignmentLeft;
        [self.bgImgView addSubview:self.versionLabel];
        
        [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_offset(35*_Scaling);
            make.right.mas_offset(-5*_Scaling);
            make.top.mas_offset(29*_Scaling);
        }];
        
        [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(310*_Scaling);
            make.height.mas_offset(40*_Scaling);
            make.bottom.mas_offset(0*_Scaling);
            make.centerX.mas_equalTo(self.bgImgView);
        }];
        
        [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(200*_Scaling);
            make.height.mas_offset(18*_Scaling);
            make.left.mas_offset(68*_Scaling);
            make.top.mas_offset(133*_Scaling);

        }];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.textColor = kRGBColor(51, 51, 51, 1.0);
        self.contentLabel.font = [UIFont systemFontOfSize:15*_Scaling];
        self.contentLabel.textAlignment = NSTextAlignmentLeft;
        self.contentLabel.numberOfLines = 0;
        [self.bgImgView addSubview:self.contentLabel];
        
    }
    return self;
}

@end


