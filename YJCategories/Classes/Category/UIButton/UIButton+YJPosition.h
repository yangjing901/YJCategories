//
//  UIButton+YJPosition.h
//  YJCategories
//
//  Created by Yang on 2019/7/31.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YJButtonLayerStyle) {
    /// 左右结构，图片在左文字在右
    YJButtonLayerStyleHorizontalImageLeft = 0,
    /// 左右结构，图片在右文字在左
    YJButtonLayerStyleHorizontalImageRight = 1,
    /// 上下结构，图片在上文字在下
    YJButtonLayerStyleVerticalImageUp = 2,
    /// 上下结构，图片在下文字在上
    YJButtonLayerStyleVerticalImageDown = 3,
};

@interface UIButton (YJPosition)

/// button上图片，文字位置排版（space：文字和图片间隔）
- (void)yjLayoutButtonWithStyle:(YJButtonLayerStyle)style space:(CGFloat)space;

@end
