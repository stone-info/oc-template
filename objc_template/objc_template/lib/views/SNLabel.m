//
//  SNLabel.m
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Kiwi/KWValue.h>
#import "SNLabel.h"
#import "SNAttributesHandler.h"

@interface SNLabel ()


@end

@implementation SNLabel {
  CGFloat _lineHeight;
  CGFloat _letterSpacing;
}

- (CGFloat)letterSpacing {
  if (_attributes) {
    return [_attributes[NSKernAttributeName] floatValue];
  } else {
    return 0.f;
  }
}

- (CGFloat)lineHeight {
  if (_attributes) {
    return [[_attributes[NSParagraphStyleAttributeName] valueForKey:@"lineSpacing"] floatValue];
  } else {
    return 0.f;
  }
}

- (void)setLineHeight:(CGFloat)lineHeight {

  _lineHeight = lineHeight;

  NSMutableDictionary *attributes;

  if (self.attributes == nil) {
    attributes[NSForegroundColorAttributeName] = self.textColor;
    attributes[NSFontAttributeName]            = self.font;
  } else {
    attributes = self.attributes.mutableCopy;
  }

  NSMutableParagraphStyle *mParagraphStyle = [[NSMutableParagraphStyle alloc] init];
  mParagraphStyle.lineSpacing   = lineHeight;
  mParagraphStyle.lineBreakMode = self.lineBreakMode;

  attributes[NSParagraphStyleAttributeName] = mParagraphStyle;

  self.attributes = attributes;
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text attributes:attributes];
  self.attributedText = attributedString;
}

- (void)setLetterSpacing:(CGFloat)letterSpacing {

  _letterSpacing = letterSpacing;

  NSMutableDictionary *attributes;

  if (self.attributes == nil) {
    attributes[NSForegroundColorAttributeName] = self.textColor;
    attributes[NSFontAttributeName]            = self.font;
  } else {
    attributes = self.attributes.mutableCopy;
  }

  attributes[NSKernAttributeName] = @(letterSpacing);

  self.attributes = attributes;
  NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text attributes:attributes];
  self.attributedText = attributedString;
}

+ (instancetype)makeLabel {
  return [self makeLabelWithOptions:@{@"borderColor": HexRGBA(0xCCCCCC, 1.0), @"borderWidth": @1}];;
}

+ (instancetype)makeLabelWithOptions:(NSDictionary *)options {

  SNLabel *view;

  if (options[@"frame"]) {
    view = [[SNLabel alloc] initWithFrame:[options[@"frame"] CGRectValue]];
  } else {
    view = [[SNLabel alloc] init];
  }

  FBKVOController *KVOController = [FBKVOController controllerWithObserver:self];
  self.KVOController = KVOController;
  [self.KVOController observe:view keyPath:@"attributedText" options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id observer, id object, NSDictionary *change) {
    NSLog(@"observer = %@", observer);
    NSLog(@"object = %@", object);
    NSLog(@"change = %@", change);
  }];

  for (NSString *key in options) {
    id obj = options[key];
    [SNAttributesHandler commonAttributes:view key:key obj:obj];
    [SNAttributesHandler featureAttributeWithLabel:view key:key obj:obj];
  }

  view.textAlignment = options[@"textAlignment"] ? (NSTextAlignment) [options[@"textAlignment"] integerValue] : NSTextAlignmentLeft;
  view.numberOfLines = options[@"numberOfLines"] ? [options[@"numberOfLines"] integerValue] : 0;

  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapHandle:)];
  [view addGestureRecognizer:tap];

  // if (options[@"lineHeight"]) {
  //   view.lineHeight = [options[@"lineHeight"] floatValue];
  // }
  // if (options[@"letterSpacing"]) {
  //   view.letterSpacing = [options[@"letterSpacing"] floatValue];
  // }

  // 富文本
  if (options[@"lineHeight"] || options[@"letterSpacing"]) {
    // 设置段落 , 行高
    NSParagraphStyle *paragraphStyle;
    if (options[@"lineHeight"]) {
      NSMutableParagraphStyle *mParagraphStyle = [[NSMutableParagraphStyle alloc] init];
      mParagraphStyle.lineSpacing   = [options[@"lineHeight"] floatValue];
      mParagraphStyle.lineBreakMode = view.lineBreakMode;
      paragraphStyle = mParagraphStyle;
    } else {
      paragraphStyle = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
    }

    // NSKernAttributeName 字体间距
    NSDictionary *attributes = @{
      NSParagraphStyleAttributeName : paragraphStyle,
      NSKernAttributeName           : options[@"letterSpacing"] ? options[@"letterSpacing"] : @0,
      NSForegroundColorAttributeName: view.textColor,
      NSFontAttributeName           : view.font
    };
    view.attributes = [attributes mutableCopy];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:view.text attributes:attributes];
    // 创建文字属性
    // NSDictionary *addAttributes = @{
    //   NSForegroundColorAttributeName: label.textColor,
    //   NSFontAttributeName           : label.font
    // };
    // 刷漆的范围...
    // [attributedString addAttributes:addAttributes range:NSMakeRange(0, label.text.length)];
    // [attributedString attributedSubstringFromRange:NSMakeRange(0, label.text.length)];

    view.attributedText = attributedString;
  }
  // 被富文本的设置覆盖了, 需要再覆盖回来...或者直接在富文本设置
  // label.lineBreakMode = NSLineBreakByTruncatingTail;

  return view;
}

- (void)setAction:(void (^)(UITapGestureRecognizer *))action {
  _action = action;
  self.userInteractionEnabled = YES;
}

- (void)tapHandle:(UITapGestureRecognizer *)sender {
  !self.action ?: self.action(sender);
}


// + (instancetype)makeLabelWithOptions:(NSDictionary *)options {
//   SNLabel *label = [[SNLabel alloc] init];
//   /** GPU 优化 */
//   // default is YES. opaque views must fill their entire bounds or the results are undefined. the active CGContext in drawRect: will not have been cleared and may have non-zeroed pixels
//   label.opaque              = YES;
//   label.layer.masksToBounds = YES;
//   label.backgroundColor     = options[@"backgroundColor"] ? options[@"backgroundColor"] : [UIColor whiteColor];
//   //------------------------------
//   label.textColor           = options[@"textColor"] ? options[@"textColor"] : [UIColor blackColor];
//   label.text                = options[@"text"] ? options[@"text"] : @"";
//   label.font                = options[@"font"] ? options[@"font"] : [UIFont fontWithName:@"PingFangSC-Regular" size:14];
//   label.numberOfLines       = 0;
//   label.textAlignment       = NSTextAlignmentLeft;
//
//   // if (options[@"lineBreakMode"]) {
//   //   NSString *key = options[@"lineBreakMode"];
//   //   (
//   //     (void (^)()) @{
//   //       @"NSLineBreakByWordWrapping"    : ^{ label.lineBreakMode = NSLineBreakByWordWrapping; },
//   //       @"NSLineBreakByCharWrapping"    : ^{ label.lineBreakMode = NSLineBreakByCharWrapping; },
//   //       @"NSLineBreakByClipping"        : ^{ label.lineBreakMode = NSLineBreakByClipping;; },
//   //       @"NSLineBreakByTruncatingHead"  : ^{ label.lineBreakMode = NSLineBreakByTruncatingHead; },
//   //       @"NSLineBreakByTruncatingTail"  : ^{ label.lineBreakMode = NSLineBreakByTruncatingTail; },
//   //       @"NSLineBreakByTruncatingMiddle": ^{ label.lineBreakMode = NSLineBreakByTruncatingMiddle; },
//   //     }[key] ?: ^{ label.lineBreakMode = NSLineBreakByTruncatingTail; }
//   //   )();
//   // }
//
//   label.lineBreakMode = options[@"lineBreakMode"] ? [options[@"lineBreakMode"] integerValue] : NSLineBreakByTruncatingTail;
//
//   if (options[@"borderColor"]) {
//     if ([SN.getClassName(options[@"borderColor"]) containsString:@"Color"]) {
//       label.layer.borderColor = [options[@"borderColor"] CGColor];
//     } else {
//       label.layer.borderColor = HexRGBA(0xcccccc, 1.0).CGColor;
//     }
//   }
//
//   label.layer.borderWidth   = options[@"borderWidth"] ? [options[@"borderWidth"] floatValue] : 0.0;
//   label.layer.masksToBounds = options[@"masksToBounds"] ? [options[@"masksToBounds"] boolValue] : NO;
//
//   if (options[@"lineHeight"] || options[@"letterSpacing"]) {
//     // 设置段落 , 行高
//     NSParagraphStyle *paragraphStyle;
//     if (options[@"lineHeight"]) {
//       NSMutableParagraphStyle *mParagraphStyle = [[NSMutableParagraphStyle alloc] init];
//       mParagraphStyle.lineSpacing   = [options[@"lineHeight"] floatValue];
//       mParagraphStyle.lineBreakMode = label.lineBreakMode;
//       paragraphStyle = mParagraphStyle;
//     } else {
//       paragraphStyle = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
//     }
//
//     // NSKernAttributeName 字体间距
//     NSDictionary *attributes = @{
//       NSParagraphStyleAttributeName : paragraphStyle,
//       NSKernAttributeName           : options[@"letterSpacing"] ? options[@"letterSpacing"] : @0,
//       NSForegroundColorAttributeName: label.textColor,
//       NSFontAttributeName           : label.font
//     };
//
//     label.attributes = [attributes mutableCopy];
//
//     NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:label.text attributes:attributes];
//
//
//     // 创建文字属性
//     // NSDictionary *addAttributes = @{
//     //   NSForegroundColorAttributeName: label.textColor,
//     //   NSFontAttributeName           : label.font
//     // };
//
//     // 刷漆的范围...
//     // [attributedString addAttributes:addAttributes range:NSMakeRange(0, label.text.length)];
//
//     // [attributedString attributedSubstringFromRange:NSMakeRange(0, label.text.length)];
//
//     label.attributedText = attributedString;
//
//     // /** 文字的属性集合 */
//     // NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//     // /** 颜色 */
//     // dict[NSForegroundColorAttributeName] = [UIColor orangeColor];
//     // /** 字体 */
//     // dict[NSFontAttributeName]            = [UIFont systemFontOfSize:30];
//     // /** 空心笔的粗度 越高空心就越填充*/
//     // dict[NSStrokeWidthAttributeName]     = @3;
//     // /** 描边颜色 */
//     // dict[NSStrokeColorAttributeName]     = [UIColor yellowColor];
//     // {
//     //   /** 创建阴影对象 */
//     //   NSShadow *shadow = [[NSShadow alloc] init];
//     //   /** 阴影颜色 */
//     //   shadow.shadowColor      = [UIColor blackColor];
//     //   /** 阴影偏移量 */
//     //   shadow.shadowOffset     = CGSizeMake(6, 6);
//     //   /** 阴影模糊度 */
//     //   shadow.shadowBlurRadius = 3;
//     //   dict[NSShadowAttributeName] = shadow;
//     // }
//     // // NSString            *str  = @"hello world";
//     // // [str drawInRect:self.bounds withAttributes:dict];
//   }
//   // 被富文本的设置覆盖了, 需要再覆盖回来...或者直接在富文本设置
//   // label.lineBreakMode = NSLineBreakByTruncatingTail;
//
//   return label;
// }

@end
