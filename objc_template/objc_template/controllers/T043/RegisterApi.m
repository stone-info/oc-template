//
//  RegisterApi.m
//  objc_template
//
//  Created by stone on 2019/4/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "RegisterApi.h"

@implementation RegisterApi {
  NSString *_username;
  NSString *_password;
}

- (id)initWithUsername:(NSString *)username password:(NSString *)password {
  self = [super init];
  if (self) {
    _username = username;
    _password = password;
  }
  return self;
}

- (NSString *)requestUrl {
  // “ http://www.yuantiku.com ” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
  return @"/iphone/register";
}

- (YTKRequestMethod)requestMethod {
  return YTKRequestMethodPOST;
}

- (id)requestArgument {
  return @{@"username": _username, @"password": _password};
}

- (id)jsonValidator {
  return @{
    @"userId": [NSNumber class]
  };
}

- (NSString *)userId {
  return [[[self responseJSONObject] objectForKey:@"userId"] stringValue];
}


@end
