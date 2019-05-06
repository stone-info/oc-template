//
//  AppDelegate.m
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "SNWindow.h"
#import "SNInit.h"
#import "SNNavigationController.h"
#import "SNTabBarController.h"
#import <SDWebImage/SDWebImageManager.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  // [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection10.bundle"] load];
  [[NSBundle bundleWithPath:@"/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle"] load];
  // init data
  [SNConst new];
  [SNInit new];

  kAutoPush = YES;

  // key board
  {
    // 控制自动键盘功能启用与否
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable                     = YES;
    // 键盘弹出时，点击背景，键盘收回
    manager.shouldResignOnTouchOutside = YES;
    // 隐藏键盘上面的toolBar,默认是开启的
    manager.enableAutoToolbar          = NO;

    // 如果某一个文本框确实不需要键盘上面的toolBar
    // textField.inputAccessoryView = [[UIView alloc] init];

    // 如果某个页面不想让键盘弹出
    //
    // - (void) viewWillAppear: (BOOL)animated {
    //
    //   //关闭自动键盘功能
    //   [IQKeyboardManager sharedManager].enable = NO;
    //
    // }
    // - (void) viewWillDisappear: (BOOL)animated {
    //
    //   //开启自动键盘功能
    //   [IQKeyboardManager sharedManager].enable = YES;
    //
    // }
  }

  //====================================/

  if (@available(iOS 11.0, *)) {
    // 影响太大了, 还是在各个控制器自己设置吧 , 相册都不会自动缩进了...
    // [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
  }

  // 获取info字典
  NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
  NSString * mUIMainStoryboardFile = infoDictionary[@"UIMainStoryboardFile"];

  // NSLog(@"Main.storyboard is %@", mUIMainStoryboardFile);

  if (mUIMainStoryboardFile) {
    // Storyboar 有main
    return YES;

  } else {
    /** 创建 Window */
    self.window = [[SNWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SNTabBarController *tabBarController = [[SNTabBarController alloc] init];
    /** 设置根控制器 */
    [self.window setRootViewController:tabBarController];
    /** 延迟显示启动界面, 优点: 能多看会 LOGO */
    //  [NSThread sleepForTimeInterval:2.0];
    /** 显示window */
    [self.window makeKeyAndVisible];

    return YES;
  }
}

// app 将要失去焦点时调用
- (void)applicationWillResignActive:(UIApplication *)application {
  NSLog(@"%s", __func__);
}

// app 进入后台时调用
- (void)applicationDidEnterBackground:(UIApplication *)application {
  NSLog(@"%s", __func__);
}

// app 进入前台时调用
- (void)applicationWillEnterForeground:(UIApplication *)application {
  NSLog(@"%s", __func__);
}

// app 获取焦点时调用 (能否与用户进行交互, 就是用户能点击界面了)
- (void)applicationDidBecomeActive:(UIApplication *)application {
  // NSLog(@"%s", __func__);
}

// app 退出时调用
- (void)applicationWillTerminate:(UIApplication *)application {
  NSLog(@"%s", __func__);
}

// app 收到内存警告时调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
  NSLog(@"%s", __func__);

  // 1.清空缓存
  // clearDisk:直接删除, 然后重新创建
  // cleanDisk:清楚过期缓存, 计算当前缓存的大小, 和设置的最大缓存数量比较, 如果超出那么会继续删除(按照文件的黄建的先后顺序)
  // 过期7天
  [[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:nil];

  // 取消当前所有的操作...
  [[SDWebImageManager sharedManager] cancelAll];
}

@end
