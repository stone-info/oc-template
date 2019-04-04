//
//  SNTabBarController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNTabBarController.h"
#import "SNNavigationController.h"
#import "ViewController.h"

static const UITabBarSystemItem tabBarSystemItems[5] = {
  UITabBarSystemItemFavorites,
  UITabBarSystemItemSearch,
  UITabBarSystemItemHistory,
  UITabBarSystemItemDownloads,
  UITabBarSystemItemMore
};

@interface SNTabBarController ()
@property (strong, nonatomic) NSArray *dataList;
@end

@implementation SNTabBarController
- (NSArray *)dataList {

  /** _dataList lazy load */

  if (_dataList == nil) {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    _dataList = [NSArray arrayWithContentsOfFile:bundlePath];
  }
  return _dataList;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  /** 根据storyboard 获取 viewController */
  // UIViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
  /** 根据xib 获取 viewController */
  // SNViewController *viewController = [[SNViewController alloc] initWithNibName:NSStringFromClass([SNViewController class]) bundle:nil];

  {
    SNNavigationController *navigationController = [[SNNavigationController alloc] initWithRootViewController:ViewController.new];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:tabBarSystemItems[0] tag:0];
    item.badgeValue                 = kStringFormat(@"%ld", self.dataList.count);
    navigationController.tabBarItem = item;
    [self addChildViewController:navigationController];
  }
  {
    SNNavigationController *navigationController = [[SNNavigationController alloc] initWithRootViewController:UIViewController.new];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:tabBarSystemItems[1] tag:1];
    // item.badgeValue                 = kStringFormat(@"%ld", self.dataList.count);
    navigationController.tabBarItem = item;
    [self addChildViewController:navigationController];
  }
  {
    SNNavigationController *navigationController = [[SNNavigationController alloc] initWithRootViewController:UIViewController.new];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:tabBarSystemItems[2] tag:2];
    // item.badgeValue                 = kStringFormat(@"%ld", self.dataList.count);
    navigationController.tabBarItem = item;
    [self addChildViewController:navigationController];
  }
  {
    SNNavigationController *navigationController = [[SNNavigationController alloc] initWithRootViewController:UIViewController.new];
    UITabBarItem *item = [[UITabBarItem alloc] initWithTabBarSystemItem:tabBarSystemItems[3] tag:3];
    // item.badgeValue                 = kStringFormat(@"%ld", self.dataList.count);
    navigationController.tabBarItem = item;
    [self addChildViewController:navigationController];
  }

}

- (__kindof UIViewController *)viewControllerWithClassName:(NSString *)className {
  // __kindof UIViewController *viewController = [(__kindof UIViewController *) [NSClassFromString(className) alloc] initWithNibName:className
  //                                                                                                                          bundle:nil];
  // 有nib 加载nib, 没有nib 使用 普通创建
  // iOS 9.0 之前 先找同名的 view, 就是 UIViewController 找 UIView.xib
  // iOS 9.0 之后 先找同名的 view, 就是 UIViewController 找 UIViewController.xib
  __kindof UIViewController *viewController = [(__kindof UIViewController *) [NSClassFromString(className) alloc] init];

  return viewController;
}

@end
