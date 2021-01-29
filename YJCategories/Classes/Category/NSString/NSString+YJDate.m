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

/// 时间格式转换, 时间戳->日期（一天以内（上/下午，12小时制），一周以内（星期，24小时制），其他（年月日 时分））
+ (NSString *)yjDateFormatterForCalendarTimeInterval:(long long)timeInterval {

    NSTimeInterval tempMilli = timeInterval;
    NSTimeInterval seconds = tempMilli/1000.0;
    NSDate *myDate = [NSDate dateWithTimeIntervalSince1970:seconds];
    
    //  日历
    NSCalendar *calendar = [ NSCalendar currentCalendar ];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[ NSDate date ]];
    NSDateComponents *myCmps = [calendar components:unit fromDate:myDate];
    
    
    //  指定日历对象,要去取日期对象的那些部分.
    NSDateComponents *comp =  [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday fromDate:myDate];
    
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc ] init ];
    NSTimeZone* dataTimeZone = [NSTimeZone localTimeZone];
    [dateFmt setTimeZone:dataTimeZone];

    NSString *dateStr = @"";

    //非同年、月
    if (nowCmps.year != myCmps.year || nowCmps.month != myCmps.month) {
        dateFmt.dateFormat = @"yyyy/MM/dd HH:mm";
        dateStr = [dateFmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:seconds]];
        
    } else {
        //一天以内
        if (nowCmps.day==myCmps.day) {
            dateFmt.dateFormat = @"a hh:mm";
            dateStr = [dateFmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:seconds]];
        }
        //  一周以内
        else if ((nowCmps.day-myCmps.day) <=7) {
            dateFmt.dateFormat = @"HH:mm";

            NSString *weekStr = @"";
            switch (comp.weekday) {
                case 1:
                    weekStr = [NSString yjLocalizedString:@"星期日"];
                    break;
                case 2:
                    weekStr = [NSString yjLocalizedString:@"星期一"];
                    break;
                case 3:
                    weekStr = [NSString yjLocalizedString:@"星期二"];
                    break;
                case 4:
                    weekStr = [NSString yjLocalizedString:@"星期三"];
                    break;
                case 5:
                    weekStr = [NSString yjLocalizedString:@"星期四"];
                    break;
                case 6:
                    weekStr = [NSString yjLocalizedString:@"星期五"];
                    break;
                case 7:
                    weekStr = [NSString yjLocalizedString:@"星期六"];
                    break;
                default:
                    break;
            }
            dateStr = [dateFmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:seconds]];
            dateStr = [NSString stringWithFormat:@"%@ %@", weekStr, dateStr];
        }
        else {
            dateFmt.dateFormat = @"yyyy年MM月dd HH:mm";
            dateStr = [dateFmt stringFromDate:[NSDate dateWithTimeIntervalSince1970:seconds]];
        }
    }
    return dateStr;
}

@end
