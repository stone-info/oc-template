//
//  SNViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNViewController.h"

@interface SNViewController ()

@end

@implementation SNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// info.plist中设置
// <key>UIViewControllerBasedStatusBarAppearance</key>
// <true/>
// 状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
  NSLog(@"%s", __func__);
  return UIStatusBarStyleLightContent;
}

// 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
  // NSLog(@"%s", __func__);
  return NO;
}

@end
