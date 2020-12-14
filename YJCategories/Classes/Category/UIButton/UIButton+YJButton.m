//
//  UIButton+YJButton.m
//  YJCategories
//
//  Created by Yang on 2019/5/7.
//

#import "UIButton+YJButton.h"
#import <objc/runtime.h>

@implementation UIButton (YJButton)

static char *YJIndicatorViewKey = "YJIndicatorViewKey";

/// 开始loading动画
- (void)yjStartAnimation {
    self.enabled = NO;
    
    UIView *backView = objc_getAssociatedObject(self, &YJIndicatorViewKey);
    
    if (!backView) {
        backView = [[UIView alloc] initWithFrame:self.bounds];
        backView.backgroundColor = self.backgroundColor;
        backView.layer.cornerRadius = self.layer.cornerRadius;

        objc_setAssociatedObject(self, &YJIndicatorViewKey, backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self addSubview:backView];
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.frame = CGRectMake(0, 0, 30, 30);
    activityIndicator.center = backView.center;
    
    /// 进度器颜色处理
    if ([self.backgroundColor isEqual:[UIColor clearColor]] || self.backgroundColor == nil || [self.backgroundColor isEqual:[UIColor whiteColor]]) {
        activityIndicator.color = [UIColor grayColor];
        
    } else {
        activityIndicator.color = [UIColor whiteColor];
    }
    
    CGAffineTransform transform = CGAffineTransformMakeScale(0.7, 0.7);
    activityIndicator.transform = transform;
    [backView addSubview:activityIndicator];
    [activityIndicator startAnimating];
}

/// 停止loading动画
- (void)yjStopAnimation {
    UIView *indicatorView = objc_getAssociatedObject(self, &YJIndicatorViewKey);
    if (!indicatorView) return;
    
    [indicatorView removeFromSuperview];
    self.enabled = YES;
}

@end
