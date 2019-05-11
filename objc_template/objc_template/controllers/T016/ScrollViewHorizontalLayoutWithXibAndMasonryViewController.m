//
//  ScrollViewHorizontalLayoutWithXibAndMasonryViewController.m
//  MasonryXIBScrollViewLayout
//
//  Created by stone on 2018/8/11.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "ScrollViewHorizontalLayoutWithXibAndMasonryViewController.h"
#import <Masonry/Masonry.h>

@interface ScrollViewHorizontalLayoutWithXibAndMasonryViewController ()
@property(weak, nonatomic)
    IBOutlet NSLayoutConstraint* lastViewRightLayoutConstraint;
@property(weak, nonatomic) IBOutlet UIView* lastView;
@property(weak, nonatomic) IBOutlet UIView* contentView;
@property(weak, nonatomic) IBOutlet UIScrollView* mScrollView;

@end

@implementation ScrollViewHorizontalLayoutWithXibAndMasonryViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  [NSLayoutConstraint
      deactivateConstraints:@[ self.lastViewRightLayoutConstraint ]];

  {
    UIView* contentView = self.contentView;
    UIView* lastView = self.lastView;

    CGFloat width = 50;

    for (int i = 0; i < 10; i++) {
      UIView* view = UIView.new;
      view.backgroundColor = [self randomColor];
      [contentView addSubview:view];

      [view mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(lastView ? lastView.mas_right : view.superview);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(contentView.mas_height);
      }];

      width += 25;
      lastView = view;
    }

    [contentView mas_makeConstraints:^(MASConstraintMaker* make) {
      make.right.equalTo(lastView.mas_right);
    }];
  }
}

- (UIColor*)randomColor {
  CGFloat hue = (arc4random() % 256 / 256.0);  //  0.0 to 1.0
  CGFloat saturation =
      (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from white
  CGFloat brightness =
      (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from black
  return [UIColor colorWithHue:hue
                    saturation:saturation
                    brightness:brightness
                         alpha:1];
}

@end
