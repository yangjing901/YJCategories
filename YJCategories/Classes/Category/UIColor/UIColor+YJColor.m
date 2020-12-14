//
//  UIColor+YJColor.m
//  YJCategories
//
//  Created by Yang on 2019/5/7.
//

#import "UIColor+YJColor.h"

@implementation UIColor (YJColor)

/// 颜色转换：iOS中十六进制的颜色（以0x开头）转换为UIColor
+ (UIColor *)yjColorWithHex:(long)hexColor {
    return [UIColor yjColorWithHex:hexColor alpha:1.];
}

/// 颜色转换：iOS中十六进制的颜色（以0x开头）转换为UIColor
+ (UIColor *)yjColorWithHex:(long)hexColor alpha:(float)opacity {
    float red = ((float)((hexColor & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hexColor & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hexColor & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

/// 颜色转换：iOS中十六进制的颜色（以#/0x开头）转换为UIColor
+ (UIColor *)yjColorWithHexString:(NSString *)color {
    return [self yjColorWithHexString:color alpha:1.0f];

}

/// 颜色转换：iOS中十六进制的颜色（以#/0x开头）转换为UIColor
+ (UIColor *)yjColorWithHexString:(NSString *)color alpha:(float)opacity {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // 判断前缀并剪切掉
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:opacity];
}

+ (NSString *)yjHexadecimalFromUIColor:(UIColor*)color {

    if(CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components =CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0] green:components[0] blue:components[0] alpha:components[1]];
    }

    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }

    NSString *r,*g,*b;

    (int)((CGColorGetComponents(color.CGColor))[0]*255.0) == 0?(r =[NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[0]*255.0)]):(r= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[0]*255.0)]);

    (int)((CGColorGetComponents(color.CGColor))[1]*255.0)== 0?(g = [NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[1]*255.0)]):(g= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[1]*255.0)]);

    (int)((CGColorGetComponents(color.CGColor))[2]*255.0)== 0?(b = [NSString stringWithFormat:@"0%x",(int)((CGColorGetComponents(color.CGColor))[2]*255.0)]):(b= [NSString stringWithFormat:@"%x",(int)((CGColorGetComponents(color.CGColor))[2]*255.0)]);

    return [NSString stringWithFormat:@"#%@%@%@", r, g, b];
}

@end
