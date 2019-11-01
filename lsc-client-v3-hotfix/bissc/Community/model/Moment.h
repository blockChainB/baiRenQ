//
//  Moment.h
//  MomentKit
//
//  Created by LEA on 2017/12/12.
//  Copyright © 2017年 LEA. All rights reserved.
//
//  动态Model
//

#import <Foundation/Foundation.h>

@interface Moment : NSObject

// 群聊 cell

@property (nonatomic,copy) NSString *groupCharIcon;
@property (nonatomic,copy) NSString *groupCharTitle;
@property (nonatomic,copy) NSString *groupCharContent;
@property (nonatomic,assign) BOOL isAdmin;






// 动态cell  评论数

@property (nonatomic,copy) NSString *commentNum;
@property (nonatomic,copy) NSString *highGradeNum;


//评论内容
@property (nonatomic,copy) NSString *content;
//评论时间
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *createTimes;

//评论评分
@property (nonatomic,copy) NSString *grade;
//课程点赞数
@property (nonatomic,copy) NSString *likeNum;

@property (nonatomic,copy) NSString *commentLikeNum;


@property (nonatomic,copy) NSString *headPortrait;

@property (nonatomic,copy) NSString *phone;
//话题id
@property (nonatomic,copy) NSString *topicId;
//发帖人id
@property (nonatomic,copy) NSString *sourceId;
@property (nonatomic,copy) NSString *memberId;


@property (nonatomic,copy) NSString *companyId;


@property (nonatomic,copy) NSString *linkManId;
@property (nonatomic,copy) NSString *linkManImg;
@property (nonatomic,copy) NSString *linkManName;

//是否关注
@property (nonatomic,assign) BOOL isAttention;

//是否点赞
@property (nonatomic,assign) BOOL isLikes;

//
@property (nonatomic,copy) NSString *userId;
//头像
@property (nonatomic,copy) NSString *userImg;
@property (nonatomic,copy) NSString *isVip;

@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *headportrait;


// 正文
@property (nonatomic,copy) NSString *topicContent;
// 发布位置
@property (nonatomic,copy) NSString *location;
// 发布者名字
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *name;
//招聘职位
@property (nonatomic,copy) NSString *position;
//招聘薪水
@property (nonatomic,copy) NSString *salary;
//招聘详情
@property (nonatomic,copy) NSString *details;
//招聘类型
@property (nonatomic,copy) NSString *type;
//fixbug 转发数量
@property (nonatomic,strong) NSString *countZhuanfa;
// 评论数
@property (nonatomic,strong) NSString *countComment;
// 点赞数
@property (nonatomic,strong) NSString *likes;
//是否点赞
@property (nonatomic,assign) BOOL isLike;

@property (nonatomic,assign) BOOL like;

@property (nonatomic,copy) NSArray *comments;

@property (nonatomic,copy) NSString *companyName;

@property (nonatomic,copy) NSString *companyAddress;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *phoneModel;


@property (nonatomic,copy) NSString *memberCompany;

@property (nonatomic,assign) BOOL isSolve;

// 发布者头像路径[本地路径]
@property (nonatomic,copy) NSString *userThumbPath;
// 赞的人[逗号隔开的字符串]
@property (nonatomic,copy) NSString *praiseNameList;
// 单张图片的宽度
@property (nonatomic,assign) CGFloat singleWidth;
// 单张图片的高度
@property (nonatomic,assign) CGFloat singleHeight;
// 图片数量
@property (nonatomic,assign) NSInteger fileCount;
// 发布时间戳
@property (nonatomic,copy) NSString *topicTimes;
// 显示'全文'/'收起'
@property (nonatomic,assign) BOOL isFullText;
// 评论集合
@property (nonatomic,strong) NSArray *commentList;

// 课堂评论集合
@property (nonatomic,strong) NSArray *commentDetails;

// Moment对应cell高度
@property (nonatomic,assign) CGFloat rowHeight;

@property (nonatomic,strong) NSArray *imgList;

// 图片集合
@property (nonatomic,strong) NSArray *topicImages;

// 图片集合
@property (nonatomic,strong) NSArray *imgs;

// 点赞集合
@property (nonatomic,strong) NSArray *likesList;




// ---

@property (nonatomic,copy) NSString *commentUsersImg; //评论人头像
@property (nonatomic,copy) NSString *commentUsers; //评论人名字
@property (nonatomic,copy) NSString *commentTime; //评论时间
@property (nonatomic,copy) NSString *commentContent; //评论内容
@property (nonatomic,copy) NSString *commentUser; //回复的对象


@property (nonatomic,copy) NSString *memberHeadportrait; //评论人头像
@property (nonatomic,copy) NSString *memberName; 


-(instancetype)initWithDic:(NSDictionary *)dic ;

@end
