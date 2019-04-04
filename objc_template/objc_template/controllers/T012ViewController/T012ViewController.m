//
//  T012ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T012ViewController.h"

@interface TestButton1 : UIButton

@end

@implementation TestButton1

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeCenter;
  }
  return self;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
  return CGRectMake(0, 0, 100, 100);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
  return CGRectMake(100, 0, 100, 100);
}

@end

@interface TestButton2 : UIButton

@end

@implementation TestButton2
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeCenter;
  }
  return self;
}

- (void)layoutSubviews {
  // 一定要调用super的layoutSubviews
  [super layoutSubviews];

  self.imageView.frame = CGRectMake(100, 0, 100, 100);
  self.titleLabel.frame = CGRectMake(0, 0, 100, 100);
}
@end

@interface TestButton3 : UIButton

@end

@implementation TestButton3

@end
// sn_note:=========  ============================ stone 🐳 ===========/

@interface T012ViewController ()
@end

@implementation T012ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  CGFloat h = 120;

  TestButton1* button1;
  {
    TestButton1* button = [TestButton1 buttonWithType:UIButtonTypeCustom];
    button1 = button;
    button.frame = CGRectMake(10, kStatusBarHeight + kNavigationBarHeight + 10,
                              kScreenWidth - 20, h);
    // button.backgroundColor = [UIColor orangeColor];

    kBorder(button)
        // kShadow(button)
        kBorder(button.imageView) kBorder(button.titleLabel)[self foo:button];
  }

  TestButton2* button2;
  {
    TestButton2* button = [TestButton2 buttonWithType:UIButtonTypeCustom];
    button2 = button;
    button.frame = CGRectMake(10, button1.bottom + 10, kScreenWidth - 20, h);
    // button.backgroundColor = [UIColor orangeColor];

    kBorder(button)
        // kShadow(button)
        kBorder(button.imageView) kBorder(button.titleLabel)[self foo:button];
  }
  TestButton3* button3;
  {
    TestButton3* button = [TestButton3 buttonWithType:UIButtonTypeCustom];
    button3 = button;
    button.frame = CGRectMake(10, button2.bottom + 10, kScreenWidth - 20, h);
    // button.backgroundColor = [UIColor orangeColor];
    kBorder(button)
        // kShadow(button)
        kBorder(button.imageView) kBorder(button.titleLabel)[self foo:button];

    button.imageEdgeInsets = UIEdgeInsetsMake(
        0, 0, 0, -button.titleLabel.intrinsicContentSize.width);
    button.titleEdgeInsets =
        UIEdgeInsetsMake(0, -button.currentImage.size.width, 0, 0);
    button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
  }

  {
    TestButton3* button = [TestButton3 buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, button3.bottom + 10, kScreenWidth - 20, h);
    // button.backgroundColor = [UIColor orangeColor];
    kBorder(button)
        // kShadow(button)
        kBorder(button.imageView) kBorder(button.titleLabel)[self foo:button];

    [button
        setImageEdgeInsets:UIEdgeInsetsMake(
                               -button.titleLabel.intrinsicContentSize.height,
                               0, 0,
                               -button.titleLabel.intrinsicContentSize.width)];
    // [button
    // setTitleEdgeInsets:UIEdgeInsetsMake(button.currentImage.size.height,
    // -button.currentImage.size.width, 0, 0)];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(
                                   button.currentImage.size.height + 20,
                                   -button.currentImage.size.width, 0, 0)];
  }
}

- (void)foo:(UIButton*)button {
  // 默认是YES 高亮效果, 取消高亮效果
  [button setAdjustsImageWhenHighlighted:NO];

  [button setTitle:@"你好吗世界" forState:UIControlStateNormal];
  [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

  // button.titleLabel.font = [UIFont systemFontOfSize:16];
  button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];

  [button setImage:[UIImage imageNamed:@"player_btn_pause_normal"]
          forState:UIControlStateNormal];
  // [button setImage:[UIImage imageNamed:@"selectedImage"]
  // forState:UIControlStateSelected];

  [button addTarget:self
                action:@selector(btnClicked:)
      forControlEvents:UIControlEventTouchUpInside];

  // [self addSubview:button];
  // [self.contentView addSubview:button];
  [self.view addSubview:button];

  // [button mas_makeConstraints:^(MASConstraintMaker *make) {
  //   make.left.mas_equalTo(self.view.mas_left).offset(0);
  //   make.right.mas_equalTo(self.view.mas_right).offset(0);
  //   make.top.mas_equalTo(self.view.mas_top).offset(0);
  //   make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
  //
  //   make.width.mas_equalTo(50);
  //   make.height.mas_equalTo(50);
  // }];
}

- (void)btnClicked:(UIButton*)sender {
  NSLog(@"%s", __func__);
  NSLog(@"%@", sn.randomString);
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
