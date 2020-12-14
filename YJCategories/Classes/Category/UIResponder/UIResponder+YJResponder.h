//
//  UIResponder+YJResponder.h
//  YJCategories
//
//  Created by Yang on 2020/8/10.
//

#import <UIKit/UIKit.h>

@interface UIResponder (YJResponder)

/// 响应链查找Controller
- (UIViewController *)yjNextResponderForController;

@end
