//
//  UIButton+YJPosition.m
//  YJCategories
//
//  Created by Yang on 2019/7/31.
//

#import "UIButton+YJPosition.h"

@implementation UIButton (YJPosition)

- (void)yjLayoutButtonWithStyle:(YJButtonLayerStyle)style space:(CGFloat)space {
    
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    CGFloat labelWidth = self.titleLabel.intrinsicContentSize.width;
    CGFloat labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    if (style == YJButtonLayerStyleHorizontalImageLeft) {
        
    } else if (style == YJButtonLayerStyleHorizontalImageRight) {
        
        UIEdgeInsets imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, 0, -labelWidth);
        UIEdgeInsets labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
        
    } else if (style == YJButtonLayerStyleVerticalImageUp) {
        
        UIEdgeInsets imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
        UIEdgeInsets labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
        
    } else if (style == YJButtonLayerStyleVerticalImageDown) {
        
        UIEdgeInsets labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, 0, 0, imageWith);
        UIEdgeInsets imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth, -labelHeight-space/2.0, 0);
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
    }

}

@end
