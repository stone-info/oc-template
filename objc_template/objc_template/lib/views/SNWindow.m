//
//  SNWindow.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNWindow.h"

@implementation SNWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {

  // NSLogPoint(point);

  UIView *view = nil;

  { view = [super hitTest:point withEvent:event]; }

  {
    // view = kCreateObjectWithString(@"OneView");
  }

  // NSLog(@"最适合的view %@", view);

  return view;
}
@end
