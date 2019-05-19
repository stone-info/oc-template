//
// Created by stone on 2019-05-12.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "SNUserModel.h"

@implementation SNUserModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
  return @{@"ID": @"id"};
}

- (nonnull id <NSObject>)diffIdentifier {
  // list bind section controller  一个section 带 n 个 item
  // SNUserModel 和 每一个 item 绑定 , 因此根据 diff算法的协议, 必须得有唯一的标识符
  // 如果是 一个模型 绑定一个 section的话 , 唯一标识符 重复了也没事 , 因为 section controller 只关心 一个 section,
  //
  return self.name;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  if (!other) { return NO; }
  if (self == other) { return YES; }
  SNUserModel *model = (SNUserModel *) other;
  return
    self.ID == model.ID &&
    [self.name isEqualToString:model.name] &&
    [self.username isEqualToString:model.username] &&
    [self.email isEqualToString:model.email] &&
    [self.phone isEqualToString:model.phone] &&
    [self.website isEqualToString:model.website] &&
    [self.address isEqualToDiffableObject:model.address] &&
    [self.company isEqualToDiffableObject:model.company];
}
@end

@implementation SNGeo
- (nonnull id <NSObject>)diffIdentifier {
  return @"geo";
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {

  if (!other) { return NO; }
  if (self == other) { return YES; }
  SNGeo *model = (SNGeo *) other;
  return
    [self.lat isEqualToString:model.lat] &&
    [self.lng isEqualToString:model.lng];
}

@end

@implementation SNAddress

- (nonnull id <NSObject>)diffIdentifier {
  return @"address";
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  if (!other) { return NO; }
  if (self == other) { return YES; }
  SNAddress *model = (SNAddress *) other;

  // @property (nonatomic, copy) NSString *street;
  // @property (nonatomic, copy) NSString *suite;
  // @property (nonatomic, copy) NSString *city;
  // @property (nonatomic, copy) NSString *zipcode;
  // @property (nonatomic, strong) SNGeo  *geo;

  return
    [self.street isEqualToString:model.street] &&
    [self.suite isEqualToString:model.suite] &&
    [self.city isEqualToString:model.city] &&
    [self.zipcode isEqualToString:model.zipcode] &&
    [self.geo isEqualToDiffableObject:model.geo];
}
@end

@implementation SNCompany
- (nonnull id <NSObject>)diffIdentifier {
  return @"company";
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  if (!other) { return NO; }
  if (self == other) { return YES; }
  SNCompany *model = (SNCompany *) other;
  return
    [self.name isEqualToString:model.name] &&
    [self.bs isEqualToString:model.bs] &&
    [self.catchPhrase isEqualToString:model.catchPhrase];
}

@end
