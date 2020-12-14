//
//  NSString+YJDate.m
//  YJCategories
//
//  Created by Yang on 2020/5/19.
//

#import "NSString+YJDate.h"
#import "NSString+YJLocalized.h"

@implementation NSString (YJDate)

/// String -> NSDate ("yyyy-MM-dd HH:mm:ss")
+ (NSDate *)yjNSDateFromDateStr:(NSString *)dataStr {
    NSDateFormatter *dataFormatter = [[NSDateFormatter alloc] init];
    dataFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    return  [dataFormatter dateFromString:dataStr];
}

/// String -> NSTimeInterval ("yyyy-MM-dd HH:mm:ss")
+ (NSTimeInterval)yjTimeintervalFromDateStr:(NSString *)dataStr {
    NSDate *date = [self yjNSDateFromDateStr:dataStr];
    return [date timeIntervalSince1970];
}

/// 时间格式转换, "yyyy/MM/dd"
+ (NSString *)yjDateFormatterForDayByTimeInterval:(NSTimeInterval)timeInterval {
    return [self yjDateFormatter:@"yyyy/MM/dd" timeInterval:timeInterval];
}

/// 时间格式转换, "MM/dd"
+ (NSString *)yjDateFormatterForDayWithOutYearByTimeInterval:(NSTimeInterval)timeInterval {
    return [self yjDateFormatter:@"MM/dd" timeInterval:timeInterval];
}

/// 时间格式转换, "a h:mm"
+ (NSString *)yjDateFormatterForHourByTimeInterval:(NSTimeInterval)timeInterval {
    return [self yjDateFormatter:@"a h:mm" timeInterval:timeInterval];
}

/// 时间格式转换, "HH:mm"
+ (NSString *)yjDateFormatterForHourMinuteByTimeInterval:(NSTimeInterval)timeInterval{
    return [self yjDateFormatter:@"HH:mm" timeInterval:timeInterval];
}

/// 时间格式转换, "yyyy/MM/dd HH:mm"
+ (NSString *)yjDateFormatterForDayHourByTimeInterval:(NSTimeInterval)timeInterval {
    return [self yjDateFormatter:@"yyyy/MM/dd HH:mm" timeInterval:timeInterval];
}

/// 时间格式转换, 时间戳->字符串
+ (NSString *)yjDateFormatter:(NSString *)dateFormatterStr timeInterval:(NSTimeInterval)timeInterval {
    if (timeInterval >= 999999999999) timeInterval /= 1000;
    
    NSString *dateStr = @"";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone* dataTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:dataTimeZone];
    
    NSString *localLan = [NSString yjLocalLanguageCode];
    if (![localLan isEqual:YJLanguageCodeChinese]) {
        localLan = @"en";
    } else {
        localLan = @"zh-CN";
    }
    
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:localLan];
    [dateFormatter setDateFormat:dateFormatterStr];
    dateStr = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    return dateStr;
}

@end
