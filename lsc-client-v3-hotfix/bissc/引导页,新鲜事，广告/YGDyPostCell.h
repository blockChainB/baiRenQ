//
//  YGDyPostCell.h
//  clientservice
//
//  Created by 龙广发 on 2018/12/19.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGServiceModel.h"
@interface YGDyPostCell : UITableViewCell

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *addressImg;
@property (nonatomic, strong) UITextField *contentTF;
@property (nonatomic, strong) UIButton *editBtn;

@property (nonatomic, strong) YGServiceModel *model;

@end

@interface YGDyPostCell2 : UITableViewCell

@property (nonatomic, strong) UIImageView *img;
@property (nonatomic, strong) UILabel *titleLB;
@property (nonatomic, strong) UILabel *contentLB;

@property (nonatomic, strong) UIButton *nextBtn;


@end
