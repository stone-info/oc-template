//
//  T033ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T033ViewController.h"
#import "SNImageView.h"
#import "SDWebImageDownloader.h"
#import "UIImage+GIF.h"

@interface T033ViewController ()
@property (strong, nonatomic) SNImageView *imageView;
@property (assign, nonatomic) BOOL        isFirst;
@end

@implementation T033ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  // {
  //   // self.navigationController.navigationBar.hidden = YES;
  //   // viewController view 自动减去nav高度和tabBar高度
  //   self.edgesForExtendedLayout                                 = UIRectEdgeNone;
  //   // nav背景色
  //   self.navigationController.navigationBar.backgroundColor     = UIColor.whiteColor;
  //   // 分割线隐藏
  //   self.navigationController.navigationBar.shadowImage         = UIImage.new;
  //   // nav背景透明
  //   // [self.navigationController.navigationBar setBackgroundImage:UIImage.new forBarMetrics:UIBarMetricsDefault];
  //   // nav title 颜色
  //   self.navigationController.navigationBar.titleTextAttributes = @{
  //     NSForegroundColorAttributeName: HexRGBA(@"#FFC1C1", 1.0),
  //     NSFontAttributeName           : kPingFangSCMedium(12)
  //   };
  //   // nav 按钮颜色
  //   self.navigationController.navigationBar.tintColor           = HexRGBA(@"#4FB753", 1.0);
  //   // tabBar 背景色
  //   self.tabBarController.tabBar.backgroundColor                = UIColor.whiteColor;
  //   // tabBar 分割线隐藏
  //   self.tabBarController.tabBar.shadowImage                    = UIImage.new;
  //   // tabBar 背景透明
  //   self.tabBarController.tabBar.backgroundImage                = UIImage.new;
  // }

  SNImageView *imageView = [SNImageView makeImageView];
  self.imageView = imageView;
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
    // make.width.mas_equalTo(100);
    // make.height.mas_equalTo(100);
    make.size.mas_equalTo(100);
  }];

}

- (void)updateViewConstraints {
  NSLog(@"%s", __func__);
  if (self.isFirst == NO) {
    self.isFirst = YES;
  } else {

    [UIView animateWithDuration:2 animations:^{ [self.view layoutIfNeeded]; } completion:^(BOOL finished) {}];
  }

  [super updateViewConstraints];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  // [self demo1];

  // [self demo2];

  // [self demo3];


  NSURL *url = [NSURL URLWithString:@"http://localhost:7000/images/abc.gif"];

  // NSData *data;
  // [UIImage sd_animatedGIFWithData:data];

  [SNHTTPManager downloadImageWithURLString:@"http://localhost:7000/images/abc.gif" options:0 progress:nil callback:^(UIImage *image, NSData *data, NSError *error) {
    // UIImage *_image = [UIImage sd_animatedGIFWithData:data];

    self.imageView.image = image;

    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
      // make.center;
      int w = 300;
      make.width.mas_equalTo(w);
      CGFloat height = sn.suggestHeight(w, self.imageView.image);
      make.height.mas_equalTo(height); // 高/宽
    }];
    [self.view setNeedsUpdateConstraints];
  }];

}

- (void)demo3 {
  NSURL *url = [NSURL URLWithString:@"http://localhost:7000/images/abc.jpg"];
  [
    [SDWebImageDownloader
      sharedDownloader]
      downloadImageWithURL:url
      options:0
      progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
        NSLog(@"1.0 * receivedSize / expectedSize = %lf", 1.0 * receivedSize / expectedSize);
      } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {

      NSLog(@"[NSThread currentThread] = %@", [NSThread currentThread]);

      self.imageView.image = image;
      [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        // make.center;
        int w = 200;
        make.width.mas_equalTo(w);
        CGFloat height = sn.suggestHeight(w, self.imageView.image);
        make.height.mas_equalTo(height); // 高/宽
      }];
      [self.view setNeedsUpdateConstraints];
    }
  ];
}

- (void)demo2 {
  SDWebImageManager *manager = [SDWebImageManager sharedManager];

  NSURL *url = [NSURL URLWithString:@"http://localhost:7000/images/abc.jpg"];
  // NSURL *url = [NSURL URLWithString:@"http://localhost:7000/videos/abc.mp4"];
  [
    manager
    loadImageWithURL:url
    options:SDWebImageRefreshCached
    progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
      //   NSLog(@"百分比 %.2f%%", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount * 100);
      // NSLog(@"receivedSize = %li", receivedSize);
      // NSLog(@"expectedSize = %li", expectedSize);

      NSLog(@"1.0 * receivedSize / expectedSize = %lf", 1.0 * receivedSize / expectedSize);

    } completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {



      // NSLog(@"data = %@", data);
      // NSLog(@"image = %@", image);
      // self.imageView.image = image;
      //
      // [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
      //   // make.center;
      //   int w = 200;
      //   make.width.mas_equalTo(w);
      //   CGFloat height = sn.suggestHeight(w, self.imageView.image);
      //   make.height.mas_equalTo(height); // 高/宽
      // }];
      // // 修改值之后 再做标记 , 如果在updateViewConstraints里面做 修改值 没有动画
      //
      // [self.view setNeedsUpdateConstraints];
    }
  ];
}

- (void)demo1 {

  SNImageView *imageView = [SNImageView makeImageViewWithOptions:@{
    @"borderRadius"   : @4.F,
    @"masksToBounds"  : @(YES),
    @"backgroundColor": HexRGBA(@"#CCCCCC", 1.0),
    @"contentMode"    : @(UIViewContentModeScaleToFill),
    // imageView需要这步操作, 因为layer.contents
    // 光栅化
    @"shouldRasterize": @(YES),
    // UI优化
    // https://www.jianshu.com/p/85837799f3eb
    @"opaque"         : @(YES),
    // @"glass"          : @(YES),
    // @"image"          : kImageWithName(@"abc009"),
  }];

  self.imageView = imageView;

  [self.view addSubview:imageView];

  [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.edges.insets(UIEdgeInsetsZero);
    make.center.mas_equalTo(self.view);

    /** full */
    // make.top.mas_equalTo(self.view.mas_top).offset(0);
    // make.left.mas_equalTo(self.view.mas_left).offset(0);
    // make.right.mas_equalTo(self.view.mas_right).offset(0);
    // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

    /** width & height */
    make.width.mas_equalTo(100);
    make.height.mas_equalTo(400);
    // make.size.mas_equalTo(100);
  }];

  // [imageView
  //   sd_setImageWithURL:[NSURL URLWithString:@"http://localhost:7000/images/abc.jpg"]
  //   placeholderImage:UIImage.new];

  [
    imageView
    sd_setImageWithURL:[NSURL URLWithString:@"http://localhost:7000/images/abc.jpg"]
    // options 能设置 table view 滚动停止再下载的选项
    placeholderImage:UIImage.new options:0

    progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {

      // 整数转换 浮点数 = 1.0 * int
      NSLog(@"receivedSize = %li", receivedSize);
      NSLog(@"expectedSize = %li", expectedSize);
      NSLog(@"targetURL = %@", targetURL);
    }
    completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {

      NSLog(@"image = %@", image);
      NSLog(@"error = %@", error);
      NSLog(@"cacheType = %ld", cacheType);
      NSLog(@"imageURL = %@", imageURL);

      [self.view setNeedsUpdateConstraints];
      // [self.view updateConstraintsIfNeeded];
    }
  ];
}

- (void)injected {

  // [self demo1];
}

- (UIRectEdge)edgesForExtendedLayout {
  return UIRectEdgeNone;
}


@end
    
    
    
