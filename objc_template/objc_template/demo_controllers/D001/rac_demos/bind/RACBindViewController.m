//
//  RACBindViewController.m
//  objc_template
//
//  Created by stone on 2019/5/12.
//  Copyright © 2019 stone. All rights reserved.
//


#import "RACBindViewController.h"
#import "SNUserApi.h"
#import "SNUserModel.h"

@interface RACBindViewController ()

@end

@implementation RACBindViewController

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

// 应用场景
- (void)entry {

  RACSubject *subject = [RACSubject subject];

  RACSignal *bindSignal = [subject bind:^RACSignalBindBlock {

    return ^RACSignal *(id value, BOOL *stop) {

      NSLog(@"value = %@", value);

      NSMutableArray<SNUserModel *> *users = [SNUserModel mj_objectArrayWithKeyValuesArray:value];

      return [RACReturnSignal return:users];
    };
  }];

  [bindSignal subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];

  SNUserApi *api = SNUserApi.new;

  [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {

    [subject sendNext:request.responseJSONObject];

  } failure:^(__kindof YTKBaseRequest *request) {

  }];
}

- (void)entry1 {

  RACSubject *subject = [RACSubject subject];

  RACSignal *bindSignal = [subject bind:^RACSignalBindBlock {

    return ^RACSignal *(id value, BOOL *stop) {
      NSLog(@"value = %@", value);
      return [RACReturnSignal return:value];
    };
  }];

  [bindSignal subscribeNext:^(id x) {
    NSLog(@"绑定接收到 %@", x);
  }];

  [subject sendNext:@"发送message"];

}


@end
