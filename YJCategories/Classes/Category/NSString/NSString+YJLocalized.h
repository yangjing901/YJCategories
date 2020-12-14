//
//  NSString+YJLocalized.h
//  YJCategories
//
//  Created by Yang on 2019/5/7.
//

#import <Foundation/Foundation.h>

/// 语言
typedef NSString * YJLanguageCode NS_STRING_ENUM;
/// Chinese
FOUNDATION_EXPORT YJLanguageCode const YJLanguageCodeChinese;
/// English
FOUNDATION_EXPORT YJLanguageCode const YJLanguageCodeEnglish;
/// Korean
FOUNDATION_EXPORT YJLanguageCode const YJLanguageCodeKorean;
/// Japanese
FOUNDATION_EXPORT YJLanguageCode const YJLanguageCodeJapanese;
/// French
FOUNDATION_EXPORT YJLanguageCode const YJLanguageCodeFrench;
/// Spanish
FOUNDATION_EXPORT YJLanguageCode const YJLanguageCodeSpanish;
/// Russian
FOUNDATION_EXPORT YJLanguageCode const YJLanguageCodeRussian;
/// German
FOUNDATION_EXPORT YJLanguageCode const YJLanguageCodeGerman;
/// Vietnamese
FOUNDATION_EXPORT YJLanguageCode const YJLanguageCodeVietnamese;


@interface NSString (POLocalized)

/// 本地化
+ (NSString *)yjLocalizedString:(NSString *)format, ...;

/// 本地化
+ (NSString *)yjLocalizedString:(NSString *)string language:(YJLanguageCode)language;

/// 本地化
+ (NSString *)yjLocalizedString:(NSString *)string language:(NSString *)language bundle:(NSBundle *)bundle;

/// 当前App语言
+ (NSString *)yjLocalLanguageCode;

@end

