//
//  CommentView.m
//  clientservice
//
//  Created by 龙广发 on 2018/9/20.
//  Copyright © 2018年 龙广发. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView

-(instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.textView];
        [self addSubview:self.likeBtn];
        [self addSubview:self.placLabel];

        [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_offset(25*_Scaling);
            make.right.mas_offset(-20);
            make.centerY.mas_equalTo(self);
        }];

        
        [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_offset(20*_Scaling);
            make.centerY.mas_equalTo(self);
            make.height.mas_offset(36*_Scaling);
            make.right.mas_equalTo(self.likeBtn.mas_left).mas_offset(-20*_Scaling);
        }];
        
        [self.placLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.mas_offset(34*_Scaling);
            make.width.mas_offset(140*_Scaling);
            make.height.mas_offset(14*_Scaling);
            make.centerY.mas_equalTo(self);
        }];

    }
    return self;
}

-(UITextView *)textView {
    
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = tableViewRGBColor;
        _textView.layer.cornerRadius = 18*_Scaling;
        _textView.layer.masksToBounds = YES;
        _textView.layer.borderColor = tableViewRGBColor.CGColor;
        _textView.layer.borderWidth = 1.0;
        _textView.contentInset = UIEdgeInsetsMake(5, 10, 0, 0);
        _textView.font = [UIFont systemFontOfSize:14*_Scaling];
        _textView.returnKeyType = UIReturnKeyDone;
    }
    return _textView;
}

-(UIButton *)likeBtn {
    
    if (!_likeBtn) {
        _likeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeBtn setBackgroundImage:[UIImage imageNamed:@"点赞"] forState:(UIControlStateNormal)];
        [_likeBtn setBackgroundImage:[UIImage imageNamed:@"点赞2"] forState:(UIControlStateSelected)];

    }
    return _likeBtn;
}

//-(UIButton *)shareBtn {
//
//    if (!_shareBtn) {
//        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"点赞"] forState:(UIControlStateNormal)];
//        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"点赞2"] forState:(UIControlStateSelected)];
//
//    }
//    return _shareBtn;
//}

-(UILabel *)placLabel {
    
    if (!_placLabel) {
        _placLabel = [[UILabel alloc] init];
        _placLabel.textAlignment = NSTextAlignmentLeft;
        _placLabel.textColor = grayRGBColor;
        _placLabel.font = [UIFont systemFontOfSize:14*_Scaling];
    }
    return _placLabel;
}

@end
