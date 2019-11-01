//
//  YGHomeModel.m
//  clientservice
//
//  Created by 龙广发 on 2018/11/2.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "YGHomeModel.h"

@implementation YGHomeModel

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
