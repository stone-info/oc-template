//
//  GetUserInfoApi.m
//  objc_template
//
//  Created by stone on 2019/4/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "GetUserInfoApi.h"

@implementation GetUserInfoApi {
  NSString *_userId;
}

- (id)initWithUserId:(NSString *)userId {
  self = [super init];
  if (self) {
    _userId = userId;
  }
  return self;
}

- (NSString *)requestUrl {
  return @"/users";
}

- (id)requestArgument {
  return @{ @"id" : _userId };
}

- (id)jsonValidator {
  return @{ @"message" : [NSString class] };
}

- (NSInteger)cacheTimeInSeconds {
  // 3 分钟 = 180 秒
  return 60 * 3;
}

@end
