//
//  T082TestCell.m
//  objc_template
//
//  Created by stone on 2019-05-20.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T082TestCell.h"
#import "T082TestViewModel.h"

@interface T082TestCell ()


@end

@implementation T082TestCell

- (T082TestViewModel *)viewModel {
  if (_viewModel == nil) {
    _viewModel = [T082TestViewModel new];
  }
  return _viewModel;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    UILabel *label = makeLabel(NO);
    self.label = label;
    [self.contentView addSubview:label];
    kMasKey(label);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.offset(0);
      make.left.offset(0);
      make.right.offset(0);
      make.height.mas_equalTo(30);
    }];

    UIButton *button = makeButton(NO);
    self.button = button;
    [self.contentView addSubview:button];
    kMasKey(button);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(label.mas_bottom).offset(0);
      make.left.offset(0);
      make.right.offset(0);
      make.height.mas_equalTo(30);
    }];

    [self subscriptionSignal];
  }
  return self;
}

- (void)subscriptionSignal {

  [self.viewModel.subject subscribeNext:^(id x) {
    NSLog(@"x class = %@ | x = %@", [x valueForKeyPath:@"isa"], x);
    kToast(nil, kStringFormat(@"x = %@", x));
  }];

  [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *x) {
    [self.viewModel.subject sendNext:@"hello world"];
  }];

}

- (void)layoutSubviews {
  [super layoutSubviews];

}

@end
