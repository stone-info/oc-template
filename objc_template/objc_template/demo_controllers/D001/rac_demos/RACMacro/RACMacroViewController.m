//
//  RACMacroViewController.m
//  objc_template
//
//  Created by stone on 2019/5/12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "RACMacroViewController.h"

@interface RACMacroViewController ()

@property (nonatomic, strong) RACSignal *signal;
@end

@implementation RACMacroViewController {
  UITextField *_field;
  UILabel     *_label;
}

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

- (void)dealloc {
  NSLog(@"■■■■■■\t%@ is dead ☠☠☠\t■■■■■■", [self class]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  self.view.backgroundColor = sn.randomColor;
}

- (void)entry {

}

// 宏: RACTuplePack RACTupleUnpack
- (void)entry4 {

  RACTwoTuple *tuple = RACTuplePack(@1, @2);
  NSLog(@"tuple = %@", tuple);

  id o = tuple[0];
  NSLog(@"o = %@", o);

  RACTupleUnpack(NSNumber *a, NSNumber *b) = tuple;

  NSLog(@"a = %@", a);
  NSLog(@"b = %@", b);
}

// 宏: @weakify(self); @strongify(self);
- (void)entry3 {
  // self.view.backgroundColor = UIColor.whiteColor;


  UIButton *button = makeButton(YES);

  [self.view addSubview:button];

  kMasKey(button);
  [button mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  @weakify(self);
  self.signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
    @strongify(self);

    NSLog(@"self = %@", self);
    [subscriber sendNext:@"发送信号"];
    [subscriber sendCompleted];

    return [RACDisposable disposableWithBlock:^{ NSLog(@"销毁 %s", __func__); }];
  }];

  [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *x) {
    @strongify(self);
    [self.signal subscribeNext:^(id x) {
      NSLog(@"接收信号 x = %@", x);
    }];
  }];
}

// 宏: RACObserve
- (void)entry2 {

  RACSignal *racSignal = RACObserve(self.view, backgroundColor);

  [racSignal subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
  }];

}

// 宏: RAC
- (void)entry1 {
  [self addViews];

  // 写法1:
  // [_field.rac_textSignal subscribeNext:^(NSString *x) {
  //   _label.text = x;
  // }];

  // 写法2:
  RAC(_label, text) = _field.rac_textSignal;
}

- (void)addViews {
  _label = makeLabel(YES);
  [self.view addSubview:_label];
  kMasKey(_label);
  [_label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  _field = makeTextField(YES);

  [self.view addSubview:_field];

  [_field mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(_label.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];
}
@end
