//
//  UIImage+YJSize.m
//  FBSnapshotTestCase
//
//  Created by Yang on 2020/5/19.
//

#import "UIImage+YJSize.h"

@implementation UIImage (YJSize)

+ (CGSize)yjImageDisplaySizeWithImage:(UIImage *)image maxSize:(CGSize)maxSize {
    return [self yjImageDisplaySizeWithImageSize:image.size maxSize:maxSize];
}

+ (CGSize)yjImageDisplaySizeWithImageSize:(CGSize)imageSize maxSize:(CGSize)maxSize {
    if (imageSize.width == 0 || imageSize.height == 0) {
        return maxSize;
    }
    
    CGFloat maxHeight = maxSize.height;
    CGFloat maxWidth = maxSize.width;
    
    CGFloat pixScale = imageSize.width / imageSize.height;
    //w:h < 1: 3 -> h = maxH, w = 1/3*maxH
    if (pixScale < 0.33) {
        CGFloat currentWidth = 1 / 3.0 * maxHeight;
        if (currentWidth > maxWidth) {
            imageSize = CGSizeMake(maxWidth, maxWidth / currentWidth * maxHeight);
            
        } else {
            imageSize = CGSizeMake(currentWidth, maxHeight);
        }
        
    }
    //w:h >= 1: 3 && w:h < 1: 2.5 -> h = maxH, w = 1/2.5*maxH
    else if (pixScale >= 0.33 && pixScale < 0.4) {
        CGFloat currentWidth = 1 / 2.5 * maxHeight;
        if (currentWidth > maxWidth) {
            imageSize = CGSizeMake(maxWidth, maxWidth / currentWidth * maxHeight);
            
        } else {
            imageSize = CGSizeMake(currentWidth, maxHeight);
        }
    }
    //w:h >= 1: 2.5 && w:h < 1: 1 -> h = maxH, w = maxW*(h/maxH)
    else if (pixScale >= 0.4 && pixScale < 1) {
        CGFloat currentWidth = maxHeight / imageSize.height * imageSize.width;
        if (currentWidth > maxWidth) {
            imageSize = CGSizeMake(maxWidth, maxWidth / currentWidth * maxHeight);
            
        } else {
            imageSize = CGSizeMake(currentWidth, maxHeight);
        }
        
    }
    //w:h >= 1: 1 && w:h < 1: 2.5 -> w = maxW, h = maxH*(w/maxW)
    else if (pixScale >= 1 && pixScale < 2.5) {
        CGFloat currentHeight = maxWidth/imageSize.width*imageSize.height;
        if (currentHeight > maxHeight) {
            imageSize = CGSizeMake(maxWidth * maxHeight / currentHeight, maxHeight);
            
        } else {
            imageSize = CGSizeMake(maxWidth, currentHeight);
        }
    }
    //w:h >= 1: 2.5 && w:h < 1: 3 -> w = maxW, h = 1/2.5*maxW
    else if(pixScale >= 2.5 && pixScale < 3) {
        CGFloat currentHeight = 1/2.5*maxWidth;
        if (currentHeight > maxHeight) {
            imageSize = CGSizeMake(maxWidth * maxHeight / currentHeight, maxHeight);

        } else {
            imageSize = CGSizeMake(maxWidth, currentHeight);
        }
        
    }
    //w:h >= 1: 3 -> w = maxW, h = 1/3*maxW
    else {
        CGFloat currentHeight = 1/3*maxWidth;
        if (currentHeight > maxHeight) {
            imageSize = CGSizeMake(maxWidth * maxHeight / currentHeight, maxHeight);

        } else {
            imageSize = CGSizeMake(maxWidth, currentHeight);
        }
    }
    
    return imageSize;
}

+ (CGSize)yjImageDisplaySizeWithImageSize:(CGSize)imageSize fixedWidth:(CGFloat)fixedWidth {
    
    if (imageSize.width == 0) {
        return CGSizeMake(fixedWidth, fixedWidth);
    }
    
    CGFloat pixScale = fixedWidth / imageSize.width;
    return CGSizeMake(fixedWidth, imageSize.height * pixScale);
}

@end
