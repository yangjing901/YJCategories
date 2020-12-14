//
//  UIColor+YJColor.h
//  YJCategories
//
//  Created by Yang on 2019/5/7.
//

#import <UIKit/UIKit.h>

@interface UIColor (YJColor)

/// 颜色转换：iOS中十六进制的颜色（以0x开头）转换为UIColor
+ (UIColor *)yjColorWithHex:(long)hexColor;

/// 颜色转换：iOS中十六进制的颜色（以0x开头）转换为UIColor
+ (UIColor *)yjColorWithHex:(long)hexColor alpha:(float)opacity;

/// 颜色转换：iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *)yjColorWithHexString:(NSString *)color;

/// 颜色转换：iOS中十六进制的颜色（以#开头）转换为UIColor
+ (UIColor *)yjColorWithHexString:(NSString *)color alpha:(float)opacity;

/// 颜色转换：UIColor转换为十六进制的字符串（以#开头）
+ (NSString *)yjHexadecimalFromUIColor:(UIColor*)color;

@end
