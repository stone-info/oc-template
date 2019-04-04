//
//  T036ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T036ViewController.h"

@interface T036ViewController ()
@property (weak, nonatomic) SNImageView *imageView;
@end

@implementation T036ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  SNImageView *imageView = [SNImageView makeImageView];
  self.imageView  = imageView;
  imageView.image = [UIImage imageNamed:@"abc001"];

  imageView.layer.shadowColor   = HexRGBA(0xCCCCCC, 1.0).CGColor;
  imageView.layer.shadowOpacity = 1.f;
  // imageView.layer.shadowOffset  = CGSizeMake(5, 5);
  // imageView.layer.shadowRadius  = 3; // 默认3 // blur
  imageView.layer.shadowRadius  = 0; // 默认3 // blur
  // imageView.layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, imageView.layer.bounds.size.width, imageView.layer.bounds.size.height)].CGPath;

  SNView *mView = [SNView makeView];
  [self.view addSubview:imageView];
  [self.view addSubview:mView];

  kMasKey(imageView);
  [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.edges.insets(UIEdgeInsetsZero);
    // make.center.mas_equalTo(self.view);
    make.centerY.offset(-200);
    make.centerX;

    /** full */
    // make.top.mas_equalTo(self.view.mas_top).offset(0);
    // make.left.mas_equalTo(self.view.mas_left).offset(0);
    // make.right.mas_equalTo(self.view.mas_right).offset(0);
    // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

    /** width & height */
    make.width.mas_equalTo(300);
    // make.size.mas_equalTo(100);
    make.height.mas_equalTo(sn.suggestHeight(300, imageView.image));

  }];

  kMasKey(mView);
  [mView mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.edges.insets(UIEdgeInsetsZero);
    // make.center.mas_equalTo(self.view);
    make.centerX;

    /** full */
    make.top.mas_equalTo(imageView.mas_bottom).offset(10);
    // make.left.mas_equalTo(self.view.mas_left).offset(0);
    // make.right.mas_equalTo(self.view.mas_right).offset(0);
    // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

    /** width & height */
    // make.width.mas_equalTo(100);
    // make.height.mas_equalTo(100);
    make.size.mas_equalTo(300);
  }];

}

- (void)updateViewConstraints {

  [super updateViewConstraints];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

}
@end
    
    
    