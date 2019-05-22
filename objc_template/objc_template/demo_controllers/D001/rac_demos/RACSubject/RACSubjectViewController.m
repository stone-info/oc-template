//
// Created by stone on 2019-05-11.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <ReactiveObjC/NSObject+RACKVOWrapper.h>
#import "RACSubjectViewController.h"
#import "RACSubjectView.h"

@interface RACSubjectViewController ()
@property (weak, nonatomic) RACSubjectView *mView;
@end

@implementation RACSubjectViewController {}

- (RACSubjectView *)getView {
  RACSubjectView *view = RACSubjectView.new;
  _mView = view;
  [self.view addSubview:view];
  kMasKey(view);
  [view mas_makeConstraints:^(MASConstraintMaker *make) {
    /** button */
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(200);
  }];
  return view;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  [self entry];
}

- (void)injected {
  [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  // [self.views removeAllObjects];
  // self.views = nil;
  [self entry];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"self-send" object:nil userInfo:@{@"username": @"stone"}];
}

- (void)entry {

  UITextField *field = makeTextField(YES);
  [self.view addSubview:field];

  kMasKey(field);
  [field mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  [field.rac_textSignal subscribeNext:^(NSString *x) {
    NSLog(@"x = %@", x);
  }];


}

// 代替通知
- (void)entry5 {
  [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"self-send" object:nil] subscribeNext:^(NSNotification *x) {
    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);
  }];
}

// 监听事件
- (void)entry4 {
  UITextField *field = makeTextField(YES);
  [self.view addSubview:field];

  kMasKey(field);
  [field mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  [[field rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(__kindof UIControl *x) {

    if ([x isKindOfClass:[UITextField class]]) {
      UITextField *uiTextField = (UITextField *) x;
      NSLog(@"uiTextField.text = %@", uiTextField.text);
    }
  }];

}

// 代替kvo
- (void)entry3 {

  // - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  //   CGRect frame = self.mView.frame;
  //   frame.origin.y += 5;
  //   self.mView.frame = frame;
  // }


  RACSubjectView *view = [self getView];

  // 组合1: 初始化时 也传值
  // NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew

  // 组合2: 有新值 才 传值
  // NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew

  // 写法1:
  [view
    rac_observeKeyPath:@"frame"
    options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew
    observer:nil
    block:^(id value, NSDictionary *change, BOOL causedByDealloc, BOOL affectedOnlyLastComponent) {
      STARTLog(@"GROUP START ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■")
      GLog(@"value = %@", value);
      GLog(@"change = %@", change);
      GLog(@"causedByDealloc = %d", causedByDealloc);
      GLog(@"affectedOnlyLastComponent = %d", affectedOnlyLastComponent);
      ENDLog(@"GROUP END ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■")
    }
  ];

  // 创建一个信号来观察给定键路径的值。
  //
  // 初始值在订阅时发送，后续值将被发送
  // 来自发生更改的任何线程，即使它没有有效
  // 调度程序。
  //
  // 返回一个立即发送接收者当前值的信号
  // 给出keypath，然后是任何更改。
  // 写法2:
  [[view rac_valuesForKeyPath:@"frame" observer:nil] subscribeNext:^(id x) {
    ILog(@"x class = %@", SN.getClassName(x));
    ILog(@"x = %@", x);
  }];

}

// 代替代理
- (void)entry2 {

  RACSubjectView *view = [self getView];

  [[view rac_signalForSelector:@selector(btnClicked:)] subscribeNext:^(RACTuple *x) {

    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);
    NSLog(@"RACSubjectView 中的按钮被点击了");
  }];

  [[view rac_signalForSelector:@selector(hello:)] subscribeNext:^(RACTuple *x) {

    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);
  }];
}

- (void)entry1 {

  RACSubjectView *view = [self getView];

  [view.buttonClickSignal subscribeNext:^(id x) {
    // NSLog(@"接收到 x = %@", x);
    NSLog(@"接收到 x = %@", x);

    if ([x isKindOfClass:[UIColor class]]) {
      UIColor *color = (UIColor *) x;
      view.backgroundColor = color;
    }
  }];
}

@end