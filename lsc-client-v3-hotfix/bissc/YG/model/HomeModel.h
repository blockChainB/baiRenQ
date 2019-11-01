//
//  HomeModel.h
//  clientservice
//
//  Created by 龙广发 on 2018/8/21.
//  Copyright © 湖南灵控智能科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject


@property(nonatomic,copy)NSString *isSeleted;
@property(nonatomic,copy)NSString *imgName;

@property(nonatomic,copy)NSString *icon;
@property(nonatomic,copy)NSString *carPatenum;
@property(nonatomic,copy)NSString *addr;
@property(nonatomic,copy)NSString *busNumber;
@property(nonatomic,copy)NSString *totalMoney;

@property(nonatomic,copy)NSString *stopTime;

@property(nonatomic,copy)NSString *payable;//支付金额

@property(nonatomic,copy)NSString *state;//支付状态

@property(nonatomic,copy)NSString *carplateNum;

@property(nonatomic,copy)NSString *comeTimes;
@property(nonatomic,copy)NSString *comeTime;

@property(nonatomic,copy)NSString *outTimes;

@property(nonatomic,copy)NSString *payTimes;//支付时间

@property(nonatomic,copy)NSString *memberId;
@property(nonatomic,copy)NSArray *list;
//对应cell高度
@property (nonatomic,assign) CGFloat rowHeight;

@property(nonatomic,copy)NSString *bigTitle;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subheading;
@property(nonatomic,copy)NSString *discountMoney;
@property(nonatomic,copy)NSString *detailsId;
@property(nonatomic,copy)NSString *couponId;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *describe;
@property(nonatomic,copy)NSString *subHead;
@property(nonatomic,copy)NSString *viceTitle;
@property(nonatomic,copy)NSString *isApply;
@property(nonatomic,copy)NSString *isVip;
@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *introduce;

@property(nonatomic,copy)NSString *isCharge;

@property(nonatomic,copy)NSString *createTime;
@property(nonatomic,copy)NSString *createTimes;
@property(nonatomic,copy)NSString *position;
@property(nonatomic,copy)NSString *userID;
@property(nonatomic,copy)NSString *visitorId;
@property(nonatomic,copy)NSString *reprint;

@property(nonatomic,copy)NSString *remark;

@property(nonatomic,copy)NSArray *classroomDetails;

@property(nonatomic,copy)NSString *instructions;

@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *code;

@property(nonatomic,copy)NSString *img;
@property(nonatomic,copy)NSString *className;
@property(nonatomic,copy)NSString *startTime;
@property(nonatomic,copy)NSString *endTime;
@property(nonatomic,copy)NSString *addressDetails;
@property(nonatomic,copy)NSString *shopName;
@property(nonatomic,copy)NSString *shopImg;
@property(nonatomic,copy)NSString *imgUrl;

@property(nonatomic,copy)NSString *actionUrl;

@property(nonatomic,assign)BOOL isGet;//是否领取
@property(nonatomic,assign) BOOL isAttention;//是否关注

@property(nonatomic,copy)NSString *chosenArray;

@property(nonatomic,copy)NSString *pId;
@property(nonatomic,copy)NSString *siteId;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *typeId;


@property(nonatomic,copy)NSString *userName;

@property(nonatomic,copy)NSString *headportrait;

@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *companyName;
@property(nonatomic,copy)NSString *applicationTime;
@property(nonatomic,copy)NSString *isAudit;

@property(nonatomic,copy)NSString *headPortrait;
@property(nonatomic,copy)NSString *typeParam;

@property(nonatomic,copy)NSDictionary *templateEnterpriseService;
@property(nonatomic,copy)NSString *status;

@property(nonatomic,strong)NSDictionary *dataDic;

@property(nonatomic,strong)NSArray *dataArr;

-(instancetype)initWithDic:(NSDictionary *)dic ;

@end

//商铺列表
@interface StoreModel : NSObject

@property(nonatomic,strong)NSString *shopLogo;
@property(nonatomic,strong)NSString *storeUrl;
@property(nonatomic,strong)NSString *shopName;
@property(nonatomic,strong)NSString *startTime;
@property(nonatomic,strong)NSString *shopId;
@property(nonatomic,strong)NSString *avgMoney;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSString *shopAddress;
@property(nonatomic,strong)NSString *classifyName;


-(instancetype)initWithDic:(NSDictionary *)dic ;

@end


// 商品详情
@interface GoodsModel : NSObject

@property(nonatomic,strong)NSString *goodsName;
@property(nonatomic,strong)NSString *goodsDesc;

@property(nonatomic,strong)NSString *storeName;
@property(nonatomic,strong)NSString *currentPrice;
@property(nonatomic,strong)NSString *originalPrice;
@property(nonatomic,strong)NSString *saleCount;
@property(nonatomic,strong)NSString *goodsImg;
@property(nonatomic,strong)NSString *storeLogo;
@property(nonatomic,strong)NSString *countComment;
@property(nonatomic,strong)NSString *goodsNum;
@property(nonatomic,strong)NSString *storeId;

@property(nonatomic,strong)NSString *ruleTitle;//优惠券
@property(nonatomic,strong)NSString *couponId;//优惠券id

-(instancetype)initWithDic:(NSDictionary *)dic ;


@end

// 商品详情
@interface CouponModel : NSObject


@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *discountMoney;
@property(nonatomic,strong)NSString *endTime;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,strong)NSString *detailsId;

@property(nonatomic,strong)NSString *couponSign;

@property(nonatomic,strong)NSString *ruleTitle;//优惠券
@property(nonatomic,strong)NSString *couponId;//优惠券id
@property(nonatomic,assign)BOOL isGet;//是否领取
@property(nonatomic,assign)BOOL canUse;//是否可用

-(instancetype)initWithDic:(NSDictionary *)dic ;


@end
