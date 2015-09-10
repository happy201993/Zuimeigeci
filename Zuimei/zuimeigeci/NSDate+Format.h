//
//  NSDate+Format.h
//  WeiBo
//
//  Created by 杨少伟 on 15/8/24.
//  Copyright (c) 2015年 YCompany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Format)

+ (NSString *)dateStringWithDate:(NSDate *)date withFormatter:(NSString *)formatter;
+ (NSDate *)dateWithDateString:(NSString *)dateString withFormatter:(NSString *)formatter;

+ (NSString *)dateStringWithZMDate:(NSDate *)date;
@end
