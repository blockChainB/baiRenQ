//
//  MLLabelUtil.m
//  MomentKit
//
//  Created by LEA on 2017/12/13.
//  Copyright © 2017年 LEA. All rights reserved.
//

#import "MLLabelUtil.h"

@implementation MLLabelUtil

MLLinkLabel *kMLLinkLabel()
{
    MLLinkLabel *_linkLabel = [MLLinkLabel new];
    _linkLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _linkLabel.textColor = [UIColor blackColor];
    _linkLabel.font =   [UIFont systemFontOfSize:14.0];
    _linkLabel.numberOfLines = 0;
    _linkLabel.linkTextAttributes = @{NSForegroundColorAttributeName:kHLTextColor};//kHLTextColor
    _linkLabel.activeLinkTextAttributes = @{NSForegroundColorAttributeName:kHLTextColor,NSBackgroundColorAttributeName:kHLBgColor};
    _linkLabel.activeLinkToNilDelay = 0.3;
    return _linkLabel;
}

NSMutableAttributedString *kMLLinkLabelAttributedText(id object)
{
    NSMutableAttributedString *attributedText = nil;
    if ([object isKindOfClass:[NSDictionary class]])
    {

        Comment *comment = [[Comment alloc] initWithDic:object];
        
        if ([comment.memberName isEqualToString:comment.memberNames]) {
            NSString *likeString  = [NSString stringWithFormat:@"%@：%@",comment.memberName,comment.content];
            attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
            [attributedText setAttributes:@{NSFontAttributeName:kComHLTextFont,NSLinkAttributeName:comment.memberName}
                                    range:[likeString rangeOfString:comment.memberName]];
        }else {
            
            if (comment.memberNames.length > 0) {
                
                NSString *likeString  = [NSString stringWithFormat:@"%@回复%@：%@",comment.memberName,comment.memberNames,comment.content];
                attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
                [attributedText setAttributes:@{NSFontAttributeName:kComHLTextFont,NSLinkAttributeName:comment.memberName}
                                        range:[likeString rangeOfString:comment.memberName]];
                [attributedText setAttributes:@{NSFontAttributeName:kComHLTextFont,NSLinkAttributeName:comment.memberNames}
                                        range:[likeString rangeOfString:comment.memberNames]];
                
            }else {
                
                NSString *likeString  = [NSString stringWithFormat:@"%@：%@",comment.memberName,comment.content];
                attributedText = [[NSMutableAttributedString alloc] initWithString:likeString];
                [attributedText setAttributes:@{NSFontAttributeName:kComHLTextFont,NSLinkAttributeName:comment.memberName}
                                        range:[likeString rangeOfString:comment.memberName]];
            }
        }
    }

    return attributedText;
}


@end
