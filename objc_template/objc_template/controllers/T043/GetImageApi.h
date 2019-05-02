//
//  GetImageApi.h
//  objc_template
//
//  Created by stone on 2019/4/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import <YTKNetwork/YTKNetwork.h>

NS_ASSUME_NONNULL_BEGIN

@interface GetImageApi : YTKRequest
- (id)initWithImageId:(NSString *)imageId;
@end

NS_ASSUME_NONNULL_END
