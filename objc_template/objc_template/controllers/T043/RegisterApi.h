//
//  RegisterApi.h
//  objc_template
//
//  Created by stone on 2019/4/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface RegisterApi : YTKRequest

- (id)initWithUsername:(NSString *)username password:(NSString *)password;

- (NSString *)userId;
@end

NS_ASSUME_NONNULL_END
