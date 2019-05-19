//
//  RACMVVMViewController.m
//  objc_template
//
//  Created by stone on 2019/5/12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "RACMVVMViewController.h"
#import "LoginViewModel.h"
// MVC 老板和员工一起干活
// MVVM 老板顾几个店长 , 店长负责和 view 和 model 交接 , 老板 负责与 viewModel 交接...

@interface RACMVVMViewController ()
@property (strong, nonatomic) LoginViewModel *loginViewModel;
@property (weak, nonatomic) UITextField      *usernameField;
@property (weak, nonatomic) UITextField      *passwordField;
@property (weak, nonatomic) UIButton         *loginButton;
@end

@implementation RACMVVMViewController

- (LoginViewModel *)loginViewModel {

  if (_loginViewModel == nil) {
    _loginViewModel = [LoginViewModel new];
  }
  return _loginViewModel;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  [self addViews];

  RAC(self.loginViewModel, username) = _usernameField.rac_textSignal;
  RAC(self.loginViewModel, password) = _passwordField.rac_textSignal;

  RAC(_loginButton, enabled) = self.loginViewModel.loginEnableSignal;

  [[_loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
    [self.loginViewModel.loginCommand execute:@"发送账号密码"];
  }];
}

- (void)addViews {

  UITextField *usernameField = makeTextField(YES);
  UITextField *passwordField = makeTextField(YES);
  UIButton    *loginButton   = makeButton(YES);
  _usernameField = usernameField;
  _passwordField = passwordField;
  _loginButton   = loginButton;
  loginButton.enabled = NO;

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
}


@end
