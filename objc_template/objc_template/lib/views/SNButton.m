//
//  SNButton.m
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNButton.h"

@interface SNButton ()

@end

@implementation SNButton

+ (instancetype)makeButton {
  return [self makeButtonWithOptions:@{@"borderColor": HexRGBA(0xCCCCCC, 1.0), @"borderWidth": @1}];;
}

+ (instancetype)makeButtonWithOptions:(NSDictionary *)options {

  SNButton *button;
  if (options[@"type"]) {
    button = [SNButton buttonWithType:(UIButtonType) [options[@"type"] integerValue]];
  } else {
    button = [SNButton buttonWithType:UIButtonTypeSystem];
  }

  button.backgroundColor = options[@"backgroundColor"] ? options[@"backgroundColor"] : [UIColor whiteColor];

  // 默认是YES 高亮效果, 取消高亮效果
  if (options[@"adjustsImageWhenHighlighted"]) {
    [button setAdjustsImageWhenHighlighted:[options[@"adjustsImageWhenHighlighted"] boolValue]];
  } else {
    [button setAdjustsImageWhenHighlighted:YES];
  }

  if (options[@"titleNormal"]) { [button setTitle:options[@"titleNormal"] forState:UIControlStateNormal]; }
  if (options[@"titleColorNormal"]) { [button setTitleColor:options[@"titleColorNormal"] forState:UIControlStateNormal]; }
  if (options[@"titleHighlighted"]) { [button setTitle:options[@"titleHighlighted"] forState:UIControlStateHighlighted]; }
  if (options[@"titleColorHighlighted"]) { [button setTitleColor:options[@"titleColorHighlighted"] forState:UIControlStateHighlighted]; }

  if (options[@"font"]) { button.titleLabel.font = options[@"font"]; } else { button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16]; }
  if (options[@"imageNormal"]) { [button setImage:options[@"imageNormal"] forState:UIControlStateNormal]; }
  if (options[@"imageSelected"]) { [button setImage:options[@"imageSelected"] forState:UIControlStateSelected]; }
  if (options[@"imageHighlighted"]) { [button setImage:options[@"imageHighlighted"] forState:UIControlStateHighlighted]; }

  if (options[@"backgroundImageNormal"]) {
    [button setBackgroundImage:options[@"backgroundImageNormal"] forState:UIControlStateNormal];
  }
  if (options[@"backgroundImageSelected"]) {
    [button setBackgroundImage:options[@"backgroundImageSelected"] forState:UIControlStateSelected];
  }
  if (options[@"backgroundImageHighlighted"]) {
    [button setBackgroundImage:options[@"backgroundImageHighlighted"] forState:UIControlStateHighlighted];
  }

  if (options[@"borderColor"]) {
    if ([SN.getClassName(options[@"borderColor"]) containsString:@"Color"]) {
      button.layer.borderColor = [options[@"borderColor"] CGColor];
    } else {
      button.layer.borderColor = HexRGBA(0xcccccc, 1.0).CGColor;
    }
  }

  button.layer.borderWidth   = options[@"borderWidth"] ? [options[@"borderWidth"] floatValue] : 0.0f;
  button.layer.cornerRadius  = options[@"borderRadius"] ? [options[@"borderRadius"] floatValue] : 0.f;
  button.layer.masksToBounds = options[@"masksToBounds"] ? [options[@"masksToBounds"] boolValue] : NO;

  [button addTarget:button action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
  if (options[@"action"]) { button.action = options[@"action"]; }

  return button;
}

- (void)btnClicked:(SNButton *)sender {
  !self.action ?: self.action(sender);
}


@end
