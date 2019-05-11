//
//  T021ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import <SDCycleScrollView/SDCycleScrollView.h>
#import "T021ViewController.h"

@interface T021ViewController () <SDCycleScrollViewDelegate>

@end

@implementation T021ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  // {
  //   // 网络加载图片的轮播器
  //   SDCycleScrollView *cycleScrollView = [SDCycleScrollView
  //   cycleScrollViewWithFrame:frame delegate:self
  //   placeholderImage:UIImage.new];
  //   /** 网络图片 url string 数组 */
  //   cycleScrollView.imageURLStringsGroup = @[];
  // }

  NSData *data = [NSData
    dataWithContentsOfURL:
      [NSURL URLWithString:@"http://localhost:7000/images/a01.jpg"]];

  UIImage *image = [UIImage imageWithData:data];

  CGRect frame =
           CGRectMake(0, kStatusBarHeight + kNavigationBarHeight + 10, kScreenWidth,
                      sn.suggestHeight(kScreenWidth, image));

  {
    // 本地加载图片的轮播器
    SDCycleScrollView *cycleScrollView =
                        [SDCycleScrollView cycleScrollViewWithFrame:frame
                                           imageURLStringsGroup:@[
                                             @"http://localhost:7000/images/a01.jpg",
                                             @"http://localhost:7000/images/a02.jpg",
                                             @"http://localhost:7000/images/a03.jpg",
                                           ]];

    cycleScrollView.delegate = self;

    [self.view addSubview:cycleScrollView];
  }
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView
   didSelectItemAtIndex:(NSInteger)index {
  NSLog(@"%s", __func__);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView
       didScrollToIndex:(NSInteger)index {
  NSLog(@"%s", __func__);
}

- (void)injected {
}
@end
