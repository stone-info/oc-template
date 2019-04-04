//
//  SNOldButton.m
//  006_UIAdvanced
//
//  Created by stone on 2018/7/29.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "SNOldButton.h"

NSString *const SNButtonStateNormalImage      = @"SNButtonStateNormalImage";
NSString *const SNButtonStateHighlightedImage = @"SNButtonStateHighlightedImage";
NSString *const SNButtonStateNormalTitle      = @"SNButtonStateNormalTitle";
NSString *const SNButtonStateNormalTitleColor = @"SNButtonStateNormalTitleColor";
NSString *const SNButtonTitleLabelFont        = @"SNButtonTitleLabelFont";
NSString *const SNButtonBorder                = @"SNButtonBorder";

@implementation SNOldButton

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    [self setupInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self setupInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                    tapAction:(SNButtonAction)tapAction
                addAttributes:(NSDictionary *)addAttributes {
  self = [super initWithFrame:frame];
  if (self) {

    [self setupInit];

    self.tapAction = tapAction;

    [addAttributes enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
      [self setAttributeWithKey:key value:value];
    }];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                addAttributes:(NSDictionary<NSString *, id> *)addAttributes
                    tapAction:(SNButtonAction)tapAction {

  self = [super initWithFrame:frame];
  if (self) {

    [self setupInit];

    self.tapAction = tapAction;

    [addAttributes enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
      [self setAttributeWithKey:key value:value];
    }];
  }
  return self;
}

- (void)setAttributes:(NSDictionary<NSString *, id> *)attributes {
  _attributes = attributes;

  [attributes enumerateKeysAndObjectsUsingBlock:^(NSString *key, id value, BOOL *stop) {
    [self setAttributeWithKey:key value:value];
  }];
}

- (void)setAttributeWithKey:(NSString *)key
                      value:(id)value {

  if ([key isEqualToString:SNButtonStateNormalImage]) {[self setImage:(UIImage *) value forState:UIControlStateNormal];}
  if ([key isEqualToString:SNButtonStateHighlightedImage]) {[self setImage:(UIImage *) value forState:UIControlStateHighlighted];}
  if ([key isEqualToString:SNButtonStateNormalTitle]) {[self setTitle:(NSString *) value forState:UIControlStateNormal];}
  if ([key isEqualToString:SNButtonTitleLabelFont]) {self.titleLabel.font = (UIFont *) value;}
  if ([key isEqualToString:SNButtonStateNormalTitleColor]) {
    [self setTitleColor:(UIColor *) value forState:UIControlStateNormal];
    [self setTitleColor:[(UIColor *) value colorWithAlphaComponent:0.5] forState:UIControlStateHighlighted];
  }
  if ([key isEqualToString:SNButtonBorder]) {
    NSNumber *flag = value;
    if ([flag boolValue]) {
      self.layer.borderWidth  = 1.0;
      self.layer.borderColor  = [UIColor blackColor].CGColor;
      self.layer.cornerRadius = 4.0;
    }
  }
}

- (void)setupInit {
  [self addTarget:self action:@selector(clickHandler:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickHandler:(SNOldButton *)sender {
  !self.tapAction ?: self.tapAction(sender);
}

@end
