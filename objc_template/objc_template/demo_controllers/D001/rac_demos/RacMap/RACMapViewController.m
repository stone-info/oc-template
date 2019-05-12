//
//  RACMapViewController.m
//  objc_template
//
//  Created by stone on 2019/5/12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "RACMapViewController.h"

@interface RACMapViewController ()

@end

@implementation RACMapViewController

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

// flattenMap 一般用于信号中的信号
- (void)entry {

  RACSubject *signalOfSignal = [RACSubject subject];
  RACSubject *subject1       = [RACSubject subject];
  RACSubject *subject2       = [RACSubject subject];

  [[signalOfSignal flattenMap:^RACSignal *(id value) {
    return value;
  }] subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];

  [signalOfSignal sendNext:subject1];

  [subject1 sendNext:@"发送message"];
}

- (void)entry2 {

  RACSubject *subject = [RACSubject subject];

  RACSignal *signal = [subject map:^id(id value) {
    return kStringFormat(@"处理之后的 \"%@\"", value);
  }];

  [signal subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];

  [subject sendNext:@"发送message"];
}

// flattenMap 一般用于信号中的信号
- (void)entry1 {

  RACSubject *subject = [RACSubject subject];

  RACSignal *bindSignalFlattenMap = [subject flattenMap:^RACSignal *(id value) {
    return [RACReturnSignal return:kStringFormat(@"处理之后的 \"%@\"", value)];
  }];

  RACSignal *bindSignalMap = [subject map:^id(id value) {
    return [RACReturnSignal return:kStringFormat(@"处理之后的 \"%@\"", value)];
  }];

  [bindSignalFlattenMap subscribeNext:^(id x) {
    NSLog(@"bindSignalFlattenMap x = %@", x);
  }];

  [bindSignalMap subscribeNext:^(id x) {
    NSLog(@"bindSignalMap x = %@", x);

    [x subscribeNext:^(id x) {
      NSLog(@"x = %@", x);
    }];

  }];

  [subject sendNext:@"发送message"];

}


@end
