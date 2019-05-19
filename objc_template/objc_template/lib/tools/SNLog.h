//
//  SNLog.h
//  objc_template
//
//  Created by stone on 2019/5/2.
//  Copyright © 2019 stone. All rights reserved.
//

#ifndef SNLog_h
#define SNLog_h

#define XCODE_CONSOLA 0

#if XCODE_CONSOLA
//                              /* log */
/************************************************************************************/
#define LOG_TIME [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String
#define LOG_FILE [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String
#define NSLOG_TEMPLATE "<%s %s:%d>-:▼\n %s \n--------------------------------------------------------------------------------------------------\n"
#define SUCCESS_TEMPLATE "<%s %s:%d>-:▼\n %s \n--------------------------------------------------------------------------------------------------\n"
#define ERROR_TEMPLATE "<%s %s:%d>-:▼\n %s \n--------------------------------------------------------------------------------------------------\n"
#define WARNING_TEMPLATE "<%s %s:%d>-:▼\n %s \n--------------------------------------------------------------------------------------------------\n"
#define INFO_TEMPLATE "<%s %s:%d>-:▼\n %s \n--------------------------------------------------------------------------------------------------\n"
#define BORDER_TEMPLATE "<%s %s:%d>-: %s\n"

#ifdef DEBUG
// #define NSLog(FORMAT, ...) do {fprintf(stderr, "<%s %s:%d>-:%s\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define NSLog(FORMAT, ...) do {printf("<%s %s:%d>-:▼\n%s\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);

#define NSLog(FORMAT, ...) do {printf(NSLOG_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
#define SLog(FORMAT, ...) do {printf(SUCCESS_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
#define ELog(FORMAT, ...) do {printf(ERROR_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
#define WLog(FORMAT, ...) do {printf(WARNING_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
#define ILog(FORMAT, ...) do {printf(INFO_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
#define KLog(FORMAT, ...) do {printf(BORDER_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);

// #define NSLog(FORMAT, ...) do {printf("<%s %s:%d>-:▼\n\033[1;7;48m %s \033[0m\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define RLog(FORMAT, ...) do {printf("<%s %s:%d>-:▼\n\033[1;97;41m %s \033[0m\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define GLog(FORMAT, ...) do {printf("<%s %s:%d>-:▼\n\033[1;97;42m %s \033[0m\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define BLog(FORMAT, ...) do {printf("<%s %s:%d>-:▼\n\033[1;44;97m %s \033[0m\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define DLog(FORMAT, ...) do {printf("<%s %s:%d>-:▼\n\033[1;0;0m %s \033[0m\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define KLog(FORMAT, ...) do {printf("<%s %s:%d>-: %s\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define DLog(FORMAT, ...) do {fprintf(stderr,"\n<%s %s:%d>-:%s\n\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
#else

#define NSLog
#define SLog
#define ELog
#define WLog
#define ILog
#define KLog
// #define RLog
// #define GLog
// #define BLog
// #define DLog
#endif

#else
//                              /* log */
/************************************************************************************/
#define LOG_TIME [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String
#define LOG_FILE [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String
#define NSLOG_TEMPLATE "<%s %s:%d>-:▼\n\033[1;7;48m %s \033[0m\n--------------------------------------------------------------------------------------------------\n"
#define SUCCESS_TEMPLATE "<%s %s:%d>-:▼\n\033[1;97;42m %s \033[0m\n--------------------------------------------------------------------------------------------------\n"
#define ERROR_TEMPLATE "<%s %s:%d>-:▼\n\033[1;97;41m %s \033[0m\n--------------------------------------------------------------------------------------------------\n"
#define WARNING_TEMPLATE "<%s %s:%d>-:▼\n\033[1;97;43m %s \033[0m\n--------------------------------------------------------------------------------------------------\n"
#define INFO_TEMPLATE "<%s %s:%d>-:▼\n\033[1;97;46m %s \033[0m\n--------------------------------------------------------------------------------------------------\n"
#define BORDER_TEMPLATE "<%s %s:%d>-: %s\n"

#ifdef DEBUG
// #define NSLog(FORMAT, ...) do {fprintf(stderr, "<%s %s:%d>-:%s\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define NSLog(FORMAT, ...) do {printf("<%s %s:%d>-:▼\n%s\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);

#define NSLog(FORMAT, ...) do {printf(NSLOG_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
#define SLog(FORMAT, ...) do {printf(SUCCESS_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
#define ELog(FORMAT, ...) do {printf(ERROR_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
#define WLog(FORMAT, ...) do {printf(WARNING_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
#define ILog(FORMAT, ...) do {printf(INFO_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
#define KLog(FORMAT, ...) do {printf(BORDER_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);

// #define NSLog(FORMAT, ...) do {printf("<%s %s:%d>-:▼\n\033[1;7;48m %s \033[0m\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define RLog(FORMAT, ...) do {printf("<%s %s:%d>-:▼\n\033[1;97;41m %s \033[0m\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define GLog(FORMAT, ...) do {printf("<%s %s:%d>-:▼\n\033[1;97;42m %s \033[0m\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define BLog(FORMAT, ...) do {printf("<%s %s:%d>-:▼\n\033[1;44;97m %s \033[0m\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define DLog(FORMAT, ...) do {printf("<%s %s:%d>-:▼\n\033[1;0;0m %s \033[0m\n--------------------------------------------------------------------------------------------------\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define KLog(FORMAT, ...) do {printf("<%s %s:%d>-: %s\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define DLog(FORMAT, ...) do {fprintf(stderr,"\n<%s %s:%d>-:%s\n\n", [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String, [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);

//                              /* #toast */
/************************************************************************************/
// #define kToast(containerView, content) { \
// //   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:containerView animated:YES]; \
// //   hud.mode       = MBProgressHUDModeText;\
// //   hud.label.text = content;\
// //   hud.label.font = kPingFangSCRegular(14);\
// //   hud.label.numberOfLines   = 0;\
// //   hud.offset     = CGPointMake(0.f, MBProgressMaxOffset);\
// //   [hud hideAnimated:YES afterDelay:3.f];\
// // }

#define kToast(kContainerView, content) { \
UIView * containerView;\
if(containerView == nil){\
  containerView = [UIApplication sharedApplication].keyWindow;\
}else{\
  containerView = kContainerView;\
}\
NSString *text          = content;\
UIFont   *font          = kPingFangSCRegular(14);\
CGFloat singLineHeight  = [@"single" stringHeightWithMaxWidth:containerView.bounds.size.width - 46.5 font:font];\
CGFloat h               = [text stringHeightWithMaxWidth:containerView.bounds.size.width - 46.5 font:font];\
MBProgressHUD *hud      = [MBProgressHUD showHUDAddedTo:containerView animated:YES];\
hud.mode                = MBProgressHUDModeText;\
hud.label.text          = text;\
hud.label.font          = font;\
if (h > singLineHeight) {\
hud.label.textAlignment = NSTextAlignmentLeft;\
} else {\
hud.label.textAlignment = NSTextAlignmentCenter;\
}\
hud.label.numberOfLines = 0;\
hud.offset              = CGPointMake(0.f, MBProgressMaxOffset);\
[hud hideAnimated:YES afterDelay:3.f];\
}

#else

#define NSLog
#define SLog
#define ELog
#define WLog
#define ILog
#define KLog
// #define RLog
// #define GLog
// #define BLog
// #define DLog

#define kToast(kContainerView, content)

#endif

#endif

#define NSLogRect(rect) NSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define NSLogSize(size) NSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define NSLogPoint(point) NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)
#define NSLogEdgeInsets(edgeInsets) NSLog(@"%s top:%.4f, right:%.4f, bottom:%.4f, left:%.4f", #edgeInsets, edgeInsets.top, edgeInsets.right,edgeInsets.bottom,edgeInsets.left)

#endif /* SNLog_h */
