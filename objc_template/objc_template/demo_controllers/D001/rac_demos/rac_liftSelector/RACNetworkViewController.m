//
//  RACNetworkViewController.m
//  objc_template
//
//  Created by stone on 2019/5/12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "RACNetworkViewController.h"
#import "SNUserApi.h"
#import "SNPostApi.h"
#import "SNUserModel.h"
#import "SNPostModel.h"

@interface RACNetworkViewController ()

@end

@implementation RACNetworkViewController { UILabel *_label; }

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

}

- (void)entry {

  [self addViews];

  RACSignal *usersSignal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
    SNUserApi *api = SNUserApi.new;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
      NSMutableArray<SNUserModel *> *users = [SNUserModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject];
      [subscriber sendNext:users];
      [subscriber sendCompleted];
    } failure:^(__kindof YTKBaseRequest *request) {
      [subscriber sendError:request.error];
      NSLog(@"request.error = %@", request.error);
    }];
    return [RACDisposable disposableWithBlock:^{ NSLog(@"销毁 %s", __func__); }];
  }];

  RACSignal *postsSignal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
    SNPostApi *api = SNPostApi.new;
    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {
      NSMutableArray<SNPostModel *> *posts = [SNPostModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject];
      [subscriber sendNext:posts];
      [subscriber sendCompleted];
    } failure:^(__kindof YTKBaseRequest *request) {
      [subscriber sendError:request.error];
      NSLog(@"request.error = %@", request.error);
    }];
    return [RACDisposable disposableWithBlock:^{ NSLog(@"销毁 %s", __func__); }];
  }];

  [self rac_liftSelector:@selector(updateUIWithUsers:posts:) withSignalsFromArray:@[usersSignal, postsSignal]];

}

- (void)updateUIWithUsers:(NSArray<SNUserModel *> *)users posts:(NSArray<SNPostModel *> *)posts {

  NSLog(@"users = %@", users);

  NSLog(@"posts = %@", posts);

}

- (void)addViews {

  _label = makeLabel(YES);

  [self.view addSubview:_label];
  [_label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

}
@end
