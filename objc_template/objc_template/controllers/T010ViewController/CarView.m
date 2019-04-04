//
//  CarView.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "CarView.h"

@interface CarView ()
@property(weak, nonatomic) IBOutlet UIButton* mButton;
@property(weak, nonatomic) IBOutlet UIView* mImageView;
@end

@implementation CarView

- (void)awakeFromNib {
  [super awakeFromNib];
}

- (void)layoutSubviews {
  // 一定要调用super的layoutSubviews
  [super layoutSubviews];

  NSLog(@"%@", self.mButton);
  NSLog(@"%@", self.mImageView);

  CGFloat width = [[UIScreen mainScreen] bounds].size.width;

  if (self.mImageView.frame.origin.y + self.mImageView.bounds.size.height >
      self.mButton.frame.origin.y + self.mButton.bounds.size.height) {
    CGFloat height = self.mImageView.frame.origin.y +
                     self.mImageView.bounds.size.height + 10;

    self.frame =
        CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
  } else {
    CGFloat height =
        self.mButton.frame.origin.y + self.mButton.bounds.size.height + 10;

    self.frame =
        CGRectMake(self.frame.origin.x, self.frame.origin.y, width, height);
  }
  // self.bounds = CGRectMake(0, 0, self.bounds.size.width, 393.333+30+100);
}

@end
