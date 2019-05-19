//
// Created by stone on 2019-05-18.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "T80PostTopModel.h"

@interface T80PostTopModel ()

@end

@implementation T80PostTopModel {}

- (instancetype)initWithUsername:(NSString *)username timestamp:(NSString *)timestamp imageURL:(NSURL *)imageURL likes:(NSInteger)likes comments:(NSArray<T80Comment *> *)comments {
  self = [super init];
  if (self) {
    self.username  = username;
    self.timestamp = timestamp;
    self.imageURL  = imageURL;
    self.likes     = likes;
    self.comments  = comments;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return kStringFormat(@"%@%@", _username, _timestamp);
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {

  return YES;
}

@end