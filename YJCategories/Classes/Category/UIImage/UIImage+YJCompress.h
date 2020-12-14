//
//  UIImage+YJCompress.h
//  PopOn
//
//  Created by 杨警 on 2018/6/8.
//  Copyright © 2018年 WORDOOR. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YJCompress)

/**
 *  压缩图片尺寸（1224*2208）
 */
- (UIImage *)yjCompressImage;

/**
 *  压缩图片尺寸 maxsize
 */
- (UIImage *)yjCompressImageWithMaxSize:(CGSize)maxsize;

/**
 *  压缩图片尺寸（1224*2208）
 */
- (NSData *)yjCompressImageToData;

/**
 *  压缩图片尺寸 maxsize
 */
- (NSData *)yjCompressImageToDataWithMaxSize:(CGSize)maxsize;

/**
 *  压缩图片尺寸maxLength
 */
-(NSData *)yjCompressImageWithMaxLength:(NSUInteger)maxLength;

@end
