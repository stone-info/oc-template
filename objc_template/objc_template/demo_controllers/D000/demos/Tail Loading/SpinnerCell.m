//
//  SpinnerCell.m
//  IGListKitTest
//
//  Created by stone on 2019/5/2.
//  Copyright © 2019 stone. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import "SpinnerCell.h"

@interface SpinnerCell ()


@end

@implementation SpinnerCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator = activityIndicator;
    [self.contentView addSubview:activityIndicator];

    kBorder(self.contentView);
  }
  return self;
}

- (void)layoutSubviews {
  // 一定要调用super的layoutSubviews
  [super layoutSubviews];

  CGRect bounds = self.contentView.bounds;

  // NSLogRect(bounds);

  self.activityIndicator.center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
}

@end