//
// Created by stone on 2019-05-10.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "TwoViewController.h"

@interface TwoViewController ()

@end

@implementation TwoViewController {}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = UIColor.whiteColor;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

  if (_delegateSignal) {
    [_delegateSignal sendNext:@"hello 订阅者们..."];
  }
}

@end