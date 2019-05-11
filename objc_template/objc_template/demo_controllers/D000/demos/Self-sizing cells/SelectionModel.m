//
//  SelectionModel.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SelectionModel.h"

@interface SelectionModel ()



@end

@implementation SelectionModel

- (instancetype)initWithOptions:(NSArray<NSString *> *)options{
  self = [super init];
  if (self) {
    self.options = options;
    self.type = SelectionModelTypeNone;
  }
  return self;
}

- (instancetype)initWithOptions:(NSArray<NSString *> *)options type:(SelectionModelType)type {
  self = [super init];
  if (self) {
    self.options = options;
    self.type = type;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {

  // other 不存在
  if (!other) { return NO; }
  // other 存在 且 全等
  if (self == other) { return YES; }
  // other 存在 指针不同, 使用diff算法
  return [self isEqual:other];
  // return [self.user isEqualToDiffableObject:other.user] && [self.comments isEqualToArray:other.comments];
  // return [self.name isEqualToString:[other name]] && [self.handle isEqualToString:[other handle]];
}


@end
