//
//  ScrollViewVerticalLayoutWithXibAndMasonryViewController.m
//  MasonryXIBScrollViewLayout
//
//  Created by stone on 2018/8/11.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "ScrollViewVerticalLayoutWithXibAndMasonryViewController.h"
#import <Masonry/Masonry.h>

@interface ScrollViewVerticalLayoutWithXibAndMasonryViewController ()

@property(weak, nonatomic)
    IBOutlet NSLayoutConstraint* lastViewBottomLayoutConstraint;
@property(weak, nonatomic) IBOutlet UIView* lastView;
@property(weak, nonatomic) IBOutlet UIScrollView* mScrollView;
@property(weak, nonatomic) IBOutlet UIView* contentView;

@end

@implementation ScrollViewVerticalLayoutWithXibAndMasonryViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  [NSLayoutConstraint
      deactivateConstraints:@[ self.lastViewBottomLayoutConstraint ]];
  {
    UIView* contentView = self.contentView;
    UIView* lastView = self.lastView;

    CGFloat height = 50;

    for (int i = 0; i < 10; i++) {
      UIView* view = UIView.new;
      view.backgroundColor = [self randomColor];
      [contentView addSubview:view];

      [view mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.mas_equalTo(lastView ? lastView.mas_bottom : view.superview);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(contentView.mas_width);
        make.height.mas_equalTo(height);
      }];

      height += 25;
      lastView = view;
    }

    [contentView mas_makeConstraints:^(MASConstraintMaker* make) {
      make.bottom.equalTo(lastView.mas_bottom);
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
