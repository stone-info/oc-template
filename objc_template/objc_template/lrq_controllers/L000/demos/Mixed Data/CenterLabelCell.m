//
//  CenterLabelCell.m
//  objc_template
//
//  Created by stone on 2019/5/3.
//  Copyright © 2019 stone. All rights reserved.
//

#import "CenterLabelCell.h"

@interface CenterLabelCell ()


@end

@implementation CenterLabelCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    UILabel *label = UILabel.new;
    self.label            = label;
    label.backgroundColor = UIColor.clearColor;
    label.textAlignment   = NSTextAlignmentCenter;
    label.textColor       = UIColor.whiteColor;

    label.font = [UIFont boldSystemFontOfSize:18];

    [self.contentView addSubview:label];

  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.label.frame = self.contentView.bounds;

}

@end