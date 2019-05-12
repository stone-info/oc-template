//
//  RACMulticastConnectionViewController.m
//  objc_template
//
//  Created by stone on 2019/5/12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "RACMulticastConnectionViewController.h"
#import "SNUserApi.h"
#import "SNUserModel.h"

// 一个信号 多次订阅的时候 避免多次 执行 sendNext

@interface RACMulticastConnectionViewController ()

@end

@implementation RACMulticastConnectionViewController

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

- (void)entry {

  RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

    SNUserApi *api = SNUserApi.new;

    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {

      NSMutableArray<SNUserModel *> *users = [SNUserModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject];
      [subscriber sendNext:users];
      [subscriber sendCompleted];

    } failure:^(__kindof YTKBaseRequest *request) {
      [subscriber sendError:request.error];
    }];

    return [RACDisposable disposableWithBlock:^{ NSLog(@"销毁 %s", __func__); }];
  }];

  RACMulticastConnection *broadcast = signal.publish;

  [broadcast.signal subscribeNext:^(id x) {
    NSLog(@"订阅者1 接收信号 x = %@", x);
  }];

  [broadcast.signal subscribeNext:^(id x) {
    NSLog(@"订阅者2 接收信号 x = %@", x);
  }];

  [broadcast.signal subscribeNext:^(id x) {
    NSLog(@"订阅者3 接收信号 x = %@", x);
  }];

  [broadcast connect];
}

@end
