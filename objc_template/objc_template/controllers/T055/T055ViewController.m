//
//  T055ViewController.m
//  objc_template
//
//  Created by stone on 2019-05-06.
//  Copyright © 2019 stone. All rights reserved.
//
#import "T055ViewController.h"

@interface T055ViewController ()
@property (strong, nonatomic) NSDictionary               *options;
@property (strong, nonatomic) NSMutableArray<SNButton *> *buttons;
@property (nonatomic, strong) UIScrollView               *scrollView;
@end

@implementation T055ViewController

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
    // NSLog(@"methodName = %@", methodName);
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

@end
