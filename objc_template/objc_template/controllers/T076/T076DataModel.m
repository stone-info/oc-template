//
//  T076DataModel.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T076DataModel.h"

@interface T076DataModel ()

@property (copy, nonatomic) NSString *identifier;

@end

@implementation T076DataModel

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age identifier:(NSString *)identifier {

  self = [super init];

  if (self) {
    self.name       = name;
    self.age        = age;
    self.identifier = identifier;
  }

  return self;
}

+ (instancetype)modelWithName:(NSString *)name age:(NSInteger)age identifier:(NSString *)identifier {
  return [[self alloc] initWithName:name age:age identifier:identifier];
}

- (nonnull id <NSObject>)diffIdentifier {
  return self.identifier;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  // other 不存在
  if (!other) { return NO; }
  // other 存在 且 全等
  if (self == other) { return YES; }
  // other 存在 且 self.identifier 相同, 使用diff算法
  T076DataModel *model = (T076DataModel *) other;
  // 元素和下标相等就相等
  return [self.name isEqualToString:model.name] && self.age == model.age;
}

@end