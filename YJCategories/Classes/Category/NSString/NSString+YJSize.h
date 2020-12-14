//
//  NSString+YJSize.h
//  YJCategories
//
//  Created by Yang on 2019/5/16.
//

#import <Foundation/Foundation.h>

@interface NSString (POSize)

/// 字节长度（GBK）
- (long)yjConvertToByte;

/// 按字节截取（GBK）
- (NSString *)yjSubStringByByteWithIndex:(NSInteger)index;

@end
