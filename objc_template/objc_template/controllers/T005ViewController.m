//
// Created by stone on 2019-03-27.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "T005ViewController.h"
#import "SNImageView.h"

@interface T005ViewController ()
/** mImageView */
@property(weak, nonatomic) UIImageView* mImageView;
@end

@implementation T005ViewController {
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  {
    SNImageView* imageView = [SNImageView makeImageView];
    UIImage* image = kImageWithName(@"abc009");
    imageView.image = image;

    // NSString *scale    = [NSString stringWithFormat:@"@%li", (NSInteger)
    // [UIScreen mainScreen].scale];
    // NSString *resource = [NSString stringWithFormat:@"image.bundle/%@",
    // @"abc001.jpg"];
    // NSString *path     = [[NSBundle mainBundle] pathForResource:resource
    // ofType:nil];
    // imageView.image    = [UIImage imageWithContentsOfFile:path];

    [imageView setImageWithBundleName:@"image.bundle"
                            imageName:@"abc001"
                            extension:@"jpg"];

    [self.view addSubview:imageView];

    [imageView mas_makeConstraints:^(MASConstraintMaker* make) {
      make.center.mas_equalTo(self.view);
      make.width.mas_equalTo(200);
      // make.height.mas_equalTo(100);
      if (imageView.image) {
        CGFloat height = imageView.image.size.height;
        CGFloat width = imageView.image.size.width;
        make.height.mas_equalTo(imageView.mas_width)
            .multipliedBy(height / width);  // 高/宽
      } else {
        make.height.mas_equalTo(200);
      }
    }];

    self.mImageView = imageView;
  }
}

@end
