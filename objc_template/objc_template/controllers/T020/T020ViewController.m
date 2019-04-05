//
//  T020ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T020ViewController.h"
#import "SNScrollView.h"
#import "SNImageView.h"
#import "SNPageControl.h"

@interface T020ViewController ()<UIScrollViewDelegate>

@property(nonatomic, weak) UIPageControl* mControl;
@property(nonatomic, weak) SNScrollView* mScrollView;
@property(assign, nonatomic) NSInteger count;
@property(weak, nonatomic) NSTimer* timer;
@property(strong, nonatomic) NSArray<UIImage*>* images;
@end

@implementation T020ViewController

- (NSArray<UIImage*>*)images {
  /** _images lazy load */

  if (_images == nil) {
    _images = @[
      [UIImage imageNamed:kStringFormat(@"img_%02d", 1)],
      [UIImage imageNamed:kStringFormat(@"img_%02d", 2)],
      [UIImage imageNamed:kStringFormat(@"img_%02d", 3)],
      [UIImage imageNamed:kStringFormat(@"img_%02d", 4)],
      [UIImage imageNamed:kStringFormat(@"img_%02d", 5)],
    ];
  }
  return _images;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  UIImage* image = kImageWithName(@"img_01");
  CGFloat w = kScreenWidth;
  CGFloat h = sn.suggestHeight(w, image);

  CGFloat x = 0;
  CGFloat y = kStatusBarHeight + kNavigationBarHeight + 10;
  CGFloat width = kScreenWidth;
  CGFloat height = h;

  CGRect frame = CGRectMake(x, y, width, height);
  SNScrollView* scrollView = [SNScrollView makeScrollViewWithOptions:@{
    @"backgroundColor" : [UIColor whiteColor],
    // @"borderColor"                   : HexRGBA(@"#CCCCCC", 1.0),
    @"borderWidth" : @1.0,
    @"borderRadius" : @4.f,
    @"masksToBounds" : @YES,
    // @"alwaysBounceHorizontal"        : @YES,
    // @"alwaysBounceVertical"          : @YES,
    @"showsHorizontalScrollIndicator" : @NO,
    @"showsVerticalScrollIndicator" : @NO,
    // @"bounces"               : @NO,
    @"contentSize" : sn.valueWithSize(w * 5, height),
    @"frame" : sn.valueWithCGRect(frame),
    // @"contentOffset"                 : sn.valueWithPoint(-100, -100),
    // @"contentInset"                  : sn.valueWithEdgeInsets(10, 10, 10, 10)
  }];

  self.mScrollView = scrollView;

  scrollView.delegate = self;

  for (NSUInteger i = 1; i <= self.images.count; ++i) {
    SNImageView* imageView = [SNImageView makeImageViewWithOptions:@{
      @"image" : self.images[i - 1],
      @"frame" : sn.valueWithCGRect(CGRectMake(w * (i - 1), 0, w, h))
    }];
    [scrollView addSubview:imageView];
  }

  scrollView.pagingEnabled = YES;

  [self.view addSubview:scrollView];

  {
    SNPageControl* control = [SNPageControl makePageControlWithOptions:@{
      @"hidesForSinglePage" : @(YES),
      @"backgroundColor" : HexRGBA(@"#0", 0.2),
      @"numberOfPages" : @5,
      @"currentPage" : @0,
      @"pageIndicatorTintColor" : [UIColor whiteColor],
      @"currentPageIndicatorTintColor" : [UIColor redColor],
      @"currentPageImage" : [UIImage imageNamed:@"current"],
      @"pageImage" : [UIImage imageNamed:@"other"],
      @"frame" : sn.valueWithCGRect(
          CGRectMake(scrollView.right - scrollView.width * 0.5,
                     scrollView.bottom - 20, scrollView.width * 0.5, 20)),
    }];

    control.layer.borderColor = HexRGBA(@"#000000", 1.0).CGColor;

    self.mControl = control;

    [self.view addSubview:control];

    // NSDictionary *dictionary   = sn.getAllKeyAndValues(UIPageControl.new);
    // NSArray<NSString *> *array =
    // sn.getAllMethodNamesWithClass(SNPageControl.class);

    // NSLog(@"array = %@", array);
    // NSLog(@"array = %@", dictionary);
  }

  // NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self
  // selector:@selector(work:) userInfo:nil repeats:YES];
  // self.timer = timer;

  [self startTimer];
}

- (void)injected {
  NSLog(@"%@", @"不起作用???");
}

- (void)work:(NSTimer*)timer {
  self.count += 1;

  if (self.count > 4) {
    self.count = 0;
  }

  [self.mScrollView
      setContentOffset:CGPointMake(self.mScrollView.width * self.count, 0)
              animated:YES];
}

#pragma mark - <UIScrollViewDelegate>

// 监听滚动
- (void)scrollViewDidScroll:(UIScrollView*)scrollView {
  // NSLogPoint(scrollView.contentOffset);

  // 方法1:
  // {
  //   CGFloat d = scrollView.contentOffset.x / scrollView.width;
  //
  //   CGFloat d1 = d - (NSInteger) d;
  //
  //   NSInteger d2 = (NSInteger) (d1 * 10);
  //
  //   NSInteger index = (NSInteger) (scrollView.contentOffset.x /
  //   scrollView.width);
  //
  //   NSLog(@"d2 = %d || index = %d", d2, index);
  //
  //   [self.mControl setCurrentPage:(d2 > 5 ? (index + 1) : index)];
  // }
  // 方法2:
  {
    NSInteger index =
        (NSInteger)(scrollView.contentOffset.x / scrollView.width + 0.5);

    [self.mControl setCurrentPage:index];
  }
}

// 即将拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView {
  NSLog(@"%s", __func__);
  [self stopTimer];
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
    self.count = self.mControl.currentPage;
    [self startTimer];
  }
}

// 减速完毕(没有加速度就不调用, 所以看情况判断是否停止滚动)
- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView {
  NSLog(@"%s", __func__);
  self.count = self.mControl.currentPage;
  [self startTimer];
}

- (void)startTimer {
  [self.timer invalidate];
  self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                target:self
                                              selector:@selector(work:)
                                              userInfo:nil
                                               repeats:YES];

  [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
  [self.timer invalidate];
  self.timer = nil;
}

@end
