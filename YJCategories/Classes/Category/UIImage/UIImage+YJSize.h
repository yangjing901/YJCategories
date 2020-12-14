//
//  UIImage+YJSize.h
//  FBSnapshotTestCase
//
//  Created by Yang on 2020/5/19.
//

#import <UIKit/UIKit.h>

@interface UIImage (YJSize)

/// 图片尺寸，最大宽高范围内宽高按比例计算
+ (CGSize)yjImageDisplaySizeWithImage:(UIImage *)image maxSize:(CGSize)maxSize;

/// 图片尺寸，最大宽高范围内宽高按比例计算
+ (CGSize)yjImageDisplaySizeWithImageSize:(CGSize)imageSize maxSize:(CGSize)maxSize;

/// 图片尺寸，宽度固定，高度按比例计算
+ (CGSize)yjImageDisplaySizeWithImageSize:(CGSize)imageSize fixedWidth:(CGFloat)fixedWidth;

@end
