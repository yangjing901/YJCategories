//
//  UIView+YJView.m
//  YJCategories
//
//  Created by Yang on 2019/5/7.
//

#import "UIView+YJView.h"

@implementation UIView (YJView)

/// 圆角
- (void)yjAddCornerRadius:(CGFloat)cornerRadius {
    return [self yjAddCornerRadius:cornerRadius clip:NO];
}

/// 圆角
- (void)yjAddCornerRadius:(CGFloat)cornerRadius clip:(BOOL)clip {
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = clip;
}

/// 圆角
- (void)yjAddCorners:(UIRectCorner)corners rect:(CGRect)rect radius:(CGFloat)cornerRadius clip:(BOOL)clip {
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = path.CGPath;
    layer.frame = rect;
    self.layer.mask = layer;
    self.layer.masksToBounds = clip;
}

/// 阴影
- (void)yjAddShadowColor:(UIColor *)shadowColor offset:(CGSize)offset radius:(CGFloat)radius opacity:(float)opacity {
    return [self yjAddShadowColor:shadowColor offset:offset radius:radius opacity:opacity path:nil];
}

/// 阴影
- (void)yjAddShadowColor:(UIColor *)shadowColor offset:(CGSize)offset radius:(CGFloat)radius opacity:(float)opacity path:(UIBezierPath *)path {
    self.layer.shadowColor   = shadowColor.CGColor;
    self.layer.shadowOffset  = offset;
    self.layer.shadowRadius  = radius;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowPath    = path.CGPath;
}

/// 边框
- (void)yjAddBorderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth {
    self.layer.borderColor   = borderColor.CGColor;
    self.layer.borderWidth   = borderWidth;
}

@end
