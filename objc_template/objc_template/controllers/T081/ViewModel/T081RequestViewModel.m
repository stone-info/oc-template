//
//  T081RequestViewModel.m
//  objc_template
//
//  Created by stone on 2019/5/19.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T081RequestViewModel.h"
#import "SNUserApi.h"

@interface T081RequestViewModel ()


@end

@implementation T081RequestViewModel

- (instancetype)init {
  if (self = [super init]) {
    [self initBind];
  }
  return self;
}

- (void)initBind {

  RACCommand *command = [RACCommand.alloc initWithSignalBlock:^RACSignal *(id input) {
    NSLog(@"参数 = %@", input);
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
      YTKRequest *api = (YTKRequest *) [[NSClassFromString(input) alloc] init];
      [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        [subscriber sendNext:request.responseJSONObject];
        [subscriber sendCompleted];
      } failure:^(__kindof YTKBaseRequest *request) {
        [subscriber sendError:request.error];
      }];
      return [RACDisposable disposableWithBlock:^{ /** NSLog(@"销毁 %s", __func__); */ }];;
    }];
  }];
  self.requestCommand = command;

  // // 监听事件, 跳过第一次, 因为默认发送未开始信号
  // [[command.executing skip:1] subscribeNext:^(NSNumber *x) {
  //   if ([x boolValue]) {
  //     NSLog(@"网络请求执行中...");
  //   } else {
  //     NSLog(@"网络请求结束 或者 还没开始");
  //   }
  // }];
  //
  // // command.executionSignals.switchToLatest 直接获取command包装的信号
  // [command.executionSignals.switchToLatest subscribeNext:^(id x) {
  //   NSLog(@"x class = %@", [x valueForKeyPath:@"isa"]);
  //   NSLog(@"接收到 x = %@", x);
  // }];

  // [command execute:@"SNUserApi"];

}

@end
