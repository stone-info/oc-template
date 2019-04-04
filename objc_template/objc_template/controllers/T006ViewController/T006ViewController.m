//
// Created by stone on 2019-03-27.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "T006ViewController.h"
#import "SNImageView.h"
#import "T006View.h"

@interface T006ViewController ()
@property(weak, nonatomic) UIImageView* imageView;
@property(nonatomic, strong) NSMutableArray<UIImage*>* standImages;
@property(nonatomic, strong) NSMutableArray<UIImage*>* smallImages;
@property(nonatomic, strong) NSMutableArray<UIImage*>* bigImages;
@end

@implementation T006ViewController
/** standImages 懒加载 */
- (NSMutableArray<UIImage*>*)standImages {
  if (_standImages == nil) {
    _standImages = [NSMutableArray array];
    for (NSInteger i = 1; i <= 10; ++i) {
      // NSString *imageName = kStringFormat(@"stand_%ld", i);
      // UIImage  *image     = [sn
      // imageNamedWithBundleName:@"quanhuang.bundle/stand" imageName:imageName
      // extension:@"png"];

      UIImage* image = [UIImage imageNamed:kStringFormat(@"stand_%ld", i)];

      [_standImages addObject:image];
    }
  }
  return _standImages;
}

/** smallImages 懒加载 */
- (NSMutableArray<UIImage*>*)smallImages {
  if (_smallImages == nil) {
    _smallImages = [NSMutableArray array];
    for (NSInteger i = 1; i <= 39; ++i) {
      // NSString *imageName = kStringFormat(@"xiaozhao3_%ld", i);
      // UIImage *image = [sn
      // imageNamedWithBundleName:@"quanhuang.bundle/xiaozhao/xiaozhao3"
      // imageName:imageName extension:@"png"];

      UIImage* image = [UIImage imageNamed:kStringFormat(@"xiaozhao3_%ld", i)];

      [_smallImages addObject:image];
    }
  }
  return _smallImages;
}

/** bigImages 懒加载 */
- (NSMutableArray<UIImage*>*)bigImages {
  if (_bigImages == nil) {
    _bigImages = [NSMutableArray array];
    for (NSInteger i = 1; i <= 87; ++i) {
      // NSString *imageName = kStringFormat(@"dazhao_%ld", i);
      // UIImage  *image     = [sn
      // imageNamedWithBundleName:@"quanhuang.bundle/dazhao" imageName:imageName
      // extension:@"png"];

      UIImage* image = [UIImage imageNamed:kStringFormat(@"dazhao_%ld", i)];

      [_bigImages addObject:image];
    }
  }
  return _bigImages;
}

- (UIImageView*)imageView {
  /** _imageView lazy load */

  if (_imageView == nil) {
    UIImageView* imageView = UIImageView.new;
    imageView.contentMode = UIViewContentModeBottomLeft;
    imageView.backgroundColor = UIColor.orangeColor;
    _imageView = imageView;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker* make) {
      make.left.mas_equalTo(self.view.mas_left).offset(0);
      make.right.mas_equalTo(self.view.mas_right).offset(0);
      make.centerY.mas_equalTo(self.view.mas_centerY).offset(0);
      make.height.mas_equalTo(200);
    }];
  }
  return _imageView;
}

//===================================== stone ===========/

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  @weakify_self [((T006View*)self.view)
      setBigButtonClickedBlock:(void (^)(UIButton* sender)) ^ {
        @strongify_self
            // NSLog(@"%s", __func__);
            // NSLog(@"self.view = %@", self.view);
            [self dazhao];
      }];

  [((T006View*)self.view)
      setSmallButtonClickedBlock:(void (^)(UIButton* sender)) ^ {
        @strongify_self
            // NSLog(@"%s", __func__);
            // NSLog(@"self.view = %@", self.view);
            [self xiaozhao];
      }];

  [self start];
}

- (void)touchesBegan:(NSSet<UITouch*>*)touches
           withEvent:(nullable UIEvent*)event {
  [self dazhao];
}

- (void)dealloc {
  NSLog(@"■■■■■■\t%@ is dead ☠☠☠\t■■■■■■", [self class]);
}

- (void)start {
  NSLog(@"%s =====================", __func__);
  // 设置动画图片
  self.imageView.animationImages = self.standImages;

  // 设置播放次数
  self.imageView.animationRepeatCount = 0;

  // 设置播放的时长
  self.imageView.animationDuration = 1.0;

  [self.imageView startAnimating];
}

- (void)xiaozhao {
  [self.imageView removeFromSuperview];
  self.imageView = nil;
  NSLog(@"%s", __func__);
  NSLog(@"self = %@", self);
  // 设置动画图片
  self.imageView.animationImages = self.smallImages;

  // 设置播放次数
  self.imageView.animationRepeatCount = 1;

  // 设置播放的时长
  self.imageView.animationDuration = 1.5;

  [self.imageView startAnimating];

  [self performSelector:@selector(start)
             withObject:nil
             afterDelay:self.imageView.animationDuration];
}

- (void)dazhao {
  [self.imageView removeFromSuperview];
  self.imageView = nil;
  // self.imageView.animationImages      = nil;
  // self.imageView.animationRepeatCount = 0;
  // self.imageView.animationDuration    = 0;
  // [self.imageView stopAnimating];

  // 设置动画图片
  self.imageView.animationImages = self.bigImages;

  // 设置播放次数
  self.imageView.animationRepeatCount = 1;

  // 设置播放的时长
  self.imageView.animationDuration = 2.0;

  [self.imageView startAnimating];

  [self performSelector:@selector(start)
             withObject:nil
             afterDelay:self.imageView.animationDuration];
}

@end
