//
//  YGPYCellFoodView.h
//  bissc
//
//  Created by 龙广发 on 2019/9/29.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGPYCellModel.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^pyCellFoodView)(YGPYCellModel *model);
@interface YGPYCellFoodView : UIView

@property(nonatomic,strong) YGPYCellModel *model;
@property(nonatomic,strong) UIImageView *foodIcon;
@property(nonatomic,strong) UILabel *nameLabel;

@property(nonatomic,strong) UIButton *yyBtn;
@property(nonatomic,copy) pyCellFoodView yyBtnClickBlock;
@property(nonatomic,strong) UILabel *styleLabel;
@property(nonatomic,strong) UILabel *styleLabel1;
@property(nonatomic,strong) UILabel *styleLabel2;
@property(nonatomic,strong) UIImageView *addressIcon;
@property(nonatomic,strong) UILabel *addressLabel;

@property(nonatomic,strong) UIView *lineView;
@end

NS_ASSUME_NONNULL_END
