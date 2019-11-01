//
//  YGPYCellModel.h
//  bissc
//
//  Created by 龙广发 on 2019/9/29.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YGPYCellModel : NSObject

@property (nonatomic,copy) NSString *foodImage;

@property (nonatomic,copy) NSString *foodName;

@property (nonatomic,copy) NSString *foodStyle;
@property (nonatomic,copy) NSString *foodStyle1;
@property (nonatomic,copy) NSString *foodStyle2;
@property (nonatomic,copy) NSString *address;

@property (nonatomic,assign) BOOL isSeltedYY;
@property (nonatomic,assign) BOOL isLast;
// food
@property (nonatomic,copy) NSString *commentUser;

@property (nonatomic,copy) NSString *memberName;
@property (nonatomic,copy) NSString *memberNames;

@end

NS_ASSUME_NONNULL_END
