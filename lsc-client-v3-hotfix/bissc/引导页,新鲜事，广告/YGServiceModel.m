//
//  YGServiceModel.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/5.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGServiceModel.h"

@implementation YGServiceModel


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
}


@end
