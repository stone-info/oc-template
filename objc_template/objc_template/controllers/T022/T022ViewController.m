//
//  T022ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T022ViewController.h"

@interface T022ViewController ()

// 居中 左右约束  高度使用 子view 撑开
@property (weak, nonatomic) IBOutlet UIView             *mView;
// image 优先级 750  | 约束 等于
@property (weak, nonatomic) IBOutlet UIImageView        *mImageView;
// label 优先级 1000 | 约束 大于等于
@property (weak, nonatomic) IBOutlet UILabel            *mLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageHeightConstraint;

@end

@implementation T022ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
  self.imageWidthConstraint.constant  = 100;
  self.imageHeightConstraint.constant = 100;

  [UIView animateWithDuration:2.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
    [self.view layoutIfNeeded];
  } completion:^(BOOL finished) {
    //
  }];
}

- (void)injected {
  kBorder(self.mLabel);
  NSLog(@"I've been injected: %@", self);

  self.mLabel.text = @"hello worldhello worldhello worldhello worldhello "
                     @"worldhello worldhello worldhello worldhello worldhello "
                     @"worldhello worldhello worldhello worldhello worldhello "
                     @"worldhello worldhello worldhello worldhello "
                     @"worldworldhello worldhello worldhello worldhello "
                     @"worldworldhello worldhello worldhello worldhello world";
}

@end
