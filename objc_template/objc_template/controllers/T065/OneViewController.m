//
// Created by stone on 2019-05-10.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "OneViewController.h"
#import "TwoViewController.h"

@interface OneViewController ()
@end

@implementation OneViewController {}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  self.view.backgroundColor = UIColor.whiteColor;

  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];

  button.layer.borderWidth   = 1.0;
  button.layer.borderColor   = [UIColor orangeColor].CGColor;
  button.layer.cornerRadius  = 4.0;
  button.layer.masksToBounds = YES;

  [button setAdjustsImageWhenHighlighted:NO];
  [button setTitle:@"Click me" forState:UIControlStateNormal];
  [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
  [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:button];

  [button mas_makeConstraints:^(MASConstraintMaker *make) {
  make.center;
  make.width.mas_equalTo(200);
  make.height.mas_equalTo(50);
  }];

}

- (void)btnClicked:(UIButton *)sender {

  TwoViewController *viewController = TwoViewController.new;

  viewController.delegateSignal = [RACSubject subject];

  [viewController.delegateSignal subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
    self.view.backgroundColor = sn.randomColor;
  }];

  [self.navigationController pushViewController:viewController animated:YES];
}

@end