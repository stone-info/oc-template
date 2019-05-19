//
// Created by stone on 2019-05-20.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "T082TestViewModel.h"

@interface T082TestViewModel ()

@end

@implementation T082TestViewModel
- (instancetype)init {
  self = [super init];
  if (self) {
    [self initSignal];
  }
  return self;
}

- (void)initSignal {
  self.subject = [RACSubject subject];
}

@end