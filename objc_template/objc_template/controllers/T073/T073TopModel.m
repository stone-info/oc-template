//
// Created by stone on 2019-05-12.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "T073TopModel.h"

@interface T073TopModel ()

@end

@implementation T073TopModel {}

- (instancetype)initWithTitle:(NSString *)title height:(CGFloat)height dataList:(NSArray *)dataList {
  self = [super init];
  if (self) {
    self.title    = title;
    self.height   = height;
    self.dataList = dataList;
  }
  return self;
}

- (instancetype)initWithTitle:(NSString *)title height:(CGFloat)height {
  self = [super init];
  if (self) {
    self.title    = title;
    self.height   = height;
    self.dataList = nil;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  return [self isEqual:other];
}

@end