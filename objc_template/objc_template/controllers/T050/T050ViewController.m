//
//  T050ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//


// // zelog
//   // [1;91;49m xx [0m => hello world
//   // zslog
//   // [1;32;49m xx [0m => hello world
//   // zwlog
//   // [1;33;49m xx [0m => hello world
//   // 特殊 深蓝
//   // [1;34;49m xx [0m => hello world
//   // 特殊 天蓝
//   // [1;36;49m xx [0m => hello world
//   // 特殊 亮红
//   // [1;91;49m xx [0m => hello world
//   // 特殊 紫色
//   // [1;94;49m xx [0m => hello world
//   // 普通 加粗
//   // [1;39;49m xx [0m => hello world
//   // 普通 深灰
//   // [1;90;49m xx [0m => hello world
//
//   // 有背景色 , 前景色 白色
//   // [1;97;40m xx [0m => hello world
//   // [1;97;41m xx [0m => hello world
//   // [1;97;42m xx [0m => hello world
//   // [1;97;43m xx [0m => hello world
//   // [1;97;44m xx [0m => hello world
//   // [1;97;45m xx [0m => hello world
//   // [1;97;46m xx [0m => hello world
//   // [1;97;47m xx [0m => hello world
//
//   // [1;97;100m xx [0m => hello world
//   // [1;97;101m xx [0m => hello world
//   // [1;97;102m xx [0m => hello world
//   // [1;97;103m xx [0m => hello world
//   // [1;97;104m xx [0m => hello world
//   // [1;97;105m xx [0m => hello world
//
//   let key = c
//   switch key {
//     case 0:
//       a = "1;7;48"
//       // a = "1;97;100"
//     case 1: // succeed
//       a = "1;97;42"
//     case 2: // error
//       a = "1;97;41"
//     case 3: // warning
//       a = "1;97;43"
//     case 4: // info
//       a = "1;97;46"
//     case 5: // 加粗, 白色 , 深蓝
//       a = "1;97;44"
//     case 6: // 加粗, 白色 , 暗粉红
//       a = "1;97;45"
//     case 7: // 加粗, 白色 , 亮红
//       a = "1;97;101"
//     case 8: // 加粗, 白色 , 亮紫色
//       a = "1;97;104"
//     case 9: // 加粗, 白色 , 亮粉红
//       a = "1;97;105"
//     case 10: // 加粗, 无前景色, 无背景色
//       a = "1;0;0"
//     case 11:
//       a = "1;97;41"   // error
//     default:
//       a = "1;7;48"    // 黑色
//   }

// #define LOG_TIME [[NSDate.date dateByAddingTimeInterval:[NSTimeZone.systemTimeZone secondsFromGMTForDate:NSDate.date]].description substringWithRange:NSMakeRange(11, 8)].UTF8String
// #define LOG_FILE [NSString stringWithUTF8String:__FILE__].lastPathComponent.UTF8String
// #define NSLOG_TEMPLATE "<%s %s:%d>-:▼\n\033[1;7;48m %s \033[0m\n--------------------------------------------------------------------------------------------------\n"
// #define SUCCESS_TEMPLATE "<%s %s:%d>-:▼\n\033[1;97;42m %s \033[0m\n--------------------------------------------------------------------------------------------------\n"
// #define ERROR_TEMPLATE "<%s %s:%d>-:▼\n\033[1;97;41m %s \033[0m\n--------------------------------------------------------------------------------------------------\n"
// #define WARNING_TEMPLATE "<%s %s:%d>-:▼\n\033[1;97;43m %s \033[0m\n--------------------------------------------------------------------------------------------------\n"
// #define INFO_TEMPLATE "<%s %s:%d>-:▼\n\033[1;97;46m %s \033[0m\n--------------------------------------------------------------------------------------------------\n"
// #define NSLog(FORMAT, ...) do {printf(NSLOG_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define SLog(FORMAT, ...) do {printf(SUCCESS_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define ELog(FORMAT, ...) do {printf(ERROR_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define WLog(FORMAT, ...) do {printf(WARNING_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);
// #define ILog(FORMAT, ...) do {printf(INFO_TEMPLATE, LOG_TIME, LOG_FILE, __LINE__, [NSString stringWithFormat:FORMAT, ##__VA_ARGS__].UTF8String);} while (0);

#import "T050ViewController.h"

@interface T050ViewController ()

@end

@implementation T050ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  NSLog(@"hello world");
  SLog(@"hello world");
  ELog(@"hello world");
  WLog(@"hello world");
  ILog(@"hello world");

}

- (void)injected {

}

@end
    