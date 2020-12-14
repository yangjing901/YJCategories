//
//  UIImage+YJCompress.m
//  PopOn
//
//  Created by 杨警 on 2018/6/8.
//  Copyright © 2018年 WORDOOR. All rights reserved.
//

#import "UIImage+YJCompress.h"

@implementation UIImage (YJCompress)

//MARK: - 压缩图片尺寸
- (NSData *)yjCompressImageToData {
    UIImage *resultImage = [self yjCompressImage];
    return UIImageJPEGRepresentation(resultImage, 1);
}

- (NSData *)yjCompressImageToDataWithMaxSize:(CGSize)maxsize {
    UIImage *resultImage = [self yjCompressImageWithMaxSize:maxsize];
    return UIImageJPEGRepresentation(resultImage, 1);
}

- (UIImage *)yjCompressImage {
    //以iPhone6P尺寸为基准
    return [self yjCompressImageWithMaxSize:CGSizeMake(1242, 2208)];
}

- (UIImage *)yjCompressImageWithMaxSize:(CGSize)maxsize {
    
    CGFloat fixelW = CGImageGetWidth(self.CGImage);
    CGFloat fixelH = CGImageGetHeight(self.CGImage);
    if (fixelW <= maxsize.width && fixelH <= maxsize.height) return self;
    
    CGFloat widthScale = maxsize.width/fixelW;
    CGFloat heightScale = maxsize.height/fixelH;
    
    CGSize resultSize;
    //宽度取maxsize.width
    if (widthScale < heightScale) {
        resultSize = CGSizeMake(maxsize.width, fixelH*widthScale);
    } else {
        resultSize = CGSizeMake(maxsize.height, fixelW*heightScale);
    }
        
    UIGraphicsBeginImageContext(resultSize);
    [self drawInRect:CGRectMake(0, 0, resultSize.width, resultSize.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}

//MARK: - 压缩图片大小

//MARK: - 压缩图片大小&尺寸
-(NSData *)yjCompressImageWithMaxLength:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxLength) return data;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    if (data.length < maxLength) return data;
    UIImage *resultImage = [UIImage imageWithData:data];
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    return data;
}


@end
