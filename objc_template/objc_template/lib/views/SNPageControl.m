//
//  SNPageControl.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNPageControl.h"
#import "SNAttributesHandler.h"

@interface SNPageControl ()

@end

@implementation SNPageControl
+ (instancetype)makePageControl {
  return nil;
}

+ (instancetype)makePageControlWithOptions:(NSDictionary *)options {

  SNPageControl *view;

  if (options[@"frame"]) {
    view = [[SNPageControl alloc] initWithFrame:[options[@"frame"] CGRectValue]];
  } else {
    view = [[SNPageControl alloc] init];
  }

  for (NSString *key in options) {
    id obj = options[key];
    [SNAttributesHandler commonAttributes:view key:key obj:obj];
    [SNAttributesHandler featureAttributeWithPageControl:view key:key obj:obj];
  }

  return view;

}


@end
