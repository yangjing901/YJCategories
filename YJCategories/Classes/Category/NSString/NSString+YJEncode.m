//
//  NSString+YJEncode.m
//  YJCategories
//
//  Created by 杨警 on 2019/6/21.
//

#import "NSString+YJEncode.h"

#include <sys/param.h>
#include <sys/mount.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>


@implementation NSString (Encode)

/// url编码
- (NSString *)yjUrlEncode {
    NSString *charactersToEscape = @"!*'();:@&=+$,/?%#[]";
    NSCharacterSet *allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    NSString *encodedUrl = [self stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
    return encodedUrl;
}

/// url反编码
- (NSString *)yjUrlDecode {
//    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapes(NULL, (__bridge CFStringRef)self, CFSTR(""));
    NSString *decodedString = [self stringByRemovingPercentEncoding];
    return decodedString;
}

/// H5参数解析
- (NSDictionary *)yjGetHtmlParameterFromUrl {
    NSString *url = self;
    if (!url) return nil;
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setValue:url forKey:@"url"];
    
    if (![url containsString:@"?"]) {
        return parameter;
    }
    
    NSArray *urlArray = [url componentsSeparatedByString:@"?"];
    if (urlArray.count == 2) {
        NSString *parameterStr = urlArray[1];
        /// 多参数
        if ([parameterStr containsString:@"&"]) {
            NSArray *parameterArray = [parameterStr componentsSeparatedByString:@"&"];
            for (NSString *parameterItemStr in parameterArray) {
                if ([parameterItemStr containsString:@"="]) {
                    NSArray *parameterItemArray = [parameterItemStr componentsSeparatedByString:@"="];
                    if (parameterItemArray.count == 2) {
                        [parameter setValue:parameterItemArray[1] forKey:parameterItemArray[0]];
                    }
                    
                }
            }
        }
        /// 单参数
        else if ([parameterStr containsString:@"="]) {
            NSArray *parameterItemArray = [parameterStr componentsSeparatedByString:@"="];
            if (parameterItemArray.count == 2) {
                [parameter setValue:parameterItemArray[1] forKey:parameterItemArray[0]];
            }
        }
    }
    return parameter;
}

/// md5加密
- (NSString *)yjMd5Encode {
    if (@available(iOS 13.0, *)) {
        return self;
        
    } else {
        const char *cStr = [self UTF8String];
        unsigned char digest[CC_MD5_DIGEST_LENGTH];
        CC_MD5( cStr, (unsigned int)strlen(cStr), digest ); // This is the md5 call
        
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x", digest[i]];
        return  output;
    }
}

//将十进制转化为十六进制
+ (NSString *)yjToHex:(long long)tmpid {
    NSString *nLetterValue;
    NSString *str =@"";
    long long int ttmpig;
    for (int i = 0; i<9; i++) {
        ttmpig=tmpid%16;
        tmpid=tmpid/16;
        switch (ttmpig) {
            case 10:
                nLetterValue =@"A";break;
            case 11:
                nLetterValue =@"B";break;
            case 12:
                nLetterValue =@"C";break;
            case 13:
                nLetterValue =@"D";break;
            case 14:
                nLetterValue =@"E";break;
            case 15:
                nLetterValue =@"F";break;
            default:nLetterValue=[[NSString alloc]initWithFormat:@"%lli",ttmpig];
        }
        str = [nLetterValue stringByAppendingString:str];
        if (tmpid == 0) {
            break;
        }
    }
    return str;
}

/// aes256加密
- (NSData *)yjAes256DataEncryptWithSalt:(NSString *)salt {
    NSData *enData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *key = [salt dataUsingEncoding:NSUTF8StringEncoding];
    NSData *iv = [salt dataUsingEncoding:NSUTF8StringEncoding];
    
    if (key.length != 16 && key.length != 24 && key.length != 32) {
        return nil;
    }
    if (iv.length != 16 && iv.length != 0) {
        return nil;
    }
    
    NSData *result = nil;
    size_t bufferSize = enData.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (!buffer) return nil;
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,//填充方式
                                          key.bytes,
                                          key.length,
                                          iv.bytes,
                                          enData.bytes,
                                          enData.length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [[NSData alloc]initWithBytes:buffer length:encryptedSize];
        free(buffer);
        return result;
        
    } else {
        free(buffer);
        return nil;
    }
}

- (NSString *)yjAes256StringEncryptWithSalt:(NSString *)salt {
    //对数据进行加密
    NSData *result = [self yjAes256DataEncryptWithSalt:salt];
    //转换为2进制字符串
    if (result && result.length > 0) {
        NSString *base64Encode = [result base64EncodedStringWithOptions:0];
        return  base64Encode;
    }
    return nil;
}

/// aes256解密
- (NSData *)yjAes256DataDecryptWithSalt:(NSString *)salt {
    NSData *deData = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *key = [salt dataUsingEncoding:NSUTF8StringEncoding];
    NSData *iv = [salt dataUsingEncoding:NSUTF8StringEncoding];
    
    if (key.length != 16 && key.length != 24 && key.length != 32) {
        return nil;
    }
    if (iv.length != 16 && iv.length != 0) {
        return nil;
    }
    
    NSData *result = nil;
    size_t bufferSize = deData.length + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    if (!buffer) return nil;
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,//填充方式
                                          key.bytes,
                                          key.length,
                                          iv.bytes,
                                          deData.bytes,
                                          deData.length,
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [[NSData alloc]initWithBytes:buffer length:encryptedSize];
        NSLog(@"result ：%@",result);
        free(buffer);
        return result;
    } else {
        free(buffer);
        return nil;
    }
}

- (NSString *)yjAes256StringDecryptWithSalt:(NSString*)salt {
    //转换为2进制Data
    NSMutableData *data = [NSMutableData dataWithCapacity:self.length / 2];
    unsigned char whole_byte;
    char byte_chars[3] = {'\0','\0','\0'};
    int i;
    for (i=0; i < [self length] / 2; i++)
    {
        byte_chars[0] = [self characterAtIndex:i*2];
        byte_chars[1] = [self characterAtIndex:i*2+1];
        whole_byte = strtol(byte_chars, NULL, 16);
        [data appendBytes:&whole_byte length:1];
    }
    //对数据进行解密
    NSData* result = [self yjAes256DataDecryptWithSalt:salt];
    if (result && result.length > 0) {
        NSString *base64Encode = [result base64EncodedStringWithOptions:0];
        NSData *nsdataFromBase64String = [[NSData alloc]
        initWithBase64EncodedString:base64Encode options:0];

        NSString *base64Decoded = [[NSString alloc]
          initWithData:nsdataFromBase64String encoding:NSUTF8StringEncoding];
        return base64Decoded ;
    }
    return nil;
}

@end
