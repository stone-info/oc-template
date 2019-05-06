//
// Created by stone on 2019-03-28.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "T008ViewController.h"
#import "SNButton.h"

@interface T008ViewController ()

@end

@implementation T008ViewController {
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  SNButton *button = [SNButton makeButtonWithOptions:@{
    @"type"                      : @(UIButtonTypeCustom),
    @"font"                      : [UIFont fontWithName:@"PingFangSC-Regular" size:16],
    @"backgroundColor"           : [UIColor whiteColor],
    @"titleNormal"               : @"普通按钮",
    @"titleColorNormal"          : UIColor.blackColor,
    @"titleHighlighted"          : @"高亮按钮",
    @"titleColorHighlighted"     : HexRGBA(@"#FFC1C1", 1.0),

    @"imageNormal"               : [UIImage imageNamed:@"player_btn_pause_normal"],
    @"imageHighlighted"          : [UIImage imageNamed:@"player_btn_pause_highlight"],
    @"backgroundImageNormal"     : [UIImage imageNamed:@"buttongreen"],
    @"backgroundImageHighlighted": [UIImage imageNamed:@"buttongreen_highlighted"],

    @"borderColor"               : HexRGBA(@"#cccccc", 1.0),
    @"borderWidth"               : @1.0,
    @"masksToBounds"             : @YES,
    @"borderRadius"              : @4.f,
    @"action"                    : ^void(SNButton *sender) {
      NSLog(@"sn.randomString = %@", sn.randomString);
    },
  }];

  button.imageView.contentMode = UIViewContentModeScaleAspectFit;

  [self.view addSubview:button];

  [button mas_makeConstraints:^(MASConstraintMaker *make) {

    make.centerY.mas_equalTo(self.view.mas_centerY).offset(0);
    make.centerX.mas_equalTo(self.view.mas_centerX).offset(0);

    make.width.mas_equalTo(300);
    make.height.mas_equalTo(100);
  }];
}
@end
