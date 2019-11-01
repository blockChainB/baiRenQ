//
//  CommentView.h
//  clientservice
//
//  Created by 龙广发 on 2018/9/20.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentView : UIView

@property(nonatomic,strong) UITextView *textView;

@property(nonatomic,strong) UIButton *likeBtn;
@property(nonatomic,strong) UIButton *shareBtn;

@property(nonatomic,strong) UILabel *placLabel;


@end
