//
//  ScrollViewHorizontalLayoutWithMasonryViewController.m
//  MasonryXIBScrollViewLayout
//
//  Created by stone on 2018/8/11.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "ScrollViewHorizontalLayoutWithMasonryViewController.h"
#import <Masonry/Masonry.h>

@interface ScrollViewHorizontalLayoutWithMasonryViewController ()

@property(nonatomic, strong) UIScrollView* mScrollView;
@end

@implementation ScrollViewHorizontalLayoutWithMasonryViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];

  UIScrollView* scrollView = [[UIScrollView alloc] init];
  {
    self.mScrollView = scrollView;
    scrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker* make) {
      make.top.offset(200);
      make.left.right.offset(0);
      make.height.mas_equalTo(200);
    }];
  }

  {
    UIView* contentView = UIView.new;
    [scrollView addSubview:contentView];

    [contentView mas_makeConstraints:^(MASConstraintMaker* make) {
      make.edges.mas_equalTo(scrollView);
      make.height.mas_equalTo(scrollView);
    }];

    UIView* lastView = nil;
    CGFloat width = 25;

    for (int i = 0; i < 10; i++) {
      UIView* view = UIView.new;
      view.backgroundColor = [self randomColor];
      [contentView addSubview:view];

      [view mas_makeConstraints:^(MASConstraintMaker* make) {
        make.left.mas_equalTo(lastView ? lastView.mas_right : view.superview);
        make.top.mas_equalTo(0);
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
