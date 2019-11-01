//
//  YGHomeygkCell.h
//  clientservice
//
//  Created by 龙广发 on 2018/11/2.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

@protocol ygkCellDelegate;

@interface YGHomeygkCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *icoImageView;
@property(nonatomic,strong) UIImageView *vipImageView;

@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) UIButton *okBtn;

@property(nonatomic,strong) HomeModel *model;

@property (nonatomic, assign) id<ygkCellDelegate> delegate;

@end


@protocol ygkCellDelegate <NSObject>

@optional

// 关注
- (void)ygkFollowMoment:(YGHomeygkCell *)cell;

@end







@protocol YGNewUsersDelegate;

@interface YGNewUsersCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *icoImageView;
@property(nonatomic,strong) UIImageView *vipImageView;

@property(nonatomic,strong) UILabel *nameLabel;
@property(nonatomic,strong) UILabel *contentLabel;
@property(nonatomic,strong) UIButton *okBtn;

@property(nonatomic,strong) HomeModel *model;

@property (nonatomic, assign) id<YGNewUsersDelegate> delegate;

@end


@protocol YGNewUsersDelegate <NSObject>

@optional

// 关注
- (void)ygkNewUsersFollowMoment:(YGNewUsersCell *)cell;

@end
