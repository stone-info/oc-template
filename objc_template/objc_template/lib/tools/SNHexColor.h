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
+ (UIColor *)hexColorWithHex:(NSString *)hex;
+ (UIColor *)hexColorWithHex:(NSString *)hex alpha:(CGFloat)alpha;
@end

NS_ASSUME_NONNULL_END

//HexRGBA\(0x([0-9a-zA-Z]+),([ 0-9.]+)\);

//HexRGBA\(@"#$1",$2\);
