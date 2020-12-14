//
//  NSString+YJEncode.h
//  YJCategories
//
//  Created by 杨警 on 2019/6/21.
//

#import <Foundation/Foundation.h>

@interface NSString (Encode)

/// url编码
- (NSString *)yjUrlEncode;

/// url反编码
- (NSString *)yjUrlDecode;

/// H5参数解析
- (NSDictionary *)yjGetHtmlParameterFromUrl;

/// md5加密
- (NSString *)yjMd5Encode NS_DEPRECATED_IOS(2.0, 13.0);

//将十进制转化为十六进制
+ (NSString *)yjToHex:(long long)tmpid;

/// aes256加密
- (NSString *)yjAes256StringEncryptWithSalt:(NSString *)salt;

/// aes256加密
- (NSData *)yjAes256DataEncryptWithSalt:(NSString *)salt;

/// aes256解密
- (NSString *)yjAes256StringDecryptWithSalt:(NSString *)salt;

/// aes256解密
- (NSData *)yjAes256DataDecryptWithSalt:(NSString *)salt;

@end
