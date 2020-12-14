//
//  NSObject+YJObject.h
//  YJCategories
//
//  Created by Yang on 2019/8/20.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSObject (YJObject)

/// 获取当前屏幕显示的viewcontroller
+ (UIViewController *)yjCurrentViewController;

///获取对象属性，适配iOS13之后不能使用kvc获取属性
+ (id)yjGetClassVar:(id)classObject varName:(char *)varName;

@end

