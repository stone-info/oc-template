//
//  RACCommandViewController.m
//  objc_template
//
//  Created by stone on 2019/5/12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "RACCommandViewController.h"

@interface RACCommandViewController ()

@end

@implementation RACCommandViewController

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
  // [self.views removeAllObjects];
  // self.views = nil;
  [self entry];
}

- (void)entry {

  RACCommand *command = [RACCommand.alloc initWithSignalBlock:^RACSignal *(id input) {

    NSLog(@"input = %@", input);

    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

      [subscriber sendNext:input];
      [subscriber sendCompleted];

      return nil;
    }];

  }];

  // 监听事件
  [command.executing subscribeNext:^(NSNumber *x) {
    if ([x boolValue]) {
      NSLog(@"正在执行...");
    }else{
      NSLog(@"执行完毕 或者 还没开始做");
    }
  
  }];

  RACSignal *racSignal = [command execute:@"执行"];

  [racSignal subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];

}

// switchToLatest 解释 最新的信号
- (void)entry4 {
  RACSubject *signalOfSignal = [RACSubject subject];
  RACSubject *subject1       = [RACSubject subject];
  RACSubject *subject2       = [RACSubject subject];
  RACSubject *subject3       = [RACSubject subject];

  [signalOfSignal.switchToLatest subscribeNext:^(id x) {

    NSLog(@"x = %@", x);

  }];


  [signalOfSignal sendNext:subject1];
  [signalOfSignal sendNext:subject2];
  [signalOfSignal sendNext:subject3];

  [subject3 sendNext:@"3"];
  [subject2 sendNext:@"2"];
  [subject1 sendNext:@"1"];
}

- (void)entry3 {

  RACCommand *command = [RACCommand.alloc initWithSignalBlock:^RACSignal *(id input) {

    NSLog(@"input = %@", input);

    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

      [subscriber sendNext:input];
      [subscriber sendCompleted];

      return nil;
    }];

  }];

  [command.executionSignals.switchToLatest subscribeNext:^(id x) {

    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);

  }];

  [command execute:@"你好吗 世界"];
}

- (void)entry2 {

  RACCommand *command = [RACCommand.alloc initWithSignalBlock:^RACSignal *(id input) {

    NSLog(@"input = %@", input);

    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

      [subscriber sendNext:input];
      [subscriber sendCompleted];

      return nil;
    }];

  }];

  [command.executionSignals subscribeNext:^(RACSignal *x) {
    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);

    [x subscribeNext:^(id x) {
      NSLog(@"x = %@", x);
    }];
  }];

  [command execute:@"hello world"];
}

- (void)entry1 {

  RACCommand *command = [RACCommand.alloc initWithSignalBlock:^RACSignal *(id input) {

    NSLog(@"input = %@", input);

    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

      [subscriber sendNext:input];
      [subscriber sendCompleted];

      // return [RACDisposable disposableWithBlock:^{ NSLog(@"销毁 %s", __func__); }];
      return nil;
    }];
  }];

  RACSignal *racSignal = [command execute:@"hello world"];

  [racSignal subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];
}


@end
