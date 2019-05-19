//
//  RACConcatViewController.m
//  objc_template
//
//  Created by stone on 2019/5/12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "RACConcatViewController.h"

@interface RACConcatViewController ()

@property (nonatomic, strong) RACSignal *signalA;
@property (nonatomic, strong) RACSignal *signalB;
@property (nonatomic, strong) RACSignal *signalC;
@end

@implementation RACConcatViewController {
  __strong UIButton    *_loginButton;
  __strong UITextField *_passwordField;
  __strong UITextField *_usernameField;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  [self addLoginViews];

  [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *x) {
    NSLog(@"%s", __func__);
  }];
  // combineLatest:将多个信号合并起来，并且拿到各个信号的最新的值,必须每个合并的signal至少都有过一次sendNext，才会触发合并的信号。
  RACSignal *racSignal       = [RACSignal combineLatest:@[_usernameField.rac_textSignal, _passwordField.rac_textSignal] reduce:^id(NSString *username, NSString *password) {

    NSLog(@"username = %@", username);
    NSLog(@"password = %@", password);

    return @(username.length && password.length);
  }];
  //
  // [racSignal subscribeNext:^(id x) {
  //   NSLog(@"x class = %@", SN.getClassName(x));
  //   NSLog(@"x = %@", x);
  //   _loginButton.enabled = [x boolValue];
  // }];

  RAC(_loginButton, enabled) = racSignal;

  [self entry];
}

- (void)injected {
  [self entry];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  [self entry];
}

- (void)entry {
  NSLog(@"hello world");
}

- (void)addSignal {
  self.signalA = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

    [subscriber sendNext:@"发送信号A"];
    [subscriber sendCompleted];
    // [subscriber sendError:nil];

    return [RACDisposable disposableWithBlock:^{ NSLog(@"销毁A %s", __func__); }];
    // return nil;
  }];

  self.signalB = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

    [subscriber sendNext:@"发送信号B"];
    [subscriber sendCompleted];
    // [subscriber sendError:nil];

    return [RACDisposable disposableWithBlock:^{ NSLog(@"销毁B %s", __func__); }];
    // return nil;
  }];

  self.signalC = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

    [subscriber sendNext:@"发送信号C"];
    [subscriber sendCompleted];
    // [subscriber sendError:nil];

    return [RACDisposable disposableWithBlock:^{ NSLog(@"销毁C %s", __func__); }];
    // return nil;
  }];
}

- (void)addLoginViews {

  [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

  self.view.backgroundColor = UIColor.whiteColor;
  _usernameField = makeTextField(YES);
  _usernameField.placeholder = @"账号";
  [self.view addSubview:_usernameField];

  _passwordField = makeTextField(YES);
  _passwordField.placeholder = @"密码";
  [self.view addSubview:_passwordField];

  _loginButton = makeButton(YES);
  [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
  [_loginButton setTitleColor:HexRGBA(@"#c0c0c0", 1.0) forState:UIControlStateDisabled];

  _loginButton.enabled = NO;
  [self.view addSubview:_loginButton];

  kMasKey(_usernameField);
  [_usernameField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  [_passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(_usernameField.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(_passwordField.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];
}

- (void)entry6 {

  UITextField *usernameField = makeTextField(YES);
  usernameField.placeholder = @"账号";
  [self.view addSubview:usernameField];

  UITextField *passwordField = makeTextField(YES);
  passwordField.placeholder = @"密码";
  [self.view addSubview:passwordField];

  UIButton *loginButton = makeButton(YES);
  [loginButton setTitle:@"登录" forState:UIControlStateNormal];
  [loginButton setTitleColor:HexRGBA(@"#c0c0c0", 1.0) forState:UIControlStateDisabled];

  loginButton.enabled = NO;
  [self.view addSubview:loginButton];

  kMasKey(usernameField);
  [usernameField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(usernameField.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(passwordField.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  [[loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *x) {
    NSLog(@"%s", __func__);
  }];

  RACSignal *racSignal = [RACSignal combineLatest:@[usernameField.rac_textSignal, passwordField.rac_textSignal] reduce:^id {
    return sn.randomString;
  }];

  [racSignal subscribeNext:^(id x) {
    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);
  }];

  // RAC(loginButton, enabled) = [usernameField.rac_textSignal merge:passwordField.rac_textSignal];
}

// zipWith: 两个信号压缩! 只有当两个信号 同时发出信号内容, 并且将内容合并成为一个元祖给你
// 必须满足 压缩的信号 都有新值时 才发送信号
- (void)entry5 {
  RACSubject *subjectA = [RACSubject subject];
  RACSubject *subjectB = [RACSubject subject];
  RACSubject *subjectC = [RACSubject subject];

  RACSignal<RACTwoTuple *> *racSignal = [subjectA zipWith:subjectB];

  RACSignal<RACTwoTuple *> *with = [racSignal zipWith:subjectC];

  NSLog(@"with = %@", with);

  [with subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];

  [subjectA sendNext:@"数据A"];
  [subjectB sendNext:@"数据B"];
  [subjectC sendNext:@"数据C"];
  //
  // [subjectA sendNext:@"数据A"];
  // [subjectB sendNext:@"数据B"];
  // [subjectC sendNext:@"数据C"];

}

// 并发
- (void)entry4 {
  RACSubject *subjectA = [RACSubject subject];
  RACSubject *subjectB = [RACSubject subject];
  RACSubject *subjectC = [RACSubject subject];

  RACSignal *racSignal = [[subjectA merge:subjectB] merge:subjectC];

  [racSignal subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];

  [subjectA sendNext:@"数据A"];
  [subjectB sendNext:@"数据B"];
  [subjectC sendNext:@"数据C"];
}

// then
- (void)entry3 {

  [self addSignal];

  [[[_signalA then:^RACSignal * {
    return _signalB;
  }] then:^RACSignal * {
    return _signalC;
  }] subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];
}

// concat
- (void)entry2 {
  [self addSignal];

  RACSignal *racSignal = [RACSignal concat:@[self.signalA, self.signalB, self.signalC]];

  [racSignal subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];
}

- (void)entry1 {

  [self addSignal];

  // 和事务一样? 前一个信号 如果没有成功 , 后一个就永远触发不了?
  RACSignal *racSignal = [[self.signalA concat:self.signalB] concat:self.signalC];

  [racSignal subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];

}

@end
