//
//  SomeHTTPManager.h
//  objc_template
//
//  Created by stone on 2019/3/31.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNHTTPManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SomeHTTPManager : SNHTTPManager

//posts  http://jsonplaceholder.typicode.com/posts

+ (void)postsWithCompleted:(void (^)(NSString *jsonString, NSError *error))completed;

@end

NS_ASSUME_NONNULL_END
