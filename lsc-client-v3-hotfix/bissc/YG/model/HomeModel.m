//
//  HomeModel.m
//  clientservice
//
//  Created by 龙广发 on 2018/8/21.
//  Copyright © 湖南灵控智能科技有限公司. All rights reserved.
//

#import "HomeModel.h"


@implementation HomeModel

//MJCodingImplementation

-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self ;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.userID = value;
    }
    if ([key isEqualToString:@"carplatenum"]) {
        
        self.carplateNum = value;
    }
    if ([key isEqualToString:@"carPlateNum"]) {
        
        self.carplateNum = value;
    }

    
}



@end






@implementation StoreModel



-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self ;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
    }
}


@end


@implementation GoodsModel



-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self ;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
    }
}


@end


@implementation CouponModel



-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self ;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
    }
}


@end
