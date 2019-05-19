//
//  SNTabBarController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNTabBarController.h"
#import "SNNavigationController.h"
#import "LRQViewController.h"
#import "DemoViewController.h"
#import "StoneViewController.h"

static const UITabBarSystemItem tabBarSystemItems[5] = {
  UITabBarSystemItemFavorites,
  UITabBarSystemItemSearch,
  UITabBarSystemItemHistory,
  UITabBarSystemItemDownloads,
  UITabBarSystemItemMore
};

@interface SNTabBarController ()
@property (strong, nonatomic) NSArray *dataList;
@property (strong, nonatomic) NSArray *lrq_dataList;
@property (strong, nonatomic) NSArray *demo_dataList;
@end

@implementation SNTabBarController
- (NSArray *)dataList {

  if (_dataList == nil) {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
    _dataList = [NSArray arrayWithContentsOfFile:bundlePath];
  }
  return _dataList;
}

- (NSArray *)lrq_dataList {

  if (_lrq_dataList == nil) {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"lrq_data" ofType:@"plist"];
    _lrq_dataList = [NSArray arrayWithContentsOfFile:bundlePath];

  }
  return _lrq_dataList;
}

- (NSArray *)demo_dataList {

  if (_demo_dataList == nil) {
    _demo_dataList = [NSArray new];
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"demo_data" ofType:@"plist"];
    _demo_dataList = [NSArray arrayWithContentsOfFile:bundlePath];
  }
  return _demo_dataList;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  /** 根据storyboard 获取 viewController */
  // UIViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
  /** 根据xib 获取 viewController */
  // SNViewController *viewController = [[SNViewController alloc] initWithNibName:NSStringFromClass([SNViewController class]) bundle:nil];

  {
    SNNavigationController *navigationController = [[SNNavigationController alloc] initWithRootViewController:StoneViewController.new];
    UITabBarItem           *item                 = [[UITabBarItem alloc] initWithTabBarSystemItem:tabBarSystemItems[0] tag:0];
    item.badgeValue                 = kStringFormat(@"%ld", self.dataList.count);
    navigationController.tabBarItem = item;
    [self addChildViewController:navigationController];
  }
  {
    SNNavigationController *navigationController = [[SNNavigationController alloc] initWithRootViewController:LRQViewController.new];
    UITabBarItem           *item                 = [[UITabBarItem alloc] initWithTabBarSystemItem:tabBarSystemItems[1] tag:1];
    item.badgeValue                              = kStringFormat(@"%ld", self.lrq_dataList.count);
    navigationController.tabBarItem              = item;
    [self addChildViewController:navigationController];
  }

  {
    SNNavigationController *navigationController = [[SNNavigationController alloc] initWithRootViewController:DemoViewController.new];
    UITabBarItem           *item                 = [[UITabBarItem alloc] initWithTabBarSystemItem:tabBarSystemItems[2] tag:2];
    item.badgeValue                 = kStringFormat(@"%ld", self.demo_dataList.count);
    navigationController.tabBarItem = item;
    [self addChildViewController:navigationController];
  }
  {
    SNNavigationController *navigationController = [[SNNavigationController alloc] initWithRootViewController:UIViewController.new];
    UITabBarItem           *item                 = [[UITabBarItem alloc] initWithTabBarSystemItem:tabBarSystemItems[3] tag:3];
    // item.badgeValue                 = kStringFormat(@"%ld", self.dataList.count);
    navigationController.tabBarItem              = item;
    [self addChildViewController:navigationController];
  }

  self.selectedIndex = 0; // stone
  // self.selectedIndex = 1; // lrq
  // self.selectedIndex = 2; // demos

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
