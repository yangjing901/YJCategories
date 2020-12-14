//
//  NSString+YJSize.m
//  YJCategories
//
//  Created by Yang on 2019/5/16.
//

#import "NSString+YJSize.h"

@implementation NSString (POSize)

/// 字节长度（GBK）
- (long)yjConvertToByte {
    NSUInteger asciiLength = 0;
    
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    NSUInteger unicodeLength = asciiLength;
    return unicodeLength;
}

/// 按字节截取（GBK）
- (NSString *)yjSubStringByByteWithIndex:(NSInteger)index {
    NSInteger sum = 0;
    NSString *subStr = [[NSString alloc] init];
    for(int i = 0; i<[self length]; i++){
        unichar strChar = [self characterAtIndex:i];
        sum += isascii(strChar) ? 1 : 2;
        
        if (sum >= index) {
            subStr = [self substringToIndex:i+1];
            return subStr;
        }
    }
    return subStr;
}

@end
