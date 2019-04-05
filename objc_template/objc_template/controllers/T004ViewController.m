//
// Created by stone on 2019-03-27.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "T004ViewController.h"
#import "SNLabel.h"

@interface T004ViewController ()
/** mLabel */
@property(weak, nonatomic) UILabel* mLabel;
@end

@implementation T004ViewController {
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  {
    SNLabel* label = [SNLabel makeLabelWithOptions:@{
      @"backgroundColor" : [UIColor whiteColor],
      @"textColor" : [UIColor orangeColor],
      @"font" : [UIFont fontWithName:@"PingFangSC-Regular" size:14],
      @"text" :
          @"When you are old and grey and full of sleep, "
          @"当你老了，头发花白，睡意沉沉，\n"
           "And nodding by the fire，take down this book, "
           "倦坐在炉边，取下这本书来，\n"
           "And slowly read,and dream of the soft look "
           "慢慢读着，追梦当年的眼神\n"
           "Your eyes had once,and of their shadows deep; "
           "你那柔美的神采与深幽的晕影。\n"
           "How many loved your moments of glad grace, "
           "多少人爱过你昙花一现的身影，\n"
           "And loved your beauty with love false or true, "
           "爱过你的美貌，以虚伪或真情，\n"
           "But one man loved the pilgrim Soul in you "
           "惟独一人曾爱你那朝圣者的心，\n"
           "And loved the sorrows of your changing face; "
           "爱你哀戚的脸上岁月的留痕。\n"
           "And bending down beside the glowing bars, 在炉罩边低眉弯腰，\n"
           "Murmur,a little sadly,how Love fled 忧戚沉思，喃喃而语，\n"
           "And paced upon the mountains overhead "
           "爱情是怎样逝去，又怎样步上群山，\n"
           "And hid his face amid a crowd of stars. 怎样在繁星之间藏住了脸。",
      @"borderColor" : HexRGBA(@"#cccccc", 1.0),
      @"borderWidth" : @1.0,
      @"masksToBounds" : @YES,
      @"lineHeight" : @8,
      @"letterSpacing" : @.5f,
      @"lineBreakMode" : @"NSLineBreakByTruncatingTail",
    }];

    label.lineHeight = 50;
    label.letterSpacing = 2.f;
    [self.view addSubview:label];

    NSLog(@"label.lineHeight = %lf", label.lineHeight);
    NSLog(@"label.letterSpacing = %lf", label.letterSpacing);

    [label mas_makeConstraints:^(MASConstraintMaker* make) {
      // make.top.mas_equalTo(self.view.mas_top).offset(10);
      make.left.mas_equalTo(self.view.mas_left).offset(10);
      make.right.mas_equalTo(self.view.mas_right).offset(-10);
      make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);
      // make.width.mas_equalTo(50);
      make.height.mas_equalTo(100);
    }];

    kBorder(label)

        self.mLabel = label;
  }
}

@end