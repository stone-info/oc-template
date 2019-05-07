//
//  T059ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T059ViewController.h"
#import "T059UsersApi.h"

@interface T059ViewController ()

@end

@implementation T059ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  RACSignal *usersSignal = [self signalFromJson:@"http://jsonplaceholder.typicode.com/users"];
  RACSignal *postsSignal = [self signalFromJson:@"http://jsonplaceholder.typicode.com/posts"];
  RACSignal *todosSignal = [self signalFromJson:@"http://jsonplaceholder.typicode.com/todos"];

  // [usersSignal subscribeNext:^(id x) {
  //   NSLog(@"x = %@", x);
  // } error:^(NSError *error) {
  //   NSLog(@"error = %@", error);
  // } completed:^{
  //   NSLog(@"%s", __func__);
  // }];

  // 并发1 , 每个结果都会依次过来 , 那有蛋用...
  // RACSignal *racSignal = [[usersSignal merge:postsSignal] merge:todosSignal];
  // [racSignal subscribeNext:^(id x) {
  //   if ([x isKindOfClass:[NSArray class]]) {
  //     NSArray *array = (NSArray *) x;
  //     NSLog(@"array.count = %lu", array.count);
  //   }
  // } error:^(NSError *error) {
  //   NSLog(@"error = %@", error);
  // } completed:^{
  //   NSLog(@"%s", __func__);
  // }];

  // 并发2: promise all  , subscribeNext 다음 구독
  RACSignal<RACTuple *> *racSignal = [RACSignal combineLatest:@[usersSignal, postsSignal, todosSignal]];

  // 类似 youtube 订阅, 没订阅之前 先看内容不错 , 点击了 订阅 , 如果作者 发布新的内容 , 就收到通知
  [racSignal subscribeNext:^(RACTuple *x) {
    // NSLog(@"x = %@", x);
    NSLog(@"x class = %@", SN.getClassName(x));

    NSLog(@"[x count] = %lu", [x count]);
  }];




  // async await | 执行到是 按顺序执行了 , 没法拿到 执行结果喂...
  // [[[postsSignal then:^RACSignal * {
  //   // NSLog(@"%s", __func__);
  //   return usersSignal;
  // }] then:^RACSignal * {
  //   // NSLog(@"%s", __func__);
  //   return todosSignal;
  // }] subscribeNext:^(id x) {
  //   // NSLog(@"x class = %@", SN.getClassName(x));
  // }];

  // [then subscribeNext:^(id x) {
  //   if ([x isKindOfClass:[NSArray class]]) {
  //     NSArray *array = (NSArray *) x;
  //     NSLog(@"array.count = %lu", array.count);
  //   }
  // } error:^(NSError *error) {
  //   NSLog(@"error = %@", error);
  // } completed:^{
  //   NSLog(@"%s", __func__);
  // }];

}

- (RACSignal *)signalFromJson:(NSString *)urlString {

  return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

    T059UsersApi *api = [T059UsersApi.alloc initWithUrlString:urlString];

    [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {

      id jsonObject = request.responseJSONObject;

      NSLog(@"urlString = %@ | result = %@", urlString, SN.getClassName(jsonObject));

      // NSLog(@"request.responseJSONObject = %@", jsonObject);

      [subscriber sendNext:jsonObject];
      [subscriber sendCompleted];

    } failure:^(__kindof YTKBaseRequest *request) {
      // sendError 和 sendCompleted 只能调用一次 , 有我没他的意思
      [subscriber sendError:request.error];
    }];

    return [RACDisposable disposableWithBlock:^{

    }];
  }];
}


@end
    