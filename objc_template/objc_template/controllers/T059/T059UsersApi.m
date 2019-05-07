//
//  T059UsersApi.m
//  objc_template
//
//  Created by stone on 2019-05-07.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T059UsersApi.h"

@implementation T059UsersApi

- (instancetype)initWithUrlString:(NSString *)urlString {
  self = [super init];
  if (self) {
    self.urlString = urlString;
  }

  return self;
}

+ (instancetype)apiWithUrlString:(NSString *)urlString {
  return [[self alloc] initWithUrlString:urlString];
}

// http://jsonplaceholder.typicode.com/users

- (NSString *)requestUrl {

  // return @"http://jsonplaceholder.typicode.com/users";
  return self.urlString;
}

- (YTKRequestMethod)requestMethod {
  return YTKRequestMethodGET;
  // return YTKRequestMethodPOST;
}

- (id)requestArgument {
  return nil;
}

@end
