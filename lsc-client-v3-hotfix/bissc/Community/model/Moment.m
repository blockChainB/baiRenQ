//
//  Moment.m
//  MomentKit
//
//  Created by LEA on 2017/12/12.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "Moment.h"

@implementation Moment

-(instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self ;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"id"]) {
        
        self.topicId = value;
    }
}

@end
