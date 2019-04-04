//
//  SNTableView.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNTableView.h"
#import "SNAttributesHandler.h"

@interface SNTableView ()


@end

@implementation SNTableView
+ (instancetype)makeTableView {
  return [self makeTableViewWithOptions:@{@"borderColor": HexRGBA(0xCCCCCC, 1.0), @"borderWidth": @1}];;
}

+ (instancetype)makeTableViewWithOptions:(NSDictionary *)options {

  SNTableView *view;

  if (options[@"frame"]) {
    if (options[@"style"]) {
      view = [[SNTableView alloc] initWithFrame:[options[@"frame"] CGRectValue] style:(UITableViewStyle) [options[@"style"] integerValue]];
    } else {
      view = [[SNTableView alloc] initWithFrame:[options[@"frame"] CGRectValue]];
    }
  } else {
    view = [[SNTableView alloc] init];
  }

  view.options = options;

  if (@available(iOS 11.0, *)) {
    // 取消自动调整内边距
    view.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  } else {
    // view.automaticallyAdjustsScrollViewInsets = NO;
    view.viewController.automaticallyAdjustsScrollViewInsets = NO;
  }

  for (NSString *key in options) {
    id obj = options[key];
    [SNAttributesHandler commonAttributes:view key:key obj:obj];
    [SNAttributesHandler featureAttributeWithTableView:view key:key obj:obj];
  }

  if (options[@"contentOffset"]) {
    view.contentOffset = [options[@"contentOffset"] CGPointValue];
  }

  return view;
}


@end
