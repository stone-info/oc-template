//
//  SNUserApi.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNUserApi.h"
// #import "YJCommonParams.h"

@implementation SNUserApi

// - (NSMutableDictionary *)addExtraParam:(nullable NSDictionary *)params {
//   NSMutableDictionary *newParam;
//   if (params) {
//     newParam = [NSMutableDictionary dictionaryWithDictionary:params];
//   } else {
//     newParam = [NSMutableDictionary dictionary];
//   }
//
//   [newParam setValue:[YJCommonParams getVer] forKey:@"ver"];
//   [newParam setValue:[YJCommonParams getAgrtver] forKey:@"agrtver"];
//   [newParam setValue:[YJCommonParams getChannel] forKey:@"channel"];
//   [newParam setValue:[YJCommonParams getCt] forKey:@"ct"];
//   [newParam setValue:[YJCommonParams getTs] forKey:@"ts"];
//   if ([YJCommonParams getToken].length > 0) {
//     [newParam setValue:[YJCommonParams getToken] forKey:@"token"];
//   }
//   return newParam;
// }

- (instancetype)init {
  self = [super init];
  if (self) {

  }
  return self;
}

- (NSString *)requestUrl {
  // “ http://www.yuantiku.com ” 在 YTKNetworkConfig 中设置，这里只填除去域名剩余的网址信息
  return @"http://jsonplaceholder.typicode.com/users";
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
