//
//  T013ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T013ViewController.h"
#import "SNButton.h"

@interface T013ViewController ()
/** mButton */
@property (weak, nonatomic) UIButton *mButton;
@end

@implementation T013ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  SNButton *button = [SNButton makeButtonWithOptions:@{
    @"type"                 : @(UIButtonTypeCustom),
    // @"backgroundImageNormal"     : [UIImage resizableImageWithLocalImageName:@"chat_send_nor"],
    @"backgroundImageNormal": sn.resizableImageWithImageName(@"chat_send_nor"),

    @"borderColor"          : HexRGBA(@"#cccccc", 1.0),
    @"borderWidth"          : @1.0,
    @"masksToBounds"        : @YES,
    @"borderRadius"         : @4.f,
    @"action"               : ^void(SNButton *sender) {
      NSLog(@"sn.randomString = %@", sn.randomString);
    },
  }];
  // chat_send_nor


  [self.view addSubview:button];
  // chat_send_nor
  [button mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.left.mas_equalTo(self.view.mas_left).offset(0);
    // make.right.mas_equalTo(self.view.mas_right).offset(0);
    // make.top.mas_equalTo(self.view.mas_top).offset(0);
    // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
    make.center.equalTo(button.superview);
    make.width.mas_equalTo(250);
    make.height.mas_equalTo(250);
  }];

  self.mButton = button;
}

- (void)btnClicked:(UIButton *)sender {
  NSLog(@"%s", __func__);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
