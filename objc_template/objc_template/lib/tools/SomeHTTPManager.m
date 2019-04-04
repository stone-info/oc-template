//
//  SomeHTTPManager.m
//  objc_template
//
//  Created by stone on 2019/3/31.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SomeHTTPManager.h"

@implementation SomeHTTPManager

+ (void)postsWithCompleted:(void (^)(NSString *jsonString, NSError *error))completed {
  [self requestWithMethod:GET urlString:@"http://jsonplaceholder.typicode.com/posts" parameters:nil completed:^(NSString *string, NSError *error) {
    completed(string, error);
  }];
}


@end
