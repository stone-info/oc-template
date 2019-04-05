//
//  T017ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T017ViewController.h"
#import "SNView.h"
#import "SNScrollView.h"
#import "SNImageView.h"

@interface T017ViewController ()<UIScrollViewDelegate>

@end

@implementation T017ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  // [self demo1];
  [self demo2];
}
#pragma mark - <UIScrollViewDelegate>

// 监听滚动
- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
  NSLogPoint(scrollView.contentOffset);
}

// 即将拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView {
  NSLog(@"%s", __func__);
}

// 即将停止拖拽
- (void)scrollViewWillEndDragging:(UIScrollView*)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint*)targetContentOffset {
  NSLog(@"%s", __func__);
}

// 已经停止拖拽(可能没有加速度)
- (void)scrollViewDidEndDragging:(UIScrollView*)scrollView
                  willDecelerate:(BOOL)decelerate {
  // decelerate 判断是否有惯性
  // NSLog(@"%s,%d", __func__, decelerate);
  if (decelerate) {
    NSLog(@"用户已经停止拖拽, "
          @"没有停止滚动(有惯性,"
          @"去scrollViewDidEndDecelerating判断是否滚动结束)");
  } else {
    NSLog(@"用户已经停止拖拽, 停止滚动(没有惯性)");
    // self.count = self.mControl.currentPage;
    // [self startTimer];
  }
}

// 减速完毕(没有惯性就不调用, 所以看情况判断是否停止滚动)
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView {
  NSLog(@"%s", __func__);
  // self.count = self.mControl.currentPage;
  // [self startTimer];
}

- (void)demo2 {
  SNImageView* imageView = [SNImageView makeImageViewWithOptions:@{
    // @"borderRadius"   : @4.F,
    // @"masksToBounds"  : @(YES),
    // @"backgroundColor": HexRGBA(@"#CCCCCC", 1.0),
    // @"contentMode"    : @(UIViewContentModeScaleToFill),
    // // imageView需要这步操作, 因为layer.contents
    // // 光栅化
    // @"shouldRasterize": @(YES),
    // // UI优化
    // // https://www.jianshu.com/p/85837799f3eb
    // @"opaque"         : @(YES),
    // @"glass"          : @(YES),
    @"image" : [UIImage imageNamed:@"abc002"],
    // @"frame"          : [NSValue valueWithCGRect:CGRectMake(0,
    // kStatusBarHeight + kNavigationBarHeight, kScreenWidth, kScreenHeight -
    // (kStatusBarHeight + kNavigationBarHeight))],
  }];

  // UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage
  // imageNamed:@"abc009"]];

  NSLog(@"imageView.image = %@", imageView.image);

  SNScrollView* scrollView = [SNScrollView makeScrollViewWithOptions:@{
    @"backgroundColor" : [UIColor whiteColor],
    @"borderColor" : HexRGBA(@"#CCCCCC", 1.0),
    @"borderWidth" : @1.0,
    @"borderRadius" : @4.f,
    @"masksToBounds" : @YES,
    // @"alwaysBounceHorizontal"        : @YES,
    // @"alwaysBounceVertical"          : @YES,
    @"showsHorizontalScrollIndicator" : @NO,
    @"showsVerticalScrollIndicator" : @NO,
    // @"bounces"               : @NO,
    @"contentSize" : sn.valueWithCGSize(imageView.image.size),
    @"frame" : sn.valueWithCGRect(
        CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, kScreenWidth,
                   kScreenHeight - (kStatusBarHeight + kNavigationBarHeight))),
    @"contentOffset" : sn.valueWithPoint(-100, -100),
    @"contentInset" : sn.valueWithEdgeInsets(10, 10, 10, 10)
  }];

  scrollView.delegate = self;

  // scrollView.contentOffset = [sn.valueWithPoint(100, 100) CGPointValue];
  // scrollView.frame = CGRectMake(0, kStatusBarHeight + kNavigationBarHeight,
  // kScreenWidth, kScreenHeight - (kStatusBarHeight + kNavigationBarHeight));
  [scrollView addSubview:imageView];

  NSLogPoint(scrollView.contentOffset)

      [self.view addSubview:scrollView];
}

- (void)injected {
  [self.view removeAllSubviews];

  [self demo2];
}

- (void)demo1 {
  SNView *view = [SNView makeViewWithOptions:@{
    @"backgroundColor": [UIColor whiteColor],
    @"borderWidth"    : @1.0,
    @"borderColor"    : HexRGBA(@"#CCCCCC", 1.0),
    @"borderRadius"   : @4.f,
    @"masksToBounds"  : @YES,
    @"action"         : ^void(UITapGestureRecognizer *sender) {
      NSLog(@"hello world");
}
, @"frame" : [NSValue valueWithCGRect:CGRectMake(100, 100, 100, 100)],
}];

SNScrollView* scrollView = [SNScrollView makeScrollViewWithOptions:@{
  @"backgroundColor" : [UIColor whiteColor],
  // @"borderColor"    : HexRGBA(@"#CCCCCC", 1.0),
  @"borderWidth" : @1.0,
  @"borderRadius" : @4.f,
  @"masksToBounds" : @YES,
  @"contentSize" : [NSValue valueWithCGSize:CGSizeMake(kScreenWidth * 2, 500)],
  @"frame" : [NSValue
      valueWithCGRect:CGRectMake(0,
                                 kStatusBarHeight + kNavigationBarHeight,
                                 kScreenWidth,
                                 500)],
}];

[scrollView addSubview:view];

[self.view addSubview:scrollView];
}

@end
