//
//  CalendarDayCell.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import "CalendarDayCell.h"
#import "DayViewModel.h"

@interface CalendarDayCell ()


@end

@implementation CalendarDayCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    {
      UILabel *view = UILabel.new;
      self.label             = view;
      view.backgroundColor   = UIColor.clearColor;
      view.textAlignment     = NSTextAlignmentCenter;
      view.textColor         = UIColor.blackColor;
      view.font              = [UIFont boldSystemFontOfSize:16];
      view.layer.borderWidth = 2;
      view.clipsToBounds     = YES;
      [self.contentView addSubview:view];
    }

    {
      UILabel *view = UILabel.new;
      self.dotsLabel       = view;
      view.backgroundColor = UIColor.clearColor;
      view.textAlignment   = NSTextAlignmentCenter;
      view.textColor       = UIColor.redColor;
      view.font            = [UIFont boldSystemFontOfSize:30];
      [self.contentView addSubview:view];
    }
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect  bounds = self.contentView.bounds;
  CGFloat half   = bounds.size.height / 2;

  self.label.frame              = bounds;
  self.label.layer.cornerRadius = half;
  self.dotsLabel.frame          = CGRectMake(0, half - 10, bounds.size.width, half);
}

- (void)bindViewModel:(id)viewModel {

  if ([viewModel isKindOfClass:[DayViewModel class]]) {
    DayViewModel *model = (DayViewModel *) viewModel;

    self.label.text = kStringFormat(@"%@", model.day);

    self.label.layer.borderColor = model.today ? UIColor.redColor.CGColor : UIColor.clearColor.CGColor;

    self.label.backgroundColor = model.selected ? HexRGBA(@"#FF0000", 0.3) : UIColor.clearColor;
    //
    NSMutableString *dots = [NSMutableString string];

    for (NSInteger i = 0; i < model.appointments.integerValue; ++i) {
      [dots appendString:@"."];
    }

    self.dotsLabel.text = dots;
  }

}


@end
