//
//  SNHexColor.h
//  objc_template
//
//  Created by stone on 2019/4/6.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNHexColor : UIColor
+ (instancetype)hexColorWithHex:(NSString *)hex;
+ (instancetype)hexColorWithHex:(NSString *)hex alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END
