//
// Created by stone on 2019-05-11.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "RACSchedulerViewController.h"
#import "SNTestThread.h"

@interface RACSchedulerViewController ()
@property (weak, nonatomic) NSTimer         *timer;
@property (assign, nonatomic) BOOL          finished;
@property (assign, nonatomic) NSInteger     time;
@property (nonatomic, strong) RACDisposable *disposable;
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

  UIButton *button = makeButton(YES);
  [self.view addSubview:button];
  kMasKey(button);
  [button mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  // printf("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■\n");

  [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *x) {

    button.enabled = NO;

    _time = 10;

    self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate *x) {


      if (_time >= 0) {
        button.enabled = NO;
        [button setTitle:kStringFormat(@"请等待%li秒", _time) forState:UIControlStateDisabled];
      } else {
        button.enabled = YES;
        [button setTitle:@"重新发送" forState:UIControlStateNormal];
        [_disposable dispose];
      }
      _time--;
    }];
  }];
}

- (void)entry2 {

  // [RACScheduler scheduler] 子线程 , 封装 GCD的
  // [RACScheduler mainThreadScheduler]; 主线程

  // time interval
  [[RACSignal interval:1.0 onScheduler:[RACScheduler scheduler]] subscribeNext:^(NSDate *x) {
    NSLog(@"x = %@", x);
    NSLog(@"[NSThread currentThread] = %@", [NSThread currentThread]);
  }];

}

- (void)entry1 {

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