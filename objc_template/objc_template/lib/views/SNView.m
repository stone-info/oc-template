//
//  SNView.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNView.h"
#import "SNAttributesHandler.h"

@interface SNView ()


@end

@implementation SNView

+ (instancetype)makeView {
  
  return [self makeViewWithOptions:@{@"borderColor": HexRGBA(0xCCCCCC, 1.0), @"borderWidth": @1}];;
}

+ (instancetype)makeViewWithOptions:(NSDictionary *)options {

  SNView *view;

  if (options[@"frame"]) {
    view = [[SNView alloc] initWithFrame:[options[@"frame"] CGRectValue]];
  } else {
    view = [[SNView alloc] init];
  }

  for (NSString *key in options) {
    id obj = options[key];
    [SNAttributesHandler commonAttributes:view key:key obj:obj];
    [SNAttributesHandler featureAttributeWithView:view key:key obj:obj];
  }

  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapHandle:)];
  [view addGestureRecognizer:tap];
  return view;
}

- (void)setAction:(void (^)(UITapGestureRecognizer *))action {
  _action = action;
  self.userInteractionEnabled = YES;
}

- (void)tapHandle:(UITapGestureRecognizer *)sender {
  // NSLog(@"%s", __func__);
  !self.action ?: self.action(sender);
}

@end
