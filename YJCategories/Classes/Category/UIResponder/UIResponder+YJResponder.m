//
//  UIResponder+YJResponder.m
//  YJCategories
//
//  Created by Yang on 2020/8/10.
//

#import "UIResponder+YJResponder.h"

@implementation UIResponder (YJResponder)

- (UIViewController *)yjNextResponderForController {
    id target = self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}


@end
