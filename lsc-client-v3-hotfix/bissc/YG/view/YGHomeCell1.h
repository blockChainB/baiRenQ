//
//  YGHomeCell1.h
//  clientservice
//
//  Created by 龙广发 on 2018/11/2.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
@interface YGHomeCell1 : UITableViewCell

@property(nonatomic,strong) UILabel *titleLabel; //
@property(nonatomic,strong) UILabel *contentLabel; //
@property(nonatomic,strong) UILabel *dateLabel; //
@property(nonatomic,strong) UILabel *moneyLabel; //

@property(nonatomic,strong) UIImageView *headerImg; //

@property(nonatomic,strong) UIButton *okBtn; //

@end



@interface YGHomeCell2 : UITableViewCell

@property(nonatomic,strong) UILabel *titleLabel; //
@property(nonatomic,strong) UILabel *contentLabel; //
@property(nonatomic,strong) UILabel *dateLabel; //
@property(nonatomic,strong) UILabel *moneyLabel; //

@property(nonatomic,strong) UIImageView *headerImg; //

@property(nonatomic,strong) UIButton *okBtn; //
@property(nonatomic,strong) HomeModel *model; //

@end


@interface YGHomeCell3 : UITableViewCell

@property(nonatomic,strong) UILabel *titleLabel; //
@property(nonatomic,strong) UILabel *contentLabel; //
@property(nonatomic,strong) UILabel *dateLabel; //

@property(nonatomic,strong) UIImageView *headerImg; //

@property(nonatomic,strong) UILabel *dateLabel1; //
@property(nonatomic,strong) UIImageView *img; //


@property(nonatomic,strong) HomeModel *model; //

@end

