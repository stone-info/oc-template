//
//  UINavigationBar+SNBackground.m
//  006_UIAdvanced
//
//  Created by stone on 2018/7/30.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "UINavigationBar+NavgationBarExtension.h"

@implementation UINavigationBar (NavgationBarExtension)
- (void)setBackgroundColor:(UIColor*)color{
  UIImage*image =   [self imageWithColor:color];
  [self setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}
- (void)hideBackgroundView{
  [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
}
- (void)hideSeparatorLineView{
  [self setShadowImage:[[UIImage alloc] init]];
}
/** 16进制(字符串形式) 返回 图片 */
- (UIImage *)imageWithString:(NSString *)string {
  
  return [self imageWithColor:[self colorWithString:string]];
}
/** 16进制返回颜色 */
- (UIColor *)colorWithString:(NSString *)string {
  CGFloat alpha = 1.0f;
  NSNumber * red = @0.0;
  NSNumber * green = @0.0;
  NSNumber * blue = @0.0;
  
  NSMutableArray<NSNumber *> * colors = [NSMutableArray arrayWithArray:@[ red, green, blue ]];
  
  unsigned hexComponent;
  NSString * colorString = [string uppercaseString];
  NSLog(@"%ld", colors.count);
  for (int i = 0; i < colors.count; i++) {
    NSString * substring = [colorString substringWithRange:NSMakeRange(i * 2, 2)];
    
    [[NSScanner scannerWithString:substring] scanHexInt:&hexComponent];
    
    NSNumber * temp = colors[i];
    temp = @(hexComponent / 255.0);
    colors[i] = temp;
  }
  
  return [UIColor colorWithRed:[colors[0] floatValue] green:[colors[1] floatValue] blue:[colors[2] floatValue] alpha:alpha];
}
/** 颜色 返回 图片 */
- (UIImage *)imageWithColor:(UIColor *)color {
  
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  
  UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  return image;
}
@end
