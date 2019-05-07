//
//  T059UsersApi.h
//  objc_template
//
//  Created by stone on 2019-05-07.
//  Copyright © 2019 stone. All rights reserved.
//


#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface T059UsersApi : YTKRequest
@property (copy, nonatomic) NSString *urlString;

- (instancetype)initWithUrlString:(NSString *)urlString;

+ (instancetype)apiWithUrlString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END