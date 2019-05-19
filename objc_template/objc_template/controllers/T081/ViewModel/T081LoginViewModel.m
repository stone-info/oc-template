//
// Created by stone on 2019-05-19.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "T081LoginViewModel.h"

@interface T081LoginViewModel ()

@end

@implementation T081LoginViewModel {}

- (Account *)account {
  if (!_account) {
    _account = [[Account alloc] init];
  }
  return _account;
}

- (instancetype)init {
  if (self = [super init]) {
    [self initBind];
  }
  return self;
}

- (void)initBind {
  // 绑定信号
  self.enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.account, username), RACObserve(self.account, password)] reduce:^id(NSString *account, NSString *pwd) {
    return @(account.length && pwd.length);
  }];

  // 处理登陆逻辑
  self.loginCommand = [RACCommand.alloc initWithSignalBlock:^RACSignal *(id input) {

    NSLog(@"%@", input);

    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [subscriber sendNext:@"登陆成功"];

        [subscriber sendCompleted];

      });

      return nil;

    }];

  }];

  // 处理登陆产生的数据
  [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
    if ([x isEqualToString:@"登陆成功"]) {
      NSLog(@"小子, 你登陆成功了");
    }
  }];

  // 监听登陆状态
  [[self.loginCommand.executing skip:1] subscribeNext:^(id x) {
    if ([x isEqualToNumber:@(YES)]) {
      NSLog(@"正在登陆");
    } else {
      NSLog(@"登陆完成");
    }
  }];
}

@end