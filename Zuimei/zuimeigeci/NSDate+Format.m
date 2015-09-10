//
//  NSDate+Format.m
//  WeiBo
//
//  Created by 杨少伟 on 15/8/24.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import "NSDate+Format.h"

static NSString *const FORMAT_YEAR = @"yyyy";


static NSString *const FORMAT_MONTH_DAY = @"MM月dd日";

static NSString *const FORMAT_DATE = @"yyyy-MM-dd";

static NSString *const FORMAT_TIME = @"HH:mm";

static NSString *const FORMAT_MONTH_DAY_TIME = @"MM月dd日  hh:mm";


static NSString *const FORMAT_DATE_TIME = @"yyyy-MM-dd HH:mm";

static NSString *const FORMAT_DATE1_TIME = @"yyyy/MM/dd HH:mm";

static NSString *const FORMAT_DATE_TIME_SECOND = @"yyyy/MM/dd HH:mm:ss";



static NSInteger const YEAR = 365 * 24 * 60 * 60;// 年

static NSInteger const MONTH = 30 * 24 * 60 * 60;// 月

static NSInteger const DAY = 24 * 60 * 60;// 天

static NSInteger const HOUR = 60 * 60;// 小时

static NSInteger const MINUTE = 60;// 分钟

@implementation NSDate (Format)

//date -> string
+ (NSString *)dateStringWithDate:(NSDate *)date withFormatter:(NSString *)formatter
{
    NSDateFormatter *mFromatter = [[NSDateFormatter alloc] init];
    [mFromatter setDateFormat:formatter];
    return [mFromatter  stringFromDate:date];
}
//string -> date
+ (NSDate *)dateWithDateString:(NSString *)dateString withFormatter:(NSString *)formatter
{
    NSDateFormatter *mFromatter = [[NSDateFormatter alloc] init];
    NSLocale * local = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [mFromatter setLocale:local];
    [mFromatter setDateFormat:formatter];
    return [mFromatter dateFromString:dateString];
}




+ (NSString *)dateStringWithZMDate:(NSDate *)date{
    NSDate *currentDate = [NSDate date];
    NSInteger timeGap = (NSInteger)[currentDate timeIntervalSinceDate:date];
    NSString *timeStr = nil;
    if (timeGap > YEAR) {
        timeStr = [NSString stringWithFormat:@"%li年前",timeGap / YEAR ];
    }else if (timeGap > MONTH){
         timeStr = [NSString stringWithFormat:@"%li个月前",timeGap / MONTH ];
    }else if (timeGap > DAY){
         timeStr = [NSString stringWithFormat:@"%li天前",timeGap / DAY ];
    }else if (timeGap > HOUR){
         timeStr = [NSString stringWithFormat:@"%li小时前",timeGap / HOUR ];
    }else if(timeGap > MINUTE){
         timeStr = [NSString stringWithFormat:@"%li分钟前",timeGap / MINUTE ];
    }else{ // 1秒钟-59秒钟
        timeStr = @"刚刚";
    }
    return timeStr;
}



@end
