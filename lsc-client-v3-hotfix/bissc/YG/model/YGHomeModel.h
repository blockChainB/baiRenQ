//
//  YGHomeModel.h
//  clientservice
//
//  Created by 龙广发 on 2018/11/2.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGHomeModel : NSObject

@property(nonatomic,strong)NSDictionary *dataDic;

-(instancetype)initWithDic:(NSDictionary *)dic ;

@end
