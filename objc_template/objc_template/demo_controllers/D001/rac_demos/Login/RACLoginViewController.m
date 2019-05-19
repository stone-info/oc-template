//
//  RACLoginViewController.m
//  objc_template
//
//  Created by stone on 2019/5/12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "RACLoginViewController.h"
#import "SNUserApi.h"

@interface RACLoginViewController ()

@end

@implementation RACLoginViewController

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
  [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  [self entry];
}

- (void)entry {

  UITextField *usernameField = makeTextField(YES);
  UITextField *passwordField = makeTextField(YES);
  UIButton    *loginButton   = makeButton(YES);
  loginButton.enabled       = NO;
  usernameField.placeholder = @"username";
  passwordField.placeholder = @"password";

  [loginButton setTitle:@"登录" forState:UIControlStateNormal];
  [loginButton setTitle:@"登录" forState:UIControlStateHighlighted];
  [loginButton setTitle:@"登录" forState:UIControlStateDisabled];

  [self.view addSubview:usernameField];
  [self.view addSubview:passwordField];
  [self.view addSubview:loginButton];

  kMasKey(usernameField);
  [usernameField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  kMasKey(passwordField);
  [passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(usernameField.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  kMasKey(loginButton);
  [loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(passwordField.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  RACSignal *signal = [RACSignal combineLatest:@[usernameField.rac_textSignal, passwordField.rac_textSignal] reduce:^id(NSString *username, NSString *password) {
    return @(username.length && password.length);
  }];

  RAC(loginButton, enabled) = signal;

  RACCommand *command = [RACCommand.alloc initWithSignalBlock:^RACSignal *(id input) {
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


  [command.executionSignals.switchToLatest subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
    // [hud hideAnimated:NO];
  }];

  __block MBProgressHUD *hud;
  [[command.executing skip:1] subscribeNext:^(NSNumber *x) {

    if ([x boolValue]) {
      // 请求中...
      hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
      NSLog(@"请求中...");
    } else {
      // 请求结束...
      NSLog(@"请求结束...");
      // hud.hidden = YES;
      [hud hideAnimated:YES];
    }
  }];

  [[loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    [command execute:@"发送账号密码"];
  }];

}
@end
