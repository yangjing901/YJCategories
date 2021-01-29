//
//  NSString+YJDate.h
//  YJCategories
//
//  Created by Yang on 2020/5/19.
//

#import <Foundation/Foundation.h>

@interface NSString (YJDate)
 
/// String -> NSDate ("yyyy-MM-dd HH:mm:ss")
+ (NSDate *)yjNSDateFromDateStr:(NSString *)dataStr;

/// String -> NSTimeInterval ("yyyy-MM-dd HH:mm:ss")
+ (NSTimeInterval)yjTimeintervalFromDateStr:(NSString *)dataStr;

/// 时间格式转换, "yyyy/MM/dd"
+ (NSString *)yjDateFormatterForDayByTimeInterval:(NSTimeInterval)timeInterval;

/// 时间格式转换, "MM/dd"
+ (NSString *)yjDateFormatterForDayWithOutYearByTimeInterval:(NSTimeInterval)timeInterval;

/// 时间格式转换, "a h:mm"
+ (NSString *)yjDateFormatterForHourByTimeInterval:(NSTimeInterval)timeInterval;

/// 时间格式转换, "HH:mm"
+ (NSString *)yjDateFormatterForHourMinuteByTimeInterval:(NSTimeInterval)timeInterval;

/// 时间格式转换, "yyyy/MM/dd HH:mm"
+ (NSString *)yjDateFormatterForDayHourByTimeInterval:(NSTimeInterval)timeInterval;

/// 时间格式转换, 时间戳->字符串
+ (NSString *)yjDateFormatter:(NSString *)dateFormatterStr timeInterval:(NSTimeInterval)timeInterval;

/// 时间格式转换, 时间戳->日期（一天以内（上/下午，12小时制），一周以内（星期，24小时制），其他（年月日 时分））
+ (NSString *)yjDateFormatterForCalendarTimeInterval:(long long)timeInterval;

@end
