//
//  YGServiceModel.h
//  clientservice
//
//  Created by 龙广发 on 2018/11/5.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGServiceModel : NSObject

@property(nonatomic,copy)NSString *companyName;

@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *sort;
@property(nonatomic,copy)NSString *describe;
@property(nonatomic,copy)NSString *phone;
@property(nonatomic,copy)NSString *manageScope;
@property(nonatomic,copy)NSString *enterpriseLogo;
@property(nonatomic,copy)NSString *className;
@property(nonatomic,copy)NSString *creater;

@property(nonatomic,copy)NSString *details;
@property(nonatomic,copy)NSString *detail;

@property(nonatomic,copy)NSString *addressStr;

@property(nonatomic,copy)NSString *linkManId;

@property(nonatomic,copy)NSString *nature;

@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *userID;
@property(nonatomic,copy)NSString *typeId;
@property(nonatomic,copy)NSString *employees;
@property(nonatomic,copy)NSString *typeParam;
@property(nonatomic,copy)NSString *actionUrl;

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *num;

@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *status;


@property(nonatomic,copy)NSString *meetingRoomName;
@property(nonatomic,copy)NSString *meetingRoomNum;
@property(nonatomic,copy)NSString *meetingRoomScale;
@property(nonatomic,copy)NSString *meetingAddress;
@property(nonatomic,copy)NSString *managedept;
@property(nonatomic,copy)NSString *price;


@property(nonatomic,copy)NSString *airlinesDescribes;
@property(nonatomic,copy)NSString *airlinesName;
@property(nonatomic,copy)NSString *airlinesPhone;
@property(nonatomic,copy)NSString *headPortrait;
@property(nonatomic,copy)NSString *describes;
@property(nonatomic,copy)NSString *advantage;

@property (nonatomic,assign) CGFloat rowHeight;


@property(nonatomic,strong)NSDictionary *dataDic;
-(instancetype)initWithDic:(NSDictionary *)dic ;

@end
