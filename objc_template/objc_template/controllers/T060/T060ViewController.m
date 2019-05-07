//
//  T060ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T060ViewController.h"

@interface T060ViewController ()

@end

@implementation T060ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  // [self demo1];


  RACSignal *originalSignal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
    NSLog(@"%s", __func__);
    [subscriber sendNext:@"hello world"];
    [subscriber sendCompleted]; // 感觉和 promise的 reject resolve 一样 , 为了 知道 批量操作的出口
    return [RACDisposable disposableWithBlock:^{
      NSLog(@"%s", __func__);
    }];
  }];

  // 好比 signal 是 工厂的源头,  将它转换成 sequence 是 将生产出来的产品排成一个序列 放在一个容器里
  RACSequence *sequence = [originalSignal sequence];

  // 而反过来 把 sequence 转换为 signal 把已经生产好的一堆产品 按照序列放到即将发送的管道 去作为这个管道的发送源
  RACSignal *signal = [sequence signal];

  // sequence是 RAC 世界里的 数组容器, 可以和 NSArray 无缝转换

  NSArray *array = @[@1, @2, @3, @4, @5];

  RACSequence *seq = [array rac_sequence];
  // NSArray     *arr = [seq array];


  // 惰性初始化
  RACSequence *racSequence = [seq map:^id(id value) {
    return @([value integerValue] * 3);
  }];

  NSLog(@"racSequence = %@", racSequence.array);

  RACSequence *filter = [racSequence filter:^BOOL(id value) {
    return [value integerValue] % 2 == 0;
  }];

  NSLog(@"filter = %@", filter.array);

}

// 拉驱动模式 | 订阅的时候 才生成内容
- (void)demo1 {
  __block int a = 0;

  RACSignal *racSignal = [[RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

    NSLog(@"%s", __func__);

    a += 5;

    [subscriber sendNext:@(a)];
    [subscriber sendCompleted]; // 感觉和 promise的 reject resolve 一样 , 为了 知道 批量操作的出口

    return [RACDisposable disposableWithBlock:^{
      NSLog(@"%s", __func__);
    }];
  }] replayLast]; // 如果不写 replayLast , 重复订阅 这个信号 会反复执行 block 里面的内容, 即 a 每次都加5


  // 只有订阅了 才执行 信号里的 block , 冷信号 变 热信号? 有需求 才生产
  [racSignal subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];

  [racSignal subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];
}


@end
    