//
//  Comment.h
//  MomentKit
//
//  Created by LEA on 2017/12/12.
//  Copyright © 2017年 LEA. All rights reserved.
//
//  评论Model
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject
@property (nonatomic,copy) NSString *headerImage;

@property (nonatomic,copy) NSString *commentId;

// 正文
@property (nonatomic,copy) NSString *commentContent;

@property (nonatomic,copy) NSString *content;

// 发布者名字
@property (nonatomic,copy) NSString *commentUser;

@property (nonatomic,copy) NSString *memberName;
@property (nonatomic,copy) NSString *memberNames;

@property (nonatomic,copy) NSString *memberId;
@property (nonatomic,copy) NSString *memberIds;

@property (nonatomic,copy) NSString *userId;
@property (nonatomic,copy) NSString *usersId;

@property (nonatomic,copy) NSString *commentUsers;
@property (nonatomic,copy) NSString *userName;

//课堂
@property (nonatomic,copy) NSString *memberInfoName;
@property (nonatomic,copy) NSString *memberInfoId;

@property (nonatomic,copy) NSString *replyMemberId;
@property (nonatomic,copy) NSString *replyMemberName;

// 发布时间戳
@property (nonatomic,assign) long long time;
// 关联动态的PK
@property (nonatomic,assign) int pk;

-(instancetype)initWithDic:(NSDictionary *)dic ;

@end
