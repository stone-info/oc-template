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

    [self main];

    if ([[UICollectionView class] instancesRespondToSelector:@selector(setPrefetchingEnabled:)]) {
      [[UICollectionView appearance] setPrefetchingEnabled:NO];
    }

    // 批量处理
    UIView *view = [UIView appearance];
    // view.backgroundColor = UIColor.orangeColor;
  }
  return self;
}

- (void)main {
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

  UICollectionView *collectionView = [UICollectionView appearance];
  UITableView      *tableView      = [UITableView appearance];

  [collectionView setPrefetchingEnabled:NO];

  if (@available(iOS 11.0, *)) {
    // 取消自动调整内边距
    collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    tableView.contentInsetAdjustmentBehavior      = UIScrollViewContentInsetAdjustmentNever;
  } else {
    collectionView.viewController.automaticallyAdjustsScrollViewInsets = NO;
    tableView.viewController.automaticallyAdjustsScrollViewInsets      = NO;
  }
}
@end
