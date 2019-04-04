//
//  NSDate+Time.m
//  time_stamp_test
//
//  Created by stone on 16/9/4.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "NSDate+Time.h"

@implementation NSDate (Time)
- (NSString *)toTimeStamp
{
    return [NSString stringWithFormat:@"%lld",(long long)[[NSDate date] timeIntervalSince1970]];
}
+ (NSString *)toTimeStamp:(long long)timeStamp
{
    return [NSString stringWithFormat:@"%lld",timeStamp/1000];
}
@end

@implementation NSString (Time)

- (NSString *)toLocalTime
{
    NSString * time = self;
    
    NSInteger num = [time integerValue]; /// 1000;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    
    //  [formatter setDateStyle:NSDateFormatterMediumStyle];
    //
    //  [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate * confromTimesp = [NSDate dateWithTimeIntervalSince1970:num];
    
    NSString * confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

@end

//sn_note:========= content ============================ stone 🐳 ===========/
NSString *const kDefaultDataFormatString = @"yyyy/MM/dd HH:mm:ss";

@implementation NSDate (TimeStamp)

/** NSDate 转 字符串 */
- (NSString *(^)(NSString *))toString {

  return ^(NSString *dataFormatString) {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = dataFormatString; //@"yyyy/MM/dd HH:mm:ss";
    NSString *string = [dateFormatter stringFromDate:self];
    return string;
  };
}

/** NSDate 转 时间戳 */
- (NSString *)toTimeStamp {
  return [NSString stringWithFormat:@"%lld", (long long) [self timeIntervalSince1970]];
}

@end

@implementation NSString (TimeStamp)
/** 字符串 转 NSDate */
- (NSDate *(^)(NSString *))toDate {

  return ^(NSString *dataFormatString) {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = dataFormatString; //@"yyyy/MM/dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:self];
    return date;
  };
}

/** 字符串 转 时间戳 */
- (NSString *(^)(NSString *))toTimeStamp {
  return ^(NSString *dataFormatString) {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat       = dataFormatString; //@"yyyy/MM/dd HH:mm:ss";
    NSDate *date = [dateFormatter dateFromString:self];
    return [NSString stringWithFormat:@"%lld", (long long) [date timeIntervalSince1970]];
  };
}

/** 时间戳 转 日期字符串 */
- (NSString *(^)(NSString *))toDateString {
  return ^(NSString *dataFormatString) {
    NSInteger num = [self integerValue]; /// 1000;

    NSDateFormatter *dateFormatter = [NSDateFormatter new];

    dateFormatter.dateFormat = dataFormatString; //@"yyyy/MM/dd HH:mm:ss";

    NSDate *fromTimesp = [NSDate dateWithTimeIntervalSince1970:num];

    NSString *dateString = [dateFormatter stringFromDate:fromTimesp];

    return dateString;
  };
}

/** 时间戳 转 NSDate */
- (NSDate *(^)(NSString *))toDateFromTimeStamp {
  return ^(NSString *dataFormatString) {
    NSInteger num = [self integerValue]; /// 1000;

    NSDateFormatter *dateFormatter = [NSDateFormatter new];

    dateFormatter.dateFormat = dataFormatString; //@"yyyy/MM/dd HH:mm:ss";

    NSDate *fromTimesp = [NSDate dateWithTimeIntervalSince1970:num];

    return fromTimesp;
  };
}
@end