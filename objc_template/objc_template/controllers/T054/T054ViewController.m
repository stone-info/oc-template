//
//  T054ViewController.m
//  objc_template
//
//  Created by stone on 2019-05-06.
//  Copyright © 2019 stone. All rights reserved.
//
#import "T054ViewController.h"

@interface T054ViewController ()
@property (strong, nonatomic) NSDictionary               *options;
@property (strong, nonatomic) NSMutableArray<SNButton *> *buttons;
@property (nonatomic, strong) UIScrollView               *scrollView;
@end

@implementation T054ViewController

- (NSMutableArray<SNButton *> *)buttons {

  if (_buttons == nil) {
    _buttons = [NSMutableArray<SNButton *> array];
  }
  return _buttons;
}

- (NSDictionary *)options {

  if (_options == nil) {
    _options = @{
      @"borderColor"     : HexRGBA(@"#CCCCCC", 1.0),
      @"borderWidth"     : @1,
      @"type"            : @(UIButtonTypeSystem),
      @"font"            : [UIFont fontWithName:@"PingFangSC-Regular" size:14],
      @"backgroundColor" : [UIColor whiteColor],
      @"titleColorNormal": UIColor.blackColor,
      @"masksToBounds"   : @YES,
      @"borderRadius"    : @4.f,
    };
  }
  return _options;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];

  UIScrollView *scrollView = [[UIScrollView alloc] init];
  {
    self.scrollView                         = scrollView;
    scrollView.backgroundColor              = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];

    kMasKey(scrollView);
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.insets(UIEdgeInsetsZero); }];
  }

  [self main];

  // layout
  {
    UIView *contentView = UIView.new;
    contentView.backgroundColor = UIColor.whiteColor;
    [scrollView addSubview:contentView];

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(scrollView);
      make.width.mas_equalTo(scrollView);
    }];

    SNButton *lastView = nil;
    CGFloat  height    = 55;

    for (NSUInteger i = 0; i < self.buttons.count; i++) {
      SNButton *view = self.buttons[i];
      [contentView addSubview:view];

      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView ? lastView.mas_bottom : view.superview).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
        // make.width.mas_equalTo(contentView.mas_width);
        make.height.mas_equalTo(height);
      }];
      lastView = view;
    }

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(lastView.mas_bottom).offset(10);
    }];
  }
}

- (SNButton *)makeButtonWithTitle:(NSString *)title action:(nullable void (^)(SNButton *sender))action {
  NSMutableDictionary *dictionary = self.options.mutableCopy;
  dictionary[@"titleNormal"] = title;

  if (action) { dictionary[@"action"] = action; }

  SNButton *button = [SNButton makeButtonWithOptions:dictionary];
  [self.buttons addObject:button];

  return button;
}

- (void)main {
  // [self demo1];
  // [self demo2];
  NSMutableArray<NSString *> *arrM = [NSMutableArray array];

  Class        cls      = self.class;
  unsigned int count    = 0;
  Method       *pMethod = class_copyMethodList(cls, &count);
  for (int     i        = 0; i < count; i++) {
    Method   pObjc_method = pMethod[i];
    SEL      pSelector    = method_getName(pObjc_method);
    NSString *methodName  = NSStringFromSelector(pSelector);
    if ([methodName hasPrefix:@"demo"]) {
      [arrM addObject:methodName];
    }
  }

  [arrM sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
    return [obj1 localizedCompare:obj2];
  }];

  for (NSUInteger i = 0; i < arrM.count; ++i) {
    NSString *methodName = arrM[i];
    NSLog(@"methodName = %@", methodName);
    [self performSelector:NSSelectorFromString(methodName)];
  }
}

// - (UIColor *)randomColor {
//   CGFloat hue        = (arc4random() % 256 / 256.0);  //  0.0 to 1.0
//   CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from white
//   CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from black
//   return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
// }

- (void)demo1 {
  [self makeButtonWithTitle:@"信号量 不起作用 什么鬼? 只能是代理方法吗?" action:^(SNButton *sender) {
    // 信号量
    // 不起作用 - - , 什么鬼
    RACSignal<RACTuple *> *racSignal = [self rac_signalForSelector:@selector(viewDidAppear:)];
    [racSignal subscribeNext:^(RACTuple *x) {
      NSLog(@"x = %@", x);
      NSLog(@"%s", __func__);
    }];

    [racSignal subscribeError:^(NSError *error) {
      NSLog(@"error = %@", error);
    }];

    [racSignal subscribeCompleted:^{
      NSLog(@"%s", __func__);
    }];
  }];
}

- (void)demo2 {

  SNButton *button = [self makeButtonWithTitle:@"RACCommand 测试" action:nil];

  [button setRac_command:[RACCommand.alloc initWithEnabled:nil signalBlock:^RACSignal *(id input) {
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
      NSLog(@"%s", __func__);
      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [subscriber sendNext:[NSDate.date description]];
        [subscriber sendCompleted];
      });
      return [RACDisposable disposableWithBlock:^{

      }];
    }];
  }]];

  [[[button rac_command] executionSignals] subscribeNext:^(RACSignal *x) {
    [x subscribeNext:^(id _x) {
      NSLog(@"x = %@", _x);
    }];
  }];
}

- (void)demo3 {

  [self makeButtonWithTitle:@"createSignal 测试" action:^(SNButton *sender) {
    // Do any additional setup after loading the view, typically from a nib.
    // 1.创建信号
    RACSignal     *signal     = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
      // 3.发送信号
      [subscriber sendNext:@"ws"];
      // 4.取消信号，如果信号想要被取消，就必须返回一个RACDisposable
      // 信号什么时候被取消：
      // 1.自动取消，当一个信号的订阅者被销毁的时候机会自动取消订阅，
      // 2.手动取消，
      //  block什么时候调用：一旦一个信号被取消订阅就会调用
      //  block作用：当信号被取消时用于清空一些资源
      return [RACDisposable disposableWithBlock:^{ NSLog(@"取消订阅"); }];

    }];
    // 2. 订阅信号
    //  subscribeNext
    // 把nextBlock保存到订阅者里面
    // 只要订阅信号就会返回一个取消订阅信号的类
    RACDisposable *disposable = [signal subscribeNext:^(id x) {
      // block的调用时刻：只要信号内部发出数据就会调用这个block
      NSLog(@"======%@", x);
    }];
    // 取消订阅
    [disposable dispose];

    /**
   *  RACSignal总结：
   一.核心：
      1.核心：信号类
      2.信号类的作用：只要有数据改变就会把数据包装成信号传递出去
      3.只要有数据改变就会有信号发出
      4.数据发出，并不是信号类发出，信号类不能发送数据
   一.使用方法：
      1.创建信号
      2.订阅信号
   二.实现思路：
      1.当一个信号被订阅，创建订阅者，并把nextBlock保存到订阅者里面。
      2.创建的时候会返回 [RACDynamicSignal createSignal:didSubscribe];
      3.调用RACDynamicSignal的didSubscribe
      4.发送信号[subscriber sendNext:value];
      5.拿到订阅者的nextBlock调用
   */

  }];
}

- (void)demo4 {
  [self makeButtonWithTitle:@"createSignal 测试" action:^(SNButton *sender) {
    NSLog(@"%s", __func__);
  }];
}

- (void)demo5 {
  [self makeButtonWithTitle:@"createSignal 测试" action:^(SNButton *sender) {
    NSLog(@"%s", __func__);
  }];
}

@end

