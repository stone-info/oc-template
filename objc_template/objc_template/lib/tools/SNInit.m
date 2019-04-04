//
//  SNInit.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNInit.h"

@implementation SNInit

- (instancetype)init {
  self = [super init];
  if (self) {

    UIApplication *application = [UIApplication sharedApplication];
    // the application may not present any UI upon a notification being received
    // 收到通知时，应用程序不得显示任何UI。
    //     UIUserNotificationTypeNone    = 0,

    // the application may badge its icon upon a notification being received
    // 申请可在收到通知时标记其图标。
    //     UIUserNotificationTypeBadge   = 1 << 0,
    // the application may play a sound upon a notification being received
    // 申请可在接获通知后播放声音。
    //     UIUserNotificationTypeSound   = 1 << 1,
    // the application may display an alert upon a notification being received
    // 申请可在收到通知时显示警报。
    //     UIUserNotificationTypeAlert   = 1 << 2,
    UIUserNotificationSettings *settings = [UIUserNotificationSettings
      settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert
      categories:nil];

    [application registerUserNotificationSettings:settings];

  }
  return self;
}
@end
