//
//  SNHexColor.m
//  objc_template
//
//  Created by stone on 2019/4/6.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNHexColor.h"

@implementation SNHexColor

+ (UIColor *)hexColorWithHex:(NSString *)hex alpha:(CGFloat)alpha {
  
  NSDictionary<NSString *, NSNumber *> *dict = [self transformWithHex:hex];
  
  if (dict) {
    return (SNHexColor *) [[self alloc] initWithRed:[dict[@"red"] floatValue] green:[dict[@"green"] floatValue] blue:[dict[@"blue"] floatValue] alpha:alpha];
  } else {
    return nil;
  }
}

+ (UIColor *)hexColorWithHex:(NSString *)hex {
  
  NSDictionary<NSString *, NSNumber *> *dict = [self transformWithHex:hex];
  if (dict) {
    return (SNHexColor *) [[self alloc] initWithRed:[dict[@"red"] floatValue] green:[dict[@"green"] floatValue] blue:[dict[@"blue"] floatValue] alpha:[dict[@"alpha"] floatValue]];
  } else {
    return nil;
  }
}

+ (NSString *)removeHashIfNecessary:(NSString *)str {
  if ([str hasPrefix:@"#"]) {
    return [str stringByReplacingOccurrencesOfString:@"#" withString:@""];
  } else {
    return str;
  }
}

+ (nullable NSDictionary<NSString *, NSNumber *> *)transformWithHex:(NSString *)hex {
  
  hex = [self removeHashIfNecessary:hex];
  
  UInt32 hexValue = 0;
  
  NSScanner *scanner = [NSScanner scannerWithString:hex];
  BOOL      flag     = [scanner scanHexInt:&hexValue];
  if (!flag) { return nil; }
  
  CGFloat r       = 0.f;
  CGFloat g       = 0.f;
  CGFloat b       = 0.f;
  CGFloat a       = 0.f;
  CGFloat divisor = 0.f;
  
  // RGBshort
  if (hex.length == 3) {
    divisor = 15;
    r       = ((hexValue & 0xF00) >> 8) / divisor;
    g       = ((hexValue & 0x0F0) >> 4) / divisor;
    b       = (hexValue & 0x00F) / divisor;
    a       = 1;
  }
  
  // RGBshortAlpha
  if (hex.length == 4) {
    divisor = 15;
    r       = ((hexValue & 0xF000) >> 12) / divisor;
    g       = ((hexValue & 0x0F00) >> 8) / divisor;
    b       = ((hexValue & 0x00F0) >> 4) / divisor;
    a       = (hexValue & 0x000F) / divisor;
  }
  
  // RGB
  if (hex.length == 6) {
    divisor = 255;
    r       = ((hexValue & 0xFF0000) >> 16) / divisor;
    g       = ((hexValue & 0x00FF00) >> 8) / divisor;
    b       = (hexValue & 0x0000FF) / divisor;
    a       = 1;
  }
  
  // RGBA
  if (hex.length == 8) {
    divisor = 255;
    r       = ((hexValue & 0xFF000000) >> 24) / divisor;
    g       = ((hexValue & 0x00FF0000) >> 16) / divisor;
    b       = ((hexValue & 0x0000FF00) >> 8) / divisor;
    a       = (hexValue & 0x000000FF) / divisor;
  }
  return @{@"red": @(r), @"green": @(g), @"blue": @(b), @"alpha": @(a),};
}
@end
