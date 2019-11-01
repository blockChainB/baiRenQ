//
//  UIButton+XBSImageAlignment.h
//  CustomButton
//
//  Created by Mr.Fn on 2018/4/24.
//  Copyright © 2018年 Mr.Fn. All rights reserved.
//

/*
 * Important :
 * Make sure that  the Label.text and  image is displayed correct at the same time before use this Category.
 */

#import <UIKit/UIKit.h>

@interface UIButton (XBSImageAlignment)

-(void)xbs_updateImageAlignmentToLeft;
- (void)xbs_updateImageAlignmentToLefttWithSpace:(CGFloat)space;
//to Right
- (void)xbs_updateImageAlignmentToRight;

//to UP
- (void)xbs_updateImageAlignmentToUp;

//to Down
- (void)xbs_updateImageAlignmentToDown;


//space : space  between  textLabel and  imageView
- (void)xbs_updateImageAlignmentToRightWithSpace:(CGFloat)space;
- (void)xbs_updateImageAlignmentToUpWithSpace:(CGFloat)space;
- (void)xbs_updateImageAlignmentToDownWithSpace:(CGFloat)space;


@end

