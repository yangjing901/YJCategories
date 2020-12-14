//
//  NSString+YJLocalized.m
//  YJCategories
//
//  Created by Yang on 2019/5/7.
//

#import "NSString+YJLocalized.h"

static NSString *kYJUserDefaultsCurrentLocalizedLanguage = @"YJ_CURRENT_LOCALIZED_LANGUAGE";

/// 语言
NSString * const YJLanguageCodeEnglish = @"English";
NSString * const YJLanguageCodeChinese = @"Chinese";
NSString * const YJLanguageCodeKorean = @"Korean";
NSString * const YJLanguageCodeJapanese = @"Japanese";
NSString * const YJLanguageCodeFrench = @"French";
NSString * const YJLanguageCodeSpanish = @"Spanish";
NSString * const YJLanguageCodeRussian = @"Russian";
NSString * const YJLanguageCodeGerman = @"German";
NSString * const YJLanguageCodeVietnamese = @"Vietnamese";

@implementation NSString (POLocalized)

/// 本地化
+ (NSString *)yjLocalizedString:(NSString *)format, ... {
    format = [self yjLocalizedString:format language:[self yjLocalLanguageCode]];
    
    va_list ap;
    va_start(ap, format);
    NSString *content = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end(ap);
    return content;
}

/// 本地化
+ (NSString *)yjLocalizedString:(NSString *)string language:(NSString *)language {
    return [self yjLocalizedString:string language:language bundle:[NSBundle mainBundle]];
}

+ (NSString *)yjLocalizedString:(NSString *)string language:(NSString *)language bundle:(NSBundle *)bundle {
    
    if (!bundle) bundle = [NSBundle mainBundle];
    
    NSBundle *stringsBundle;
    if ([language isEqualToString:YJLanguageCodeChinese]) {
        stringsBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"zh-Hans" ofType:@"lproj"]];
        
    } else if ([language isEqualToString:YJLanguageCodeKorean]) {
        stringsBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"ko" ofType:@"lproj"]];
        
    } else if ([language isEqualToString:YJLanguageCodeJapanese]) {
        stringsBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"ja" ofType:@"lproj"]];
        
    } else if ([language isEqualToString:YJLanguageCodeSpanish]) {
        stringsBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"es" ofType:@"lproj"]];
        
    } else if ([language isEqualToString:YJLanguageCodeVietnamese]) {
        stringsBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"vi" ofType:@"lproj"]];
        
    } else if ([language isEqualToString:YJLanguageCodeRussian]) {
        stringsBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"ru" ofType:@"lproj"]];
        
    } else if ([language isEqualToString:YJLanguageCodeFrench]) {
        stringsBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"fr" ofType:@"lproj"]];
        
    } else if ([language isEqualToString:YJLanguageCodeGerman]) {
        stringsBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"de" ofType:@"lproj"]];
        
    } else if ([language isEqualToString:YJLanguageCodeEnglish]) {
        stringsBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"en" ofType:@"lproj"]];
    }
    
    if (!stringsBundle) {
        stringsBundle = [NSBundle bundleWithPath:[bundle pathForResource:@"en" ofType:@"lproj"]];
    }
    
    NSString *localizedString = [stringsBundle localizedStringForKey:string value:nil table:nil];
    return localizedString ? localizedString : string;
}

/// 当前App语言
+ (NSString *)yjLocalLanguageCode {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *localLanguageCode = [userDefaults valueForKey:kYJUserDefaultsCurrentLocalizedLanguage];
    
    if (localLanguageCode == nil || localLanguageCode.length == 0) {
        NSArray *localLanguageArray = [userDefaults valueForKey:@"AppleLanguages"];
        if (localLanguageArray.count > 0) {
            
            NSString *currentLang = [localLanguageArray objectAtIndex:0];
            if ([currentLang rangeOfString:@"zh-Hans"].location != NSNotFound|| [currentLang rangeOfString:@"zh-Hant"].location != NSNotFound) {
                localLanguageCode = YJLanguageCodeChinese;
                
            } else if([currentLang rangeOfString:@"es"].location != NSNotFound )  {
                localLanguageCode = YJLanguageCodeSpanish;
                
            } else if([currentLang rangeOfString:@"ja"].location != NSNotFound)  {
                localLanguageCode = YJLanguageCodeJapanese;
                
            } else if([currentLang rangeOfString:@"ko"].location != NSNotFound)  {
                localLanguageCode = YJLanguageCodeKorean;
                
            } else if([currentLang rangeOfString:@"vi"].location != NSNotFound)  {
                localLanguageCode = YJLanguageCodeVietnamese;
                
            } else if([currentLang rangeOfString:@"ru"].location != NSNotFound)  {
                localLanguageCode = YJLanguageCodeRussian;
                
            } else if([currentLang rangeOfString:@"fr"].location != NSNotFound)  {
                localLanguageCode = YJLanguageCodeFrench;
                
            } else if([currentLang rangeOfString:@"de"].location != NSNotFound)  {
                localLanguageCode = YJLanguageCodeGerman;
                
            }  else {
                localLanguageCode = YJLanguageCodeEnglish;
            }
        } else {
            localLanguageCode = YJLanguageCodeEnglish;
        }
        
        [userDefaults setValue:localLanguageCode forKey:kYJUserDefaultsCurrentLocalizedLanguage];
        [userDefaults synchronize];
    }
    
    return localLanguageCode;
}



@end
