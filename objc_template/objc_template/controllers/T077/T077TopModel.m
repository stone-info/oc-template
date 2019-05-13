//
//  T077TopModel.m
//  objc_template
//
//  Created by stone on 2019-05-13.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T077TopModel.h"

@interface T077TopModel ()

@property (copy, nonatomic) NSString *identifier;

@end

@implementation T077TopModel

- (id)copyWithZone:(nullable NSZone *)zone {

  T077TopModel *model = [[[self class] allocWithZone:zone] init];

  model.identifier = self.identifier;

  model.dataList = self.dataList;

  return model;
}

- (instancetype)initWithIdentifier:(NSString *)identifier dataList:(NSArray *)dataList {
  self = [super init];
  if (self) {
    self.identifier = identifier;
    self.dataList   = dataList;
  }

  return self;
}

+ (instancetype)modelWithIdentifier:(NSString *)identifier dataList:(NSArray *)dataList {
  return [[self alloc] initWithIdentifier:identifier dataList:dataList];
}

- (nonnull id <NSObject>)diffIdentifier {
  return self.identifier;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  // YES 表示相等 , 不更新 即便 0 != 1 , 手动告诉diff算法 这是相等的

  // other 不存在
  if (!other) { return NO; }
  // other 存在 且 全等
  if (self == other) { return YES; }
  // other 存在 且 self.identifier 相同, 使用diff算法
  T077TopModel *model = (T077TopModel *) other;
  // 元素和下标相等就相等
  return [self.dataList isEqualToArray:model.dataList];
  // return [self isEqual:other];
  // return [self.user isEqualToDiffableObject:other.user] && [self.comments isEqualToArray:other.comments];
  // return [self.name isEqualToString:[other name]] && [self.handle isEqualToString:[other handle]];
}

@end
