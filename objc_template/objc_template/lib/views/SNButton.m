//
//  SNButton.m
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNButton.h"
#import "SNAttributesHandler.h"

@interface SNButton ()

@end

@implementation SNButton

+ (instancetype)makeButton {
  return [self makeButtonWithOptions:@{@"borderColor": HexRGBA(0xCCCCCC, 1.0), @"borderWidth": @1}];;
}

+ (instancetype)makeButtonWithOptions:(NSDictionary *)options {

  SNButton *view;

  if (options[@"type"]) {
    view = [SNButton buttonWithType:(UIButtonType) [options[@"type"] integerValue]];
  } else {
    view = [SNButton buttonWithType:UIButtonTypeSystem];
  }

  if (options[@"frame"]) {
    view.frame = [options[@"frame"] CGRectValue];
  }

  if (options[@"type"]) {
    view = [SNButton buttonWithType:(UIButtonType) [options[@"type"] integerValue]];
  } else {
    view = [SNButton buttonWithType:UIButtonTypeSystem];
  }

  for (NSString *key in options) {
    id obj = options[key];
    [SNAttributesHandler commonAttributes:view key:key obj:obj];
    [SNAttributesHandler featureAttributeWithButton:view key:key obj:obj];
  }

  [view addTarget:view action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
  return view;
}

- (void)btnClicked:(SNButton *)sender {
  !self.action ?: self.action(sender);
}


@end
