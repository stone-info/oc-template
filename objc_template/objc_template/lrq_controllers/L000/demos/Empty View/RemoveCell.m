//
//  RemoveCell.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import "RemoveCell.h"

@interface RemoveCell ()

@property (weak, nonatomic) UIButton *button;
@end

@implementation RemoveCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    UILabel *label = UILabel.new;
    self.label            = label;

    kBorder(label);

    label.backgroundColor = UIColor.clearColor;
    label.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:label];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button = button;

    kBorder(button);

    [button setTitle:@"Remove" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];

    button.backgroundColor = UIColor.clearColor;
    [button addTarget:self action:@selector(onButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];

  }
  return self;
}

- (void)onButton:(UIButton *)sender {
  if ([self.delegate respondsToSelector:@selector(removeCellDidTapButton:)]) {
    [self.delegate removeCellDidTapButton:self];
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.contentView.backgroundColor = UIColor.whiteColor;

  CGRect bounds = self.contentView.bounds;

  CGRect slice;
  CGRect remainder;

  CGRectDivide(bounds, &slice, &remainder, 100, CGRectMaxXEdge);

  self.label.frame  = slice;
  self.button.frame = remainder;

}

@end
