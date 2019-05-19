//
//  LoginCell.m
//  objc_template
//
//  Created by stone on 2019/5/19.
//  Copyright © 2019 stone. All rights reserved.
//

#import "LoginCell.h"
#import "T081LoginViewModel.h"

@interface LoginCell ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton    *loginButton;

/** 登陆viewModel */
@property (nonatomic, strong) T081LoginViewModel *loginViewModel;
@end

@implementation LoginCell

- (T081LoginViewModel *)loginViewModel {

  if (!_loginViewModel) {
    _loginViewModel = [[T081LoginViewModel alloc] init];
  }
  return _loginViewModel;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {

  }
  return self;
}

- (void)awakeFromNib {
  [super awakeFromNib];

  // 绑定信号
  RAC(self.loginViewModel.account, username) = self.usernameTextField.rac_textSignal;
  RAC(self.loginViewModel.account, password) = self.passwordTextField.rac_textSignal;
  RAC(self.loginButton, enabled)             = self.loginViewModel.enableLoginSignal;

  [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *x) {
    [self.loginViewModel.loginCommand execute:@"登录哦"];
  }];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

  }
  return self;
}

@end
