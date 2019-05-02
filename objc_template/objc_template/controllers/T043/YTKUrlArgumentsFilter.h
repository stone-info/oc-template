//
//  YTKUrlArgumentsFilter.h
//  objc_template
//
//  Created by stone on 2019/4/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YTKNetwork/YTKNetworkConfig.h>

NS_ASSUME_NONNULL_BEGIN

// YTKUrlArgumentsFilter.h
// 实现自己的 URL 拼接工具类
@interface YTKUrlArgumentsFilter : NSObject <YTKUrlFilterProtocol>

+ (YTKUrlArgumentsFilter *)filterWithArguments:(NSDictionary *)arguments;

- (NSString *)filterUrl:(NSString *)originUrl withRequest:(YTKBaseRequest *)request;

@end

NS_ASSUME_NONNULL_END
