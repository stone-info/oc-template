//
//  NSDate+Time.h
//  time_stamp_test
//
//  Created by stone on 16/9/4.
//  Copyright © 2016年 stone. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDate (Time)
- (NSString *)toTimeStamp;
+ (NSString *)toTimeStamp:(long long)timeStamp;
@end

@interface NSString (Time)
- (NSString *)toLocalTime;
@end

UIKIT_EXTERN NSString * const kDefaultDataFormatString;


@interface NSDate (TimeStamp)
/** example: currentDate.toString(@"yyyy/MM/dd HH:mm:ss") */
- (NSString * (^)(NSString *))toString;
/** NSDate 转 时间戳 */
- (NSString *)toTimeStamp;
@end

@interface NSString (TimeStamp)
/** example: dateString.toDate(@"yyyy/MM/dd HH:mm:ss"); */
- (NSDate * (^)(NSString *))toDate;
/** 字符串date 转 时间戳 */
/** example: string = dateString.toTimeStamp(@"yyyy/MM/dd HH:mm:ss"); */
- (NSString * (^)(NSString *))toTimeStamp;

/** 时间戳 转 日期字符串 */
- (NSString * (^)(NSString *))toDateString;
/** 时间戳 转 NSDate */
- (NSDate * (^)(NSString *))toDateFromTimeStamp;
@end

@interface NSDateFormatter (TimeStamp)

@end
