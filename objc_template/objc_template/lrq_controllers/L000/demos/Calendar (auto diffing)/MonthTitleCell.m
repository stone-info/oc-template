//
//  MonthTitleCell.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import "MonthTitleCell.h"
#import "MonthTitleViewModel.h"

@interface MonthTitleCell ()


@end

@implementation MonthTitleCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    UILabel *view = UILabel.new;
    self.label           = view;
    view.backgroundColor = UIColor.clearColor;
    view.textAlignment   = NSTextAlignmentCenter;

    view.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];

    view.font = [UIFont boldSystemFontOfSize:13];

    [self.contentView addSubview:view];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.label.frame = self.contentView.bounds;
}

- (void)bindViewModel:(id)viewModel {

  if ([viewModel isKindOfClass:[MonthTitleViewModel class]]) {
    MonthTitleViewModel *titleViewModel = (MonthTitleViewModel *) viewModel;
    self.label.text = titleViewModel.name.uppercaseString;

  }
}


@end
