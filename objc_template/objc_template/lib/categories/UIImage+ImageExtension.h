//
//  UIImage+SNWatermark.h
//  006_UIAdvanced
//
//  Created by stone on 2018/7/31.
//  Copyright © 2018年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ImageExtension)

- (instancetype)watermarkWithCallback:(void (^)(void))callback;

- (instancetype)borderCircleImageWithBorderWidth:(CGFloat)borderWidth
                                     borderColor:(UIColor *)borderColor;
@end


@interface UIImage (StretchExtentsion)
+(instancetype)resizableImageWithLocalImageName:(NSString *)localImageName;
@end
