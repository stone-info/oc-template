//
//  UserViewModel.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import "UserViewModel.h"

@interface UserViewModel ()

@end

@implementation UserViewModel

- (instancetype)initWithUsername:(NSString *)username timestamp:(NSString *)timestamp {
  self = [super init];
  if (self) {
    self.username  = username;
    self.timestamp = timestamp;
  }

  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return @"user";
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {

  // other 不存在
  if (!other) { return NO; }
  // other 存在 且 全等
  if (self == other) { return YES; }
  // other 存在 指针不同, 使用diff算法
  UserViewModel *model = (UserViewModel *) other;
  return [self.username isEqualToString:model.username] && [self.timestamp isEqualToString:model.timestamp];
}


@end
