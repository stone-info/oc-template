//
//  T037ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T037ViewController.h"

@interface T037ViewController ()

@end

@implementation T037ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  SNImageView *imageView = [SNImageView makeImageViewWithOptions:@{
    // @"borderRadius"   : @4.F,
    // @"masksToBounds"  : @(YES),
    // @"backgroundColor": HexRGBA(0xCCCCCC, 1.0),
    // @"contentMode"    : @(UIViewContentModeScaleToFill),
    // // imageView需要这步操作, 因为layer.contents
    // // 光栅化
    // @"shouldRasterize": @(YES),
    // // UI优化
    // // https://www.jianshu.com/p/85837799f3eb
    // @"opaque"         : @(YES),
    // @"glass"          : @(YES),
    @"image": [UIImage imageNamed:@"abc030"],
    // @"frame"          : [NSValue valueWithCGRect:CGRectMake(0,
    // kStatusBarHeight + kNavigationBarHeight, kScreenWidth, kScreenHeight -
    // (kStatusBarHeight + kNavigationBarHeight))],
  }];

  [self.view addSubview:imageView];

  kMasKey(imageView);
  [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.edges.insets(UIEdgeInsetsZero);
    // make.center.mas_equalTo(self.view);
    make.center;

    /** full */
    // make.top.mas_equalTo(self.view.mas_top).offset(0);
    // make.left.mas_equalTo(self.view.mas_left).offset(0);
    // make.right.mas_equalTo(self.view.mas_right).offset(0);
    // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

    /** width & height */
    make.width.mas_equalTo(100);
    // make.height.mas_equalTo(100);
    make.height.mas_equalTo(sn.suggestHeight(100, imageView.image));

    // make.size.mas_equalTo(100);
  }];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
    
    
    