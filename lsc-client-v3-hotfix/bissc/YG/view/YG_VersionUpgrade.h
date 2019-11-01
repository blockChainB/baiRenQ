//
//  YG_VersionUpgrade.h
//  clientservice
//
//  Created by 龙广发 on 2019/3/16.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YG_VersionUpgrade : UIView

@property(nonatomic,strong) UIView *bgView;

@property(nonatomic,strong) UIImageView *bgImgView;

@property(nonatomic,strong) UILabel *versionLabel;
@property(nonatomic,strong) UILabel *contentLabel;

@property(nonatomic,strong) UIButton *cancelBtn;
@property(nonatomic,strong) UIButton *okBtn;

@end

NS_ASSUME_NONNULL_END
