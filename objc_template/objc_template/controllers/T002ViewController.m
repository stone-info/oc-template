//
// Created by stone on 2019-03-27.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "T002ViewController.h"

@interface T002ViewController ()
/** mLabel */
@property(weak, nonatomic) UILabel* mLabel;
@end

@implementation T002ViewController {
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self makeLabelWithFrame:CGRectMake(100, 100, 200, 100)];
  UILabel* label = [self makeLabelWithCenter:self.view.center];
  label.bounds = CGRectMake(0, 0, 200, 100);
}

- (UILabel*)makeLabelWithFrame:(CGRect)frame {
  NSLog(@"call method \"%s\"", sel_getName(_cmd));
  UILabel* label = [self getLabel];
  kShadow(label) label.frame = frame;
  [self.view addSubview:label];
  return label;
}

- (UILabel*)makeLabelWithBounds:(CGRect)bounds {
  NSLog(@"call method \"%s\"", sel_getName(_cmd));
  UILabel* label = [self getLabel];
  kShadow(label) label.bounds = bounds;
  [self.view addSubview:label];
  return label;
}

- (UILabel*)makeLabelWithCenter:(CGPoint)center {
  NSLog(@"call method \"%s\"", sel_getName(_cmd));
  UILabel* label = [self getLabel];
  kShadow(label) label.center = center;
  [self.view addSubview:label];
  return label;
}

- (UILabel*)getLabel {
  UILabel* label = [[UILabel alloc] init];
  /** GPU 优化 */
  label.opaque = YES;
  label.backgroundColor = [UIColor whiteColor];
  //------------------------------
  label.numberOfLines = 0;
  label.textColor = [UIColor blackColor];
  label.textAlignment = NSTextAlignmentLeft;
  label.text = @"When you are old and grey and full of sleep, "
               @"当你老了，头发花白，睡意沉沉";
  label.font = kPingFangSCRegular(14);

  return label;
}

@end