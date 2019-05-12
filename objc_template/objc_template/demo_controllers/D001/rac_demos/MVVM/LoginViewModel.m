//
// Created by stone on 2019-05-12.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "LoginViewModel.h"
#import "SNUserApi.h"

@interface LoginViewModel ()

@end

@implementation LoginViewModel {}

- (instancetype)init {
  self = [super init];
  if (self) {

    [self setupSignal];

  }
  return self;
}

- (void)setupSignal {

  _loginEnableSignal = [RACSignal combineLatest:@[
    RACObserve(self, username),
    RACObserve(self, password),
  ] reduce:^id(NSString *username, NSString *password) {
    return @(username.length && password.length);
  }];

  _loginCommand = [RACCommand.alloc initWithSignalBlock:^RACSignal *(id input) {
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
      SNUserApi *api = SNUserApi.new;
      [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        [subscriber sendNext:request.responseJSONObject];
        [subscriber sendCompleted];
      } failure:^(__kindof YTKBaseRequest *request) {
        [subscriber sendError:request.error];
      }];
      // return [RACDisposable disposableWithBlock:^{ NSLog(@"销毁 %s", __func__); }];
      return nil;
    }];
  }];

  [_loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
    // [hud hideAnimated:NO];
  }];

  __block MBProgressHUD *hud;
  // executing 会是 0 1 0 , 所以 跳过第一个
  [[_loginCommand.executing skip:1] subscribeNext:^(NSNumber *x) {

    if ([x boolValue]) {
      // 请求中...
      hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
      NSLog(@"请求中...");
    } else {
      // 请求结束...
      NSLog(@"请求结束...");
      // hud.hidden = YES;
      [hud hideAnimated:YES];
    }
  }];
}

@end