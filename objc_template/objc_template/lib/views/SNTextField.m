//
//  SNTextField.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNTextField.h"
#import "SNAttributesHandler.h"

@implementation SNTextField
+ (instancetype)makeTextField {
  return self.new;;
}

+ (instancetype)makeTextFieldWithOptions:(NSDictionary *)options {
  SNTextField *view;

  if (options[@"frame"]) {
    view = [[SNTextField alloc] initWithFrame:[options[@"frame"] CGRectValue]];
  } else {
    view = [[SNTextField alloc] init];
  }

  for (NSString *key in options) {
    id obj = options[key];
    [SNAttributesHandler commonAttributes:view key:key obj:obj];
    [SNAttributesHandler featureAttributeWithTextField:view key:key obj:obj];
  }

  return view;
}


@end
