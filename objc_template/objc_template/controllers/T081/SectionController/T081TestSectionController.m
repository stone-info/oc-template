//
//  T081TestSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-19.
//  Copyright © 2019 stone. All rights reserved.

#import "T081TestSectionController.h"
#import "LabelCell.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

@interface T081TestSectionController () <IGListWorkingRangeDelegate>

@property (strong, nonatomic) id object;

@end

@implementation T081TestSectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset                = UIEdgeInsetsMake(0, 0, 0, 0);
    self.workingRangeDelegate = self;
  }
  return self;
}

- (NSInteger)numberOfItems {

  return 10;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {

  NSUInteger col   = 1;
  CGFloat    width = (self.collectionContext.containerSize.width - self.inset.left - self.inset.right - (col - 1) * self.minimumInteritemSpacing) / col;
  return CGSizeMake(width, 55);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  LabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:LabelCell.class forSectionController:self atIndex:index];
  // T071UserCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"T071UserCell" bundle:nil forSectionController:self atIndex:index];
  // cell.contentView.backgroundColor = sn.randomColor;

  switch (index) {
    case 0:
      cell.label.text = kStringFormat(@"%02li 测试RACCommand", index);
      break;

    default:
      cell.label.text = kStringFormat(@"%02li", index);
      break;
  }

  return cell;
}

- (void)didUpdateToObject:(id)object {
  // 官方推荐 , 追踪错误宏
  // NSParameterAssert([object isKindOfClass:[LabelsItem class]]);
  self.object = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
  // NSLog(@"%s", __func__);
  // [self entry:index];
  [self performSelector:NSSelectorFromString(kStringFormat(@"entry%li", index))];
}

#pragma mark - <IGListWorkingRangeDelegate>

- (void)listAdapter:(IGListAdapter *)listAdapter sectionControllerWillEnterWorkingRange:(IGListSectionController *)sectionController {

}

- (void)listAdapter:(IGListAdapter *)listAdapter sectionControllerDidExitWorkingRange:(IGListSectionController *)sectionController {

}

- (void)entry0 {

  RACCommand *command = [RACCommand.alloc initWithSignalBlock:^RACSignal *(id input) {
    NSLog(@"参数 = %@", input);
    return [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {

      setTimeout(self, ^(dispatch_source_t timer) {
        [subscriber sendNext:kStringFormat(@"根据参数请求数据, 返回结果 \"%@\"", sn.randomString)];
        [subscriber sendCompleted];
      }, 2000);

      return [RACDisposable disposableWithBlock:^{ /** NSLog(@"销毁 %s", __func__); */ }];;
    }];
  }];

  // 监听事件, 跳过第一次, 因为默认发送未开始信号
  [[command.executing skip:1] subscribeNext:^(NSNumber *x) {
    if ([x boolValue]) {
      NSLog(@"网络请求执行中...");
    } else {
      NSLog(@"网络请求结束 或者 还没开始");
    }
  }];

  // command.executionSignals.switchToLatest 直接获取command包装的信号
  [command.executionSignals.switchToLatest subscribeNext:^(id x) {
    NSLog(@"x class = %@", [x valueForKeyPath:@"isa"]);
    NSLog(@"接收到 x = %@", x);
  }];

  [command execute:@"http://www.baidu.com"];
}


@end

#pragma clang diagnostic pop