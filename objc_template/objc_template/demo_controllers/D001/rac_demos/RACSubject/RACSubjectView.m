//
// Created by stone on 2019-05-11.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "RACSubjectView.h"

@interface RACSubjectView ()

@end

@implementation RACSubjectView {}

- (RACSubject *)buttonClickSignal {

  if (_buttonClickSignal == nil) {
    _buttonClickSignal = [RACSubject subject];

  }
  return _buttonClickSignal;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    self.backgroundColor = UIColor.whiteColor;
    kBorder(self);

    UIButton *button = makeButton(YES);
    [self addSubview:button];
    kMasKey(button);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.offset(10);
      make.left.offset(10);
      make.right.offset(-10);
      make.height.mas_greaterThanOrEqualTo(50);
    }];
    [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
  }
  return self;
}

- (void)btnClicked:(UIButton *)sender {

  // !self.buttonClickSignal ?: [self.buttonClickSignal sendNext:@"button clicked"];
  !self.buttonClickSignal ?: [self.buttonClickSignal sendNext:sn.randomColor];

  [self hello:@"hello worl"];
}

- (void)hello:(NSString *)say {
  NSLog(@"say = %@", say);
}

@end