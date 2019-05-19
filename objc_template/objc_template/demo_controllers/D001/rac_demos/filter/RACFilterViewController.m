//
//  RACFilterViewController.m
//  objc_template
//
//  Created by stone on 2019/5/12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "RACFilterViewController.h"

@interface RACFilterViewController ()

@end

@implementation RACFilterViewController

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

}

// skip : 跳跃几个值
- (void)entry {

  RACSubject *subject = [RACSubject subject];

  [[subject skip:2] subscribeNext:^(id x) {
    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);
  }];

  [subject sendNext:@"1"];
  [subject sendNext:@"2"];
  [subject sendNext:@"3"];
  [subject sendCompleted];

}

// distinctUntilChanged: 忽略重复数据
- (void)entry8 {
  RACSubject *subject = [RACSubject subject];

  [[subject distinctUntilChanged] subscribeNext:^(id x) {
    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);
  }];

  [subject sendNext:@"1"];
  [subject sendNext:@"1"];
  [subject sendNext:@"2"];
  [subject sendNext:@"2"];

  [subject sendCompleted];
}

// takeUntil : 直到你的标记信号发送数据的时候结束 , sendCompleted 也能结束
- (void)entry7 {

  RACSubject *subject = [RACSubject subject];
  RACSubject *signal  = [RACSubject subject];

  [[subject takeUntil:signal] subscribeNext:^(id x) {

    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);
  }];

  [subject sendNext:@"1"];
  [subject sendNext:@"2"];
  // [signal sendNext:@"标记信号"]; // 起到栅栏的作用???
  [subject sendNext:@"3"];
  [signal sendCompleted]; // sendCompleted 也能起作用...
  [subject sendNext:@"4"];
}

// takeLast: 指定拿前面的哪几条数据!!(从后往前)
- (void)entry6 {
  RACSubject *subject = [RACSubject subject];

  RACSignal *takeSignal = [subject takeLast:2];

  [takeSignal subscribeNext:^(id x) {
    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);
  }];

  [subject sendNext:@"2"];
  [subject sendNext:@"3"];
  [subject sendNext:@"1"];
  [subject sendCompleted];

}

// take : 指定拿前面的哪几条数据
- (void)entry5 {

  RACSubject *subject = [RACSubject subject];

  RACSignal *takeSignal = [subject take:2];

  [takeSignal subscribeNext:^(id x) {
    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);
  }];

  [subject sendNext:@"2"];
  [subject sendNext:@"3"];
  [subject sendNext:@"1"];
}

- (void)entry4 {

  RACSubject *subject = [RACSubject subject];

  RACSignal *ignoreSignal = [[subject ignore:@"1"] ignore:@"2"];

  [ignoreSignal subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];

  [subject sendNext:@"1"];
  [subject sendNext:@"2"];
  [subject sendNext:@"3"];

  NSLog(@"我已经发送...");

}

// ignoreValues 忽略所有
- (void)entry3 {

  RACSubject *subject = [RACSubject subject];

  RACSignal *ignoreSignal = subject.ignoreValues;

  [ignoreSignal subscribeNext:^(id x) {
    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);
  }];

  [subject sendNext:@"发送message"];

  NSLog(@"我已经发送...");

}

// ignore
- (void)entry2 {

  RACSubject *subject = [RACSubject subject];

  RACSignal *ignoreSignal = [subject ignore:@"1"];

  [ignoreSignal subscribeNext:^(id x) {
    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);
  }];

  [subject sendNext:@"2"];

  NSLog(@"已经发送...");
}

// filter
- (void)entry1 {

  UITextField *field = makeTextField(YES);
  [self.view addSubview:field];

  kMasKey(field);
  [field mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  UILabel *label = makeLabel(YES);

  [self.view addSubview:label];

  kMasKey(label);
  [label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(field.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  [[field.rac_textSignal filter:^BOOL(NSString *value) {

    return value.length > 6;

  }] subscribeNext:^(NSString *x) {
    NSLog(@"x = %@", x);
    label.text = x;
  }];
}

@end
