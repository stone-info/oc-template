//
//  T072UserModel.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T072UserModel.h"

@interface T072UserModel ()

@end

@implementation T072UserModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
  return @{@"ID": @"id"};
}

- (nonnull id <NSObject>)diffIdentifier {
  return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  if (!other) { return NO; }
  if (self == other) { return YES; }
  T072UserModel *model = (T072UserModel *) other;
  return self.ID == model.ID &&
         [self.name isEqualToString:model.name] &&
         [self.username isEqualToString:model.username] &&
         [self.email isEqualToString:model.email] &&
         [self.phone isEqualToString:model.phone] &&
         [self.website isEqualToString:model.website] &&
         [self.address isEqualToDiffableObject:model.address] &&
         [self.company isEqualToDiffableObject:model.company];
}


@end

@implementation T072Geo
- (nonnull id <NSObject>)diffIdentifier {
  return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  if (!other) { return NO; }
  if (self == other) { return YES; }
  T072Geo *model = (T072Geo *) other;
  return [self.lat isEqualToString:model.lat] &&
         [self.lng isEqualToString:model.lng];
}


@end

@implementation T072Address
- (nonnull id <NSObject>)diffIdentifier {
  return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  if (!other) { return NO; }
  if (self == other) { return YES; }
  T072Address *model = (T072Address *) other;
  return [self.street isEqualToString:model.street] &&
         [self.suite isEqualToString:model.suite] &&
         [self.city isEqualToString:model.city] &&
         [self.zipcode isEqualToString:model.zipcode] &&
         [self.geo isEqualToDiffableObject:model.geo];
}


@end

@implementation T072Company
- (nonnull id <NSObject>)diffIdentifier {
  return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  if (!other) { return NO; }
  if (self == other) { return YES; }
  T072Company *model = (T072Company *) other;
  return [self.name isEqualToString:model.name] &&
         [self.catchPhrase isEqualToString:model.catchPhrase] &&
         [self.bs isEqualToString:model.bs];
}


@end