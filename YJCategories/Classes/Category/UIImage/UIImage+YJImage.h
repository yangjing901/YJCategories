//
//  UIImage+YJImage.h
//  FBSnapshotTestCase
//
//  Created by Yang on 2020/5/19.
//

#import <UIKit/UIKit.h>

@interface UIImage (YJImage)

/// 图片高斯模糊
+ (UIImage *)yjGaussianBlurWithImage:(UIImage *)image blur:(CGFloat)blur;

///根据颜色创建image
+ (UIImage *)yjImageWithColor:(UIColor *)color;

+ (UIImage *)yjImageWithColor:(UIColor*)color rect:(CGRect)rect;

/// 根据View创建image
+ (UIImage *)yjImageWithView:(UIView *)view size:(CGSize)size;

/// 根据View创建image
+ (UIImage *)yjImageWithView:(UIView *)view size:(CGSize)size opaque:(BOOL)opaque scale:(CGFloat)scale;

/// 生成二维码
+ (UIImage *)yjGenerateQRCodeWithString:(NSString *)string;

///  获取高清图
+ (UIImage *)yjHDImageFromCIImage:(CIImage *)image size:(CGFloat)size;

@end
