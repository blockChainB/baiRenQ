//
//  LasAdvertisementController.h
//  WBHManageClient
//
//  Created by 龙广发 on 2019/6/21.
//  Copyright © 2019年 龙广发. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LasAdvertisementDelegate <NSObject>

- (void)touchAction;

@end

@interface LasAdvertisementController : UIViewController

@property (nonatomic, assign) id<LasAdvertisementDelegate> delegate;

- (void)guidePageControllerWithImageUrl:(NSDictionary *)adDic;
@end

NS_ASSUME_NONNULL_END
