//
//  T027ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T027ViewController.h"
#import "SNButton.h"

// 对于OC中的类来说，在runtime中会有两个方法被调用：
//
// +load
// +initialize
//
// 这两个方法看起来都是在类初始的时候调用的，但其实还是有一些异同，从而可以用来做一些行为。
//
// +load
// 首先，load方法是一定会在runtime中被调用的，只要类被添加到runtime中了，就会调用load方法，所以我们可以自己实现laod方法来在这个时候执行一些行为。
//
// 而且有意思的一点是，load方法不会覆盖。也就是说，如果子类实现了load方法，那么会先调用父类的load方法，然后又去执行子类的load方法。
// 同样的，如果分类实现了load方法，也会先执行主类的load方法，然后又会去执行分类的load方法。
// 所以父类的load会执行很多次，这一点需要注意。而且执行顺序是 类 -> 子类 ->分类。而不同类之间的顺序不一定。
//
// +initialize
// 与load不同的是，initialize方法不一定会执行。
// 只有当一个类第一次被发送消息的时候会执行，注意是第一次。
// 什么叫发送消息呢，就是执行类的一些方法的时候。也就是说这个方法是懒加载，没有用到这个类就不会调用，可以节省系统资源。
//
// 还有一点截然相反，却更符合我们预期的就是，initialize方法会覆盖。
// 也就是说如果子类实现了initialize方法，就不会执行父类的了，直接执行子类本身的。
// 如果分类实现了initialize方法，也不会再执行主类的。
// 所以initialize方法的执行覆盖顺序是 分类 -> 子类 ->类。
// 且只会有一个initialize方法被执行。
static SNSingleton *_singleton = nil;

@implementation SNSingleton

+ (void)load {
  // NSLog(@"%s", __func__);
  SNSingleton *singleton = [[SNSingleton alloc] init];
  _singleton = singleton;
}

+ (instancetype)sharedInstance {
  if (_singleton) {
    return _singleton;
  } else {
    SNSingleton *singleton = [[SNSingleton alloc] init];
    _singleton = singleton;
    return _singleton;
  }
}

+ (instancetype)alloc {
  // There can only be one SNSingleton instance.
  if (_singleton) {
    NSException *exception = [NSException exceptionWithName:@"NSInternalInconsistencyException"
                                          reason:@"There can only be one SNSingleton instance."
                                          userInfo:nil];
    // 抛出异常...
    [exception raise];
  }

  return [super alloc];
}

@end

//sn_note:=========  ============================ stone 🐳 ===========/
// iOS 关键字const/static/extern、UIKIT_EXTERN区别和用法
// https://www.jianshu.com/p/89656ccfe464

static NSString *hello = @"你好吗 世界";

@interface T027ViewController ()

@end

@implementation T027ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.view.backgroundColor = UIColor.blackColor;
  // [self setNeedsStatusBarAppearanceUpdate];
  // [self demo1];
  // [self demo2];
  [self demo3];

  NSLog(@"%s", __func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  /* 静态局部变量*/
  static NSInteger count = 0;
  NSLog(@"count = %li", count);
  count++;

  UIApplication *application = [UIApplication sharedApplication];
  [application setStatusBarHidden:!application.statusBarHidden animated:YES];
}

- (void)demo3 {
  NSMutableDictionary *options = @{
    @"type"                 : @(UIButtonTypeSystem),
    @"backgroundColor"      : [UIColor whiteColor],
    @"titleNormal"          : @"打电话",
    @"titleColorNormal"     : UIColor.blackColor,
    // @"titleHighlighted"     : @"highlighted",
    @"titleColorHighlighted": HexRGBA(@"#FFC1C1", 1.0),
    @"font"                 : [UIFont fontWithName:@"PingFangSC-Regular" size:16],
    @"borderColor"          : HexRGBA(@"#cccccc", 1.0),
    @"borderWidth"          : @1.0,
    @"masksToBounds"        : @YES,
    @"borderRadius"         : @4.f,

    @"action"               : ^void(SNButton *sender) {
      NSLog(@"hello world");
    },
  }.mutableCopy;

  NSLog(@"options = %@", (options[@"title"] = @"hello"));

  options[@"titleNormal"] = @"打电话";
  SNButton *button1 = [SNButton makeButtonWithOptions:options];
  options[@"titleNormal"] = @"发短信";
  SNButton *button2 = [SNButton makeButtonWithOptions:options];
  options[@"titleNormal"] = @"发邮件";
  SNButton *button3 = [SNButton makeButtonWithOptions:options];
  options[@"titleNormal"] = @"打开一个网页资源";
  SNButton *button4 = [SNButton makeButtonWithOptions:options];

  button1.frame = CGRectMake(10, kStatusBarHeight + kNavigationBarHeight + 10, 300, 40);
  button2.frame = CGRectMake(10, button1.bottom + 10, 300, 40);
  button3.frame = CGRectMake(10, button2.bottom + 10, 300, 40);
  button4.frame = CGRectMake(10, button3.bottom + 10, 300, 40);

  [self.view addSubview:button1];
  [self.view addSubview:button2];
  [self.view addSubview:button3];
  [self.view addSubview:button4];

  button1.action = ^void(SNButton *sender) {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL         *url         = [NSURL URLWithString:@"tel://10086"];
    [application openURL:url];
  };
  button2.action = ^void(SNButton *sender) {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL         *url         = [NSURL URLWithString:@"sms://10086"];
    [application openURL:url];
  };
  button3.action = ^void(SNButton *sender) {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL         *url         = [NSURL URLWithString:@"mailto://blueone009@163.com"];
    [application openURL:url];
  };
  button4.action = ^void(SNButton *sender) {
    UIApplication *application = [UIApplication sharedApplication];
    NSURL         *url         = [NSURL URLWithString:@"http://www.baidu.com"];
    [application openURL:url];
  };

}

- (void)demo2 {
  UIApplication *application = [UIApplication sharedApplication];
  // 还有多少条消息未读的图标
  application.applicationIconBadgeNumber      = 10;
  // 联网状态 转菊花
  application.networkActivityIndicatorVisible = NO;

  // // <key>UIViewControllerBasedStatusBarAppearance</key>
  // // <false/>
  application.statusBarHidden = NO;
  application.statusBarStyle  = UIStatusBarStyleLightContent;

  // self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
  // self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
}

- (void)demo1 {
  SNSingleton *singleton1 = [SNSingleton sharedInstance];
  SNSingleton *singleton2 = [SNSingleton sharedInstance];
  [[SNSingleton alloc] init];
  NSLog(@"singleton1 = %@", singleton1);
  NSLog(@"singleton1 = %@", singleton2);
}

- (void)injected {
  NSLog(@"%s", __func__);
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
    
    
    