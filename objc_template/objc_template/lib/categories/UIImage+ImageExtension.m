//
//  UIImage+SNWatermark.m
//  006_UIAdvanced
//
//  Created by stone on 2018/7/31.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "UIImage+ImageExtension.h"

@implementation UIImage (ImageExtension)
// 使用例子
// UIImage *image = [UIImage imageNamed:@"temp"];
//
// UIImage *newImage = [image watermarkWithCallback:^{
//   NSString *string = @"hello world";
//   [string drawAtPoint:CGPointMake(10, 20)
//        withAttributes:@{
//          NSFontAttributeName           : kPingFangSCRegular(16),
//          NSForegroundColorAttributeName: [UIColor redColor],
//          NSBackgroundColorAttributeName: [UIColor yellowColor]
//        }];
// }];
- (instancetype)watermarkWithCallback:(void (^)(void))callback {
  UIImage *image = self;
  UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
  [image drawAtPoint:CGPointZero];
  callback();
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
}
- (instancetype)borderCircleImageWithBorderWidth:(CGFloat)borderWidth
                                     borderColor:(UIColor *)borderColor {

  // if (self.size.width != self.size.height) {
  //
  // }

  CGFloat radius = MIN(self.size.width, self.size.height) * 0.5;
  CGSize size = CGSizeMake((radius + borderWidth) * 2, (radius + borderWidth) * 2);

  UIGraphicsBeginImageContextWithOptions(size, NO, 0);
  {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width * 0.5, size.height * 0.5)
                                                        radius:size.width * 0.5
                                                    startAngle:kDegreesToRadian(0)
                                                      endAngle:kDegreesToRadian(360)
                                                     clockwise:YES];
    // UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, size.height)];
    [borderColor set];
    [path fill];
  }

  {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(size.width * 0.5, size.height * 0.5)
                                                        radius:size.width * 0.5 - borderWidth
                                                    startAngle:kDegreesToRadian(0)
                                                      endAngle:kDegreesToRadian(360)
                                                     clockwise:YES];
    // UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderWidth, borderWidth, self.size.width, self.size.height)];
    [path addClip];
  }

  // [self drawAtPoint:CGPointMake(borderWidth, borderWidth)];
  [self drawAtPoint:CGPointMake(borderWidth-(self.size.width*0.5-radius), borderWidth-(self.size.height*0.5-radius))];

  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();

  UIGraphicsEndImageContext();

  return newImage;
}
@end


@implementation UIImage (StretchExtentsion)
+ (instancetype)resizableImageWithLocalImageName:(NSString *)localImageName {
  UIImage *image = [UIImage imageNamed:localImageName];
  CGFloat imageWidth  = image.size.width;
  CGFloat imageHeight = image.size.height;

  return [image stretchableImageWithLeftCapWidth:(NSInteger) (imageWidth * 0.5) topCapHeight:(NSInteger) (imageHeight * 0.5)];
}
@end
