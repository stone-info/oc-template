//
//  T019ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T019ViewController.h"
#import "SNScrollView.h"
#import "SNImageView.h"

@interface T019ViewController ()<UIScrollViewDelegate>
@property(strong, nonatomic) SNImageView* imageView;
@end

@implementation T019ViewController

// option+shift 移动手势
- (void)scrollViewDidZoom:(UIScrollView*)scrollView {
  NSLog(@"%s", __func__);
}

// return a view that will be scaled. if delegate returns nil, nothing happens
// 返回将被缩放的视图。如果委托返回零，则不会发生任何事情。
- (nullable UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView {
  return self.imageView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  [self demo1];
}

- (void)demo1 {
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
    @"image" : [UIImage imageNamed:@"abc030"],
    // @"frame"          : [NSValue valueWithCGRect:CGRectMake(0,
    // kStatusBarHeight + kNavigationBarHeight, kScreenWidth, kScreenHeight -
    // (kStatusBarHeight + kNavigationBarHeight))],
  }];
  self.imageView = imageView;
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
    // @"contentOffset"                 : sn.valueWithPoint(-100, -100),
    // @"contentInset"                  : sn.valueWithEdgeInsets(10, 10, 10, 10)
  }];

  scrollView.delegate = self;
  scrollView.maximumZoomScale = 2.0;
  scrollView.minimumZoomScale = .5f;
  [scrollView addSubview:imageView];

  [self.view addSubview:scrollView];
}

- (void)injected {
  [self.view removeAllSubviews];

  [self demo1];

  // self.imageView.image = [UIImage imageNamed:@"abc028"];
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
