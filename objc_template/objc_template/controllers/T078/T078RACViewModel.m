//
// Created by stone on 2019-05-13.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "T078RACViewModel.h"
#import "SNUserApi.h"
#import "SNUserModel.h"

@interface T078RACViewModel ()

@end

@implementation T078RACViewModel {}

- (instancetype)init {
  self = [super init];
  if (self) {
    // 初始化时将创建信号和订阅信号一起完成
    [self setupSignal];
    [self setupSubscriber];
  }
  return self;
}

- (void)setupSignal {

  // 创建取消的command，并在这里执行取消之后的命令。在Demo中则是网络请求取消，
  // 在这里就可以执行取消网络请求的操作，并且可以通过block获取一个参数，参数可以是任意类型的，我们可以改，也可以不改。
  self.cancelCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(NSString *inputStr) {
    NSLog(@"%@", inputStr);
    return [RACSignal empty];
  }];

  // 刷新页面command，因为是刷新页面，所以要从第一个开始刷新，具体的刷新业务逻辑在下面将会讲解。
  // 当通过调用获取更多和刷新页面这两个command的execute:方法时，会分别调用这两个block。
  @weakify(self);
  self.reloadDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id inputValue) {
    @strongify(self);
    return [[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
      SNUserApi *api = SNUserApi.new;
      [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
        NSMutableArray<SNUserModel *> *users = [SNUserModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject];
        [subscriber sendNext:users];
        [subscriber sendCompleted];
      } failure:^(__kindof YTKBaseRequest *request) {
        NSLog(@"request.error = %@", request.error);
        [subscriber sendError:request.error];
      }];
      // return [RACDisposable disposableWithBlock:^{ NSLog(@"销毁 %s", __func__); }];
      return nil;
    }] takeUntil:self.cancelCommand.executionSignals];
  }];
}

- (void)setupSubscriber {

  @weakify(self);
  [[self.reloadDataCommand.executionSignals switchToLatest] subscribeNext:^(id x) {
    @strongify(self);

    NSLog(@"x = %@", x);

    self.dataList = x;
  }];
}

@end