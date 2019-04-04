//
//  SNNavigationController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNNavigationController.h"
#import "UINavigationBar+NavgationBarExtension.h"
#import "SNNavigationBar.h"

static UIColor *navigationBarBackgroundColor = nil;

@interface SNNavigationController () <UINavigationControllerDelegate, UINavigationBarDelegate>

@end

#define NAVIGATION_HEIGHT (CGRectGetHeight([[UIApplication sharedApplication] statusBarFrame]) + CGRectGetHeight(self.navigationController.navigationBar.frame))

@implementation SNNavigationController

+ (void)load {
  navigationBarBackgroundColor = HexRGBA(0xCCCCCC, 1.0);
  // UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];

  // 只要是通过模型设置,都是通过富文本设置
  // 设置导航条标题 => UINavigationBar
  // NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
  // attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
  // [navBar setTitleTextAttributes:attrs];
  //
  // 设置导航条背景图片
  // [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

+ (UIBarButtonItem *)backItemWithimage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title {

  UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];

  [backButton setTitle:title forState:UIControlStateNormal];

  // [backButton setImage:image forState:UIControlStateNormal];

  // [backButton setImage:highImage forState:UIControlStateHighlighted];

  [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

  [backButton setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];

  // [backButton sizeToFit];

  // backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);

  [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];

  return [[UIBarButtonItem alloc] initWithCustomView:backButton];


  // [self. setBackBarButtonItem:itemBarButton];



}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.delegate = self;

  [self setValue:SNNavigationBar.new forKey:@"navigationBar"];
  //   self.navigationBar.frame = CGRectMake(0, 0, kScreenWidth, NAVIGATION_HEIGHT);
  //
  // #ifdef __IPHONE_11_0
  //
  //   if (@available(iOS 11.0, *)) {
  //
  //     self.navigationBar.frame = CGRectMake(0, 20, kScreenWidth, NAVIGATION_HEIGHT);
  //
  //   }
  //
  // #endif


  // UIBarMetricsDefault, 设置导航背景 必须得要使用默认的模式 UIBarMetricsDefault
  // UIBarMetricsCompact, 透明的效果...


  [self.navigationBar setBackgroundImage:sn.imageWithColor(navigationBarBackgroundColor) forBarMetrics:UIBarMetricsDefault];
  [self.navigationBar setShadowImage:[[UIImage alloc] init]];

}

// https://stackoverflow.com/questions/47837959/updating-the-status-bar-style-between-view-controllers/47838649#47838649
- (UIStatusBarStyle)preferredStatusBarStyle {
  return self.topViewController.preferredStatusBarStyle ? self.topViewController.preferredStatusBarStyle : UIStatusBarStyleDefault;
}

#pragma mark - <UINavigationControllerDelegate>

// Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {

  // NSLog(@"self.viewControllers.count = %lu", self.viewControllers.count);
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {

  viewController.hidesBottomBarWhenPushed = self.viewControllers.count > 0;

  if (self.childViewControllers.count > 0) {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:nil action:NULL];
    [self.navigationBar.topItem setBackBarButtonItem:item];
  } else {
    [self.navigationBar setBackgroundImage:sn.imageWithColor(navigationBarBackgroundColor) forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:[[UIImage alloc] init]];
  }
  [super pushViewController:viewController animated:animated];
}

- (nullable UIViewController *)popViewControllerAnimated:(BOOL)animated {
  UIViewController *controller = [super popViewControllerAnimated:animated];

  NSLog(@"controller = %@", controller);
  [self.navigationBar setBackgroundImage:sn.imageWithColor(navigationBarBackgroundColor) forBarMetrics:UIBarMetricsDefault];
  [self.navigationBar setShadowImage:[[UIImage alloc] init]];

  return controller;
}

// - (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController {
//
//   // return UIInterfaceOrientationMaskPortrait;
//   // return UIInterfaceOrientationMaskLandscapeLeft;
//   // return UIInterfaceOrientationMaskLandscapeRight;
//   // return UIInterfaceOrientationMaskPortraitUpsideDown;
//   // return UIInterfaceOrientationMaskLandscape;
//   // return UIInterfaceOrientationMaskAll;
//   return UIInterfaceOrientationMaskAllButUpsideDown;
// }
//
// - (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController {
//   // return UIInterfaceOrientationUnknown;
//   // return UIInterfaceOrientationPortrait;
//   // return UIInterfaceOrientationPortraitUpsideDown;
//   // return UIInterfaceOrientationLandscapeLeft;
//   // return UIInterfaceOrientationLandscapeRight;
// }
//
// - (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
//                                    interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController {
//
// }
//
// - (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
//                                             animationControllerForOperation:(UINavigationControllerOperation)operation
//                                                          fromViewController:(UIViewController *)fromVC
//                                                            toViewController:(UIViewController *)toVC {
//
// }

@end
