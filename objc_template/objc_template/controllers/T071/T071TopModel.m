//
//  T071TopModel.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T071TopModel.h"

@interface T071TopModel ()

@end

@implementation T071TopModel

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

- (instancetype)init {
  self = [super init];
  if (self) {

  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  // YES 表示相等 , 不更新 即便 0 != 1 , 手动告诉diff算法 这是相等的

  // other 不存在
  if (!other) { return NO; }
  // other 存在 且 全等
  if (self == other) { return YES; }
  // other 存在 指针不同, 使用diff算法
  T071TopModel *model = (T071TopModel *) other;
  return [self.title isEqualToString:model.title] && self.height == model.height && [self.dataList isEqualToArray:model.dataList];
}


@end
