//
//  T082Test00SectionController.m
//  objc_template
//
//  Created by stone on 2019-05-19.
//  Copyright © 2019 stone. All rights reserved.

#import "T082Test00SectionController.h"
#import "LabelCell.h"
#import "T082TestCell.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

static NSArray *testList;

@interface T082Test00SectionController () <IGListWorkingRangeDelegate>

@property (strong, nonatomic) id object;

@end

@implementation T082Test00SectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset                   = UIEdgeInsetsMake(0, 0, 0, 0);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing      = 0;
    self.workingRangeDelegate    = self;
  }
  return self;
}

- (NSInteger)numberOfItems {

  return testList.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {

  NSUInteger col   = 1;
  CGFloat    width = (self.collectionContext.containerSize.width - self.inset.left - self.inset.right - (col - 1) * self.minimumInteritemSpacing) / col;

  // NSUInteger row = (NSUInteger) ceil(self.viewModels.count / col);
  // CGFloat height = (self.collectionContext.containerSize.height - self.inset.top - self.inset.bottom - (row - 1) * self.minimumLineSpacing) / row;

  // SNUserCell.cellHeight
  CGFloat height = 55;

  if (index == 4) {
    height = 60;
  }

  return CGSizeMake(width, height);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {

  if (index == 4) {
    T082TestCell *cell = [self.collectionContext dequeueReusableCellOfClass:T082TestCell.class forSectionController:self atIndex:index];
    // T071UserCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"T071UserCell" bundle:nil forSectionController:self atIndex:index];
    // cell.contentView.backgroundColor = sn.randomColor;
    cell.label.text = kStringFormat(@"%02li %@", index, testList[index]);;

    return cell;
  }

  LabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:LabelCell.class forSectionController:self atIndex:index];
  // T071UserCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"T071UserCell" bundle:nil forSectionController:self atIndex:index];
  // cell.contentView.backgroundColor = sn.randomColor;
  cell.label.text = kStringFormat(@"%02li %@", index, testList[index]);;

  return cell;
}

- (void)didUpdateToObject:(id)object {
  // 官方推荐 , 追踪错误宏
  // NSParameterAssert([object isKindOfClass:[LabelsItem class]]);
  self.object = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
  // NSLog(@"%s", __func__);
  if ([self respondsToSelector:NSSelectorFromString(kStringFormat(@"entry%li", index))]) {
    [self performSelector:NSSelectorFromString(kStringFormat(@"entry%li", index))];
  }
}

#pragma mark - <IGListWorkingRangeDelegate>

- (void)listAdapter:(IGListAdapter *)listAdapter sectionControllerWillEnterWorkingRange:(IGListSectionController *)sectionController {

}

- (void)listAdapter:(IGListAdapter *)listAdapter sectionControllerDidExitWorkingRange:(IGListSectionController *)sectionController {

}

//____________2019-05-19_________________________________________________▲△__.

+ (void)initialize {
  testList = @[
    @"测试 RACCommand",
    @"测试 RACReplaySubject",
    @"测试 RACSignal",
    @"测试 RACSubject",
    @"测试 ButtonClickSignal",
    @"测试 RACTuple",
  ];
}

- (void)entry0 {

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

  // 监听事件, 跳过第一次, 因为默认发送未开始信号
  __block MBProgressHUD *hud;
  [[command.executing skip:1] subscribeNext:^(NSNumber *x) {
    if ([x boolValue]) {
      // NSLog(@"网络请求执行中...");
      hud = [MBProgressHUD showHUDAddedTo:UIApplication.sharedApplication.keyWindow animated:YES];
    } else {
      // NSLog(@"网络请求结束 或者 还没开始");
      [hud hideAnimated:YES];
    }
  }];

  // command.executionSignals.switchToLatest 直接获取command包装的信号
  [command.executionSignals.switchToLatest subscribeNext:^(id x) {
    NSLog(@"x class = %@", [x valueForKeyPath:@"isa"]);
    NSLog(@"接收到 x = %@", x);
  }];

  //
  [command.errors subscribeNext:^(NSError *error) {
    NSLog(@"error = %@", error);
  }];

  [command execute:@"SNUserApi"];
}

// RACReplaySubject 支持 先发送, 后订阅
- (void)entry1 {
  RACReplaySubject *subject = [RACReplaySubject subject];

  [subject sendNext:@"hello1 订阅者们..."];
  [subject sendNext:@"hello2 订阅者们..."];

  [subject subscribeNext:^(id x) {
    NSLog(@"接受者 1 x class = %@ | x = %@", [x valueForKeyPath:@"isa"], x);
  }];
  [subject subscribeNext:^(id x) {
    NSLog(@"接受者 2 x class = %@ | x = %@", [x valueForKeyPath:@"isa"], x);
  }];
}

- (void)entry2 {
  RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

    [subscriber sendNext:@"发送信号"];
    [subscriber sendCompleted];

    // NSError *error = [NSError errorWithDomain:@"com.stone.pro" code:100 userInfo:@{NSLocalizedDescriptionKey: @"Something went wrong"}];
    // [subscriber sendError:error];

    // 默认一个信号发送数据完毕就会主动取消订阅, 只要订阅者在, 就不会自动取消订阅, 比如 property 引用
    return [RACDisposable disposableWithBlock:^{ /** NSLog(@"销毁 %s", __func__); */ }];
  }];

  [signal subscribeNext:^(id x) {
    NSLog(@"接收信号 x = %@", x);
  }];

  [signal subscribeCompleted:^{
    NSLog(@"subscribeCompleted");
  }];

  [signal subscribeError:^(NSError *error) {
    ELog(@"error = %@", error);
  }];

  [signal subscribeNext:^(id x) {
    ILog(@"x = %@", x);
  } completed:^{
    ILog(@"subscribeCompleted");
  }];

  [signal subscribeNext:^(id x) {
    WLog(@"x = %@", x);
  } error:^(NSError *error) {
    ELog(@"error = %@", error);
  } completed:^{
    SLog(@"subscribeCompleted");
  }];

  // [signal subscribeOn:[RACScheduler mainThreadScheduler] initWithName:@"111"]];

  //____________2019-05-19_________________________________________________▲△__.
  printf("\033[1;7;48m____________2019-05-19_________________________________________________▲△__.\033[0m\n");

  // https://draveness.me/racscheduler
  // RACScheduler *scheduler = [RACScheduler mainThreadScheduler];
  //
  // [scheduler schedule:^{
  //   SLog(@"%s", __func__);
  // }];
  //
  // [scheduler afterDelay:2.0 schedule:^{
  //   SLog(@"%s", __func__);
  // }];

  // [scheduler after:[NSDate dateWithTimeIntervalSinceNow:0] repeatingEvery:2 withLeeway:0 schedule:^{
  //   SLog(@"%s", __func__);
  // }];

  // setInterval
  // RACSignal<NSDate *> *racSignal = [RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]];
  // [racSignal subscribeNext:^(NSDate *x) { NSLog(@"x = %@", x); }];

  // [signal subscribeOn:scheduler];
}

// RACSubject
- (void)entry3 {

  RACSubject *subject = [RACSubject subject];

  [subject subscribeNext:^(id x) {
    NSLog(@"x class = %@ | x = %@", [x valueForKeyPath:@"isa"], x);
  }];

  [subject sendNext:@"hello 订阅者们..."];
}

- (void)entry5 {
  kToast(nil, kStringFormat(@"%s", __func__));



}

@end

#pragma clang diagnostic pop
