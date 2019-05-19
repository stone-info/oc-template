//
//  T081TopModel.m
//  objc_template
//
//  Created by stone on 2019-05-19.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T081TopModel.h"

@interface T081TopModel ()



@end

@implementation T081TopModel

- (instancetype)initWithIdentifier:(NSString *)identifier {
  self = [super init];
  if (self) {
    self.identifier = identifier;
  }
  return self;
}

+ (instancetype)modelWithIdentifier:(NSString *)identifier {
  return [[self alloc] initWithIdentifier:identifier];
}

- (nonnull id <NSObject>)diffIdentifier {
  return self.identifier;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  // YES 表示相等 , 不更新 即便 0 != 1 , 手动告诉diff算法 这是相等的

  // other 不存在
  if (!other) { return NO; }
  // other 存在 且 全等 , 全等是默认判断的 , 如果只修改对象里的 属性不会更新, 所以NSCopying 是好的选择
  if (self == other) { return YES; }
  // other 存在 且 self.identifier 相同, 使用diff算法
  T081TopModel *model = (T081TopModel *) other;
  // 元素和下标相等就相等
  return [self isEqual:model];
  // return [self.name isEqualToString:model.name] && self.age == model.age;
  // return [self isEqual:other];
  // return [self.user isEqualToDiffableObject:other.user] && [self.comments isEqualToArray:other.comments];
  // return [self.name isEqualToString:[other name]] && [self.handle isEqualToString:[other handle]];
}

@end
