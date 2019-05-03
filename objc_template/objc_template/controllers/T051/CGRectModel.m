//
// Created by stone on 2019-05-03.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "CGRectModel.h"

@interface CGRectModel ()

@property (assign, nonatomic) CGRect rect;

@end

@implementation CGRectModel {}

- (instancetype)initWithRect:(CGRect)rect {
  self = [super init];
  if (self) {
    self.rect = rect;
  }
  return self;
}

// divided : adj. 分离的;被分割的;分裂的
- (NSDictionary<NSString *, NSValue *> *)dividedWithAmout:(CGFloat)amout edge:(CGRectEdge)edge {

  CGRect slice;
  CGRect reminder;

  CGRectDivide(self.rect, &slice, &reminder, amout, edge);

  return @{
    @"slice"   : [NSValue valueWithCGRect:slice],
    @"reminder": [NSValue valueWithCGRect:reminder],
  };
}

- (NSDictionary<NSString *, NSValue *> *)dividedWithPadding:(CGFloat)padding amout:(CGFloat)amout edge:(CGRectEdge)edge {

  CGRect slice;
  CGRect reminder;
  CGRect tmpSlcie;

  CGRectDivide(self.rect, &slice, &reminder, amout, edge);
  CGRectDivide(reminder, &tmpSlcie, &reminder, padding, edge);

  return @{
    @"slice"   : [NSValue valueWithCGRect:slice],
    @"reminder": [NSValue valueWithCGRect:reminder],
  };
}


@end