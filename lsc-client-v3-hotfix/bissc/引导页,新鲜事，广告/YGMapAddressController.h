//
//  YGMapAddressController.h
//  clientservice
//
//  Created by 龙广发 on 2019/1/7.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ReturnAddressBlock) (NSString *address);

@interface YGMapAddressController : UIViewController

@property(nonatomic,copy) ReturnAddressBlock block;

@end

typedef void (^ReturnCreateAddressBlock) (NSString *address);


@interface YGCreateAddressController : UIViewController

@property(nonatomic,copy) ReturnCreateAddressBlock block;

@end
