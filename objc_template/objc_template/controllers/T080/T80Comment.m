//
// Created by stone on 2019-05-18.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "T80Comment.h"

@interface T80Comment ()

@end

@implementation T80Comment {}

- (id)copyWithZone:(nullable NSZone *)zone {

  T80Comment *model = [[[self class] allocWithZone:zone] init];
  model.username = self.username;
  model.text = self.text;
  return model;
}

- (instancetype)initWithUsername:(NSString *)username text:(NSString *)text {
  self = [super init];
  if (self) {
    self.username = username;
    self.text     = text;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  // return kStringFormat(@"%@%@", _username, _text);
  return self.username; // id值 很重要啊 , 如果横等 , 就刷新很快...
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {

  NSLog(@"self.text = %@", self.text);
  // return YES;
  T80Comment *model = (T80Comment *) other;

  NSLog(@"model.text = %@", model.text);
  // 元素和下标相等就相等
  return [self.text isEqualToString:model.text];
}

@end



