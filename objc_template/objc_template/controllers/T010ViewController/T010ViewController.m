//
//  T010ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T010ViewController.h"
#import "CarView.h"

@interface T010ViewController ()

@end

@implementation T010ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  NSLog(@"%s", __func__);

  UINib* nib = [UINib nibWithNibName:@"CarView" bundle:nil];
  CarView* carView = [nib instantiateWithOwner:nil options:nil].lastObject;

  kBorder(carView) carView.frame =
      CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, 0, 0);
  [self.view addSubview:carView];

  // NSLog(@"kStatusBarHeight + kNavigationBarHeight = %lf", kStatusBarHeight +
  // kNavigationBarHeight);
  // [carView mas_makeConstraints:^(MASConstraintMaker *make) {
  //   make.top.mas_equalTo(self.view.mas_top).offset(kStatusBarHeight +
  //   kNavigationBarHeight);
  //   make.left.mas_equalTo(self.view.mas_left).offset(0);
  //   make.right.mas_equalTo(self.view.mas_right).offset(0);
  //   make.height.mas_equalTo(0);
  // }];
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
