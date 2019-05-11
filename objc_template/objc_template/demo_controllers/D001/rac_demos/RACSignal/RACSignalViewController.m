//
//  RACSignalViewController.m
//  objc_template
//
//  Created by stone on 2019/5/11.
//  Copyright © 2019 stone. All rights reserved.
//

#import "RACSignalViewController.h"

@interface RACSignalViewController ()
@property (strong, nonatomic) RACSignal *signal;
@end

@implementation RACSignalViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = UIColor.whiteColor;

  RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

    [subscriber sendNext:sn.randomColor];

    [subscriber sendCompleted];

    return [RACDisposable disposableWithBlock:^{ NSLog(@"销毁 %s", __func__); }];
  }];

  _signal = signal;

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

  [_signal subscribeNext:^(id x) {
    NSLog(@"接收信号 x = %@", x);

    if ([x isKindOfClass:[UIColor class]]) {
      UIColor *color = (UIColor *) x;
      self.view.backgroundColor = color;
    }
  }];
}

@end
