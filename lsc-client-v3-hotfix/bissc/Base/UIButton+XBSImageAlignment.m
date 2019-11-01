
//
//  UIButton+XBSImageAlignment.m
//  CustomButton
//

//

#import "UIButton+XBSImageAlignment.h"

@implementation UIButton (XBSImageAlignment)
//left
- (void)xbs_updateImageAlignmentToLeft{
    
      [self xbs_updateImageAlignmentToLefttWithSpace:0];
}
- (void)xbs_updateImageAlignmentToLefttWithSpace:(CGFloat)space{
    
    CGFloat halfSpace = space / 2.0f;
    CGFloat imageWidth = self.currentImage.size.width;
//    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth-halfSpace, 0, imageWidth+halfSpace)];
    
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, halfSpace, 0, 0)];
    
    CGFloat edgeWidth = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
    
    //    [self setImageEdgeInsets:UIEdgeInsetsMake(0, edgeWidth+halfSpace, 0, -edgeWidth-halfSpace)];
    
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, halfSpace)];
    

    
}

- (void)xbs_updateImageAlignmentToRight{
    [self xbs_updateImageAlignmentToRightWithSpace:0];
}

- (void)xbs_updateImageAlignmentToRightWithSpace:(CGFloat)space{

    CGFloat halfSpace = space / 2.0f;
    CGFloat imageWidth = self.currentImage.size.width;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(0, -imageWidth-halfSpace, 0, imageWidth+halfSpace)];
    
    CGFloat edgeWidth = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
    [self setImageEdgeInsets:UIEdgeInsetsMake(0, edgeWidth+halfSpace, 0, -edgeWidth-halfSpace)];
}

- (void)xbs_updateImageAlignmentToUp{
    [self xbs_updateImageAlignmentToUpWithSpace:0];
}

- (void)xbs_updateImageAlignmentToUpWithSpace:(CGFloat)space {
    
    CGFloat halfSpace = space / 2.0f;
    CGFloat imageWidth = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(imageHeight/2 + halfSpace, -imageWidth/2, -imageHeight/2 - halfSpace, imageWidth/2)];
    
    CGFloat edgeWidth = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
    CGFloat edgeHeight = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].height;
    [self setImageEdgeInsets:UIEdgeInsetsMake(-edgeHeight/2 - halfSpace, edgeWidth / 2, edgeHeight/2 + halfSpace, -edgeWidth/2)];
}

- (void)xbs_updateImageAlignmentToDown{
    [self xbs_updateImageAlignmentToDownWithSpace:0];
}

- (void)xbs_updateImageAlignmentToDownWithSpace:(CGFloat)space {
    CGFloat halfSpace = space / 2.0f;
    CGFloat imageWidth = self.currentImage.size.width;
    CGFloat imageHeight = self.currentImage.size.height;
    [self setTitleEdgeInsets:UIEdgeInsetsMake(-imageHeight/2 - halfSpace, -imageWidth/2, imageHeight/2 + halfSpace, imageWidth/2)];
    
    CGFloat edgeWidth = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
    CGFloat edgeHeight = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].height;
    [self setImageEdgeInsets:UIEdgeInsetsMake(edgeHeight/2 + halfSpace, edgeWidth / 2, -edgeHeight/2 - halfSpace, -edgeWidth/2)];
}


@end
