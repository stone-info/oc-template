//
//  SNUserApi.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNPostApi.h"

@implementation SNPostApi


- (instancetype)init {
  self = [super init];
  if (self) {

  }
  return self;
}

- (NSString *)requestUrl {
  // “ http://www.yuantiku.com ” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
  return @"http://jsonplaceholder.typicode.com/posts";
}

- (YTKRequestMethod)requestMethod {
  return YTKRequestMethodGET;
  // return YTKRequestMethodPOST;
}

// - (id)requestArgument {
//
//   NSMutableDictionary *parameters = [self addExtraParam:nil];
//
//   return parameters;
// }

@end
