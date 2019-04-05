//
//  SNScrollView.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNScrollView.h"
#import "SNAttributesHandler.h"

@interface SNScrollView ()


@end

@implementation SNScrollView

+ (instancetype)makeScrollView {

  return [self makeScrollViewWithOptions:@{@"borderColor": HexRGBA(@"#CCCCCC", 1.0), @"borderWidth": @1}];;
}

+ (instancetype)makeScrollViewWithOptions:(NSDictionary *)options {
  SNScrollView *view;

  if (options[@"frame"]) {
    view = [[SNScrollView alloc] initWithFrame:[options[@"frame"] CGRectValue]];
  }else{
    view = [[SNScrollView alloc] init];
  }

  for (NSString *key in options) {
    id obj = options[key];
    [SNAttributesHandler commonAttributes:view key:key obj:obj];
    [SNAttributesHandler featureAttributeWithScrollView:view key:key obj:obj];
  }

  // frame 会更改 contentOffset的值得
  // 初始化设置的时候好像不起作用...view添加到父view之后才起作用
  // 坑爹好多属性都能覆盖contentOffset初始值, 最下面再设置...
  if (options[@"contentOffset"]) {
    view.contentOffset = [options[@"contentOffset"] CGPointValue];
  }

  return view;
}
@end
