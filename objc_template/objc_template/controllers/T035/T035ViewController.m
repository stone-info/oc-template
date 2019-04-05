//
//  T035ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T035ViewController.h"

@interface T035ViewController ()
@property (weak, nonatomic) SNLabel *label;
@end

@implementation T035ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  NSDictionary *dictionary = @{
    @"backgroundColor": [UIColor whiteColor],
    @"textColor"      : [UIColor blackColor],
    @"font"           : [UIFont fontWithName:@"PingFangSC-Regular" size:14],
    @"text"           : @"When you are old and grey and full of sleep, 当你老了，头发花白，睡意沉沉，\n"
                        "And nodding by the fire，take down this book, 倦坐在炉边，取下这本书来",
    @"textAlignment"  : @(NSTextAlignmentCenter),
    @"borderColor"    : HexRGBA(@"#cccccc", 1.0),
    @"borderWidth"    : @1.0,
    //    @"masksToBounds" : @YES,
    @"lineHeight"     : @30,
    @"letterSpacing"  : @15.5f,
    //    @"lineBreakMode" : @(NSLineBreakByTruncatingTail)
  };

  {
    SNLabel *label = [SNLabel makeLabelWithOptions:dictionary];
    self.label = label;
    [self.view addSubview:label];

    label.textAlignment = NSTextAlignmentLeft;

    kMasKey(label);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      // make.edges.insets(UIEdgeInsetsZero);
      // make.center.mas_equalTo(self.view);

      /** full */
      // make.top.mas_equalTo(self.view.mas_top).offset(0);
      make.centerY.mas_equalTo(self.view.mas_centerY);
      make.left.mas_equalTo(self.view.mas_left).offset(20);
      make.right.mas_equalTo(self.view.mas_right).offset(-20);
      // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

      /** width & height */
      // make.width.mas_equalTo(100);
      // make.height.mas_equalTo(200);
      // make.size.mas_equalTo(100);
    }];
  }

  // {
  //   SNLabel *label = [SNLabel makeLabelWithOptions:kLabelNormalTemplate];
  //   self.label = label;
  //   [self.view addSubview:label];
  //
  //   label.textAlignment = NSTextAlignmentLeft;
  //
  //   kMasKey(label);
  //   [label mas_makeConstraints:^(MASConstraintMaker *make) {
  //     // make.edges.insets(UIEdgeInsetsZero);
  //     make.centerY.mas_equalTo(self.view.mas_centerY).offset(100);
  //     make.centerX.mas_equalTo(self.view.mas_centerX);
  //
  //     /** full */
  //     // make.top.mas_equalTo(self.view.mas_top).offset(0);
  //     // make.left.mas_equalTo(self.view.mas_left).offset(0);
  //     // make.right.mas_equalTo(self.view.mas_right).offset(0);
  //     // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
  //
  //     /** width & height */
  //     // make.width.mas_equalTo(100);
  //     // make.height.mas_equalTo(100);
  //     // make.size.mas_equalTo(100);
  //   }];
  // }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  self.label.lineHeight = 0;
  self.label.letterSpacing = 0;
  [self.view setNeedsLayout];
}

- (void)injected {

}


@end
    
    
    