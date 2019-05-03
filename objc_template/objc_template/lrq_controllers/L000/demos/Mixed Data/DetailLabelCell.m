//
//  DetailLabelCell.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import "DetailLabelCell.h"

static CGFloat padding = 15.0;

@interface DetailLabelCell ()


@end

@implementation DetailLabelCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    {
      UILabel *view = UILabel.new;
      self.titleLabel      = view;
      view.backgroundColor = UIColor.clearColor;
      view.textAlignment   = NSTextAlignmentLeft;
      view.font            = [UIFont systemFontOfSize:17];
      view.textColor       = UIColor.darkTextColor;
      [self.contentView addSubview:view];
    }

    {
      UILabel *view = UILabel.new;
      self.detailLabel     = view;
      view.backgroundColor = UIColor.clearColor;
      view.textAlignment   = NSTextAlignmentRight;
      view.font            = [UIFont systemFontOfSize:17];
      view.textColor       = UIColor.lightGrayColor;
      [self.contentView addSubview:view];
    }

  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect frame = CGRectInset(self.contentView.bounds, padding, 0);
  self.titleLabel.frame  = frame;
  self.detailLabel.frame = frame;
}

@end
