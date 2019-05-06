//
//  T053ColorDiffModel.m
//  objc_template
//
//  Created by stone on 2019-05-05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T053ColorDiffModel.h"

@interface T053ColorDiffModel ()


@end

@implementation T053ColorDiffModel

- (instancetype)initWithColor:(UIColor *)color index:(NSInteger)index {
  self = [super init];
  if (self) {
    self.color = color;
    self.index = index;
  }

  return self;
}

+ (instancetype)modelWithColor:(UIColor *)color index:(NSInteger)index {
  return [[self alloc] initWithColor:color index:index];
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
  T053ColorDiffModel *model = (T053ColorDiffModel *) other;
  return [self isEqual:other] && self.index == model.index;
}


@end
