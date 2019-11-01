//
//  MomentCell.h
//  MomentKit
//
//  Created by LEA on 2017/12/14.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Moment.h"
#import "Comment.h"
#import "MMOperateMenuView.h"
#import "MMImageListView.h"

//#### 动态

@protocol MomentCellDelegate;
@interface MomentCell : UITableViewCell <MLLinkLabelDelegate>

@property (nonatomic, strong) UIView *bgView;

// 关注
@property (nonatomic, strong) UIButton *followBtn;

// 地址
@property (nonatomic, strong) UILabel *addressLabel;

@property(nonatomic, strong)UIButton *startBtn;
// 头像
@property (nonatomic, strong) UIImageView *headImageView;

// vip头像
@property (nonatomic, strong) UIImageView *vipHeadImageView;

// 名称
@property (nonatomic, strong) UILabel *nameLab;
// 时间
@property (nonatomic, strong) UILabel *timeLab;
// 位置
@property (nonatomic, strong) UILabel *locationLab;
// 删除
@property (nonatomic, strong) UIButton *deleteBtn;
// 点赞数
@property (nonatomic, strong) UIButton *linkBtn;
// 评论数
@property (nonatomic, strong) UIButton *commentBtn;
// 私信
@property (nonatomic, strong) UIButton *imBtn;

// 全文
@property (nonatomic, strong) UIButton *showAllBtn;
// 内容
@property (nonatomic, strong) MLLinkLabel *linkLabel;
// 图片
@property (nonatomic, strong) MMImageListView *imageListView;
// 赞和评论视图
@property (nonatomic, strong) UIView *commentView;
// 赞和评论视图背景
@property (nonatomic, strong) UIImageView *bgImageView;
// 操作视图
@property (nonatomic, strong) MMOperateMenuView *menuView;

// 是否显示评论
@property (nonatomic, strong) NSString *isComment; //2 bu显示

// 背景大小
@property (nonatomic, strong) NSString *isBgFram; // 背景大小

// 分界线
@property (nonatomic, strong) UIView *lineView; // 分界线

@property (nonatomic, strong) UILabel *phoneNumberLabel; // 照片数

// 动态
@property (nonatomic, strong) Moment *moment;
// 代理
@property (nonatomic, assign) id<MomentCellDelegate> delegate;


@end

@protocol MomentCellDelegate <NSObject>

@optional

// 点击用户头像
- (void)didClickProfile:(MomentCell *)cell;
// 删除
- (void)didDeleteMoment:(MomentCell *)cell;
// 点赞
- (void)didLikeMoment:(MomentCell *)cell;
// 关注
- (void)didfollowMoment:(MomentCell *)cell;
// 评论
- (void)didAddComment:(MomentCell *)cell;
// 私信
- (void)didImMoment:(MomentCell *)cell;

// 查看全文/收起
- (void)didSelectFullText:(MomentCell *)cell;
// 选择评论
- (void)didSelectComment:(Comment *)comment;
// 点击高亮文字
- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText;

//长按高亮内容
//- (void)didLongPressLink:(MLLink*)link linkText:(NSString*)linkText linkLabel:(MLLinkLabel*)linkLabel;

//长按内容2
- (void)didLabelLongPresslinkText:(NSString*)linkText linkLabel:(MLLinkLabel*)linkLabel;

// 点击评论
- (void)didClickText:(Comment *)comment;

// 解决
- (void)didstartComment:(MomentCell *)cell;


- (void)didSelectComment:(Comment *)comment MomentCell:(MomentCell *)cell;

@end


//#### 评论
@interface CommentLabel : UIView <MLLinkLabelDelegate>

// 内容Label
@property (nonatomic,strong) MLLinkLabel *linkLabel;
// 评论
@property (nonatomic,strong) Comment *comment;
// 点击评论高亮内容
@property (nonatomic, copy) void (^didClickLinkText)(MLLink *link , NSString *linkText);
// 点击评论
@property (nonatomic, copy) void (^didClickText)(Comment *comment);

// 长按内容
@property (nonatomic, copy) void (^didLongPressLink)(MLLink *link , NSString *linkText ,MLLinkLabel *linkLabel);

@end


