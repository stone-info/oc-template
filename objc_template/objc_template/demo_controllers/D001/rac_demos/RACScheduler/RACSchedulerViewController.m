//
// Created by stone on 2019-05-11.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "RACSchedulerViewController.h"
#import "SNTestThread.h"

@interface RACSchedulerViewController ()
@property (weak, nonatomic) NSTimer *timer;
@property (assign, nonatomic) BOOL  finished;
@end

@implementation RACSchedulerViewController {}

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
  _finished = YES;
}

- (void)entry {

  SNTestThread *thread = [SNTestThread.alloc initWithBlock:^{
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(dosomething:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];

    // 子线程 开启runloop , 子线程的 默认是关闭的... | 能关闭的runloop
    while (!_finished) { [NSRunLoop.currentRunLoop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.001]]; }

    NSLog(@"子线程 runloop 结束");
  }];

  [thread start];

  _finished = NO;
}

- (void)dosomething:(NSTimer *)timer {
  // timer.userInfo
  NSLog(@"%s", __func__);
}


@end