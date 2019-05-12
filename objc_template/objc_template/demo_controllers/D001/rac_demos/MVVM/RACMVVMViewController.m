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


}


@end
