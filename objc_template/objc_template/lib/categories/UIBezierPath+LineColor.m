//
//  UIBezierPath+SNLineColor.m
//  006_UIAdvanced
//
//  Created by stone on 2018/8/1.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "UIBezierPath+LineColor.h"
#import <objc/runtime.h>

@implementation UIBezierPath (LineColor)
- (UIColor *)lineColor {
  return objc_getAssociatedObject(self, _cmd);
}

- (void)setLineColor:(UIColor *)lineColor {
  objc_setAssociatedObject(self, @selector(lineColor), lineColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
@end
