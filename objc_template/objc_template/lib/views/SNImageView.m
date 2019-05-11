//
//  SNImageView.m
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNImageView.h"
#import <Masonry/Masonry.h>
#import "SNAttributesHandler.h"

@interface SNImageView ()

@property (weak, nonatomic) UIToolbar *toolbar;

@end

@implementation SNImageView

+ (instancetype)makeImageView {

  return [self makeImageViewWithOptions:@{@"borderColor": HexRGBA(@"#CCCCCC", 1.0), @"borderWidth": @1}];
}

- (void)tapHandle:(UITapGestureRecognizer *)sender {
  // NSLog(@"%s", __func__);
  !self.action ?: self.action(sender);
}

+ (instancetype)makeImageViewWithOptions:(NSDictionary *)options {

  SNImageView *view;

  if (options[@"image"]) {
    view = [[SNImageView alloc] initWithImage:options[@"image"]];
    if (options[@"frame"]) {
      view.frame = [options[@"frame"] CGRectValue];
    }
  } else {
    if (options[@"frame"]) {
      view = [[SNImageView alloc] initWithFrame:[options[@"frame"] CGRectValue]];
    } else {
      view = [[SNImageView alloc] init];
    }
  }

  for (NSString *key in options) {
    id obj = options[key];
    [SNAttributesHandler commonAttributes:view key:key obj:obj];
    [SNAttributesHandler featureAttributeWithImageView:view key:key obj:obj];
  }

  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:view action:@selector(tapHandle:)];
  [view addGestureRecognizer:tap];

  return view;



  // // UI优化
  // // https://www.jianshu.com/p/85837799f3eb
  // imageView.opaque                = YES;
  // imageView.layer.cornerRadius    = options[@"borderRadius"] ? [options[@"borderRadius"] floatValue] : 0.f;
  // // imageView需要这步操作, 因为layer.contents
  // imageView.layer.masksToBounds   = options[@"masksToBounds"] ? [options[@"masksToBounds"] boolValue] : NO;
  // // imageView.clipsToBounds = NO; // 裁剪, 和 masksToBounds 一样, 写法不一样
  // // 光栅化
  // imageView.layer.shouldRasterize = YES;
  // imageView.backgroundColor       = options[@"backgroundColor"] ? options[@"backgroundColor"] : HexRGBA(@"#CCCCCC", 1.0);
  // // imageView.image                 = options[@"image"] ? options[@"image"] : kImageWithName(@"abc009"); // 默认图片
  //
  // // 重新绘制(核心绘图) drawRect
  // // UIViewContentModeRedraw,              // redraw on bounds change (calls -setNeedsDisplay)
  //
  // // 带有scale, 标明图片有可能被拉伸或压缩
  // // UIViewContentModeScaleToFill,
  //
  // // aspect 比例, 缩放是带有比例的
  // // 宽高比不变, fit 适应
  // // UIViewContentModeScaleAspectFit,      // contents scaled to fit with fixed aspect. remainder is transparent
  // // 宽高比不变, 填充, 多余的部分溢出来
  // // UIViewContentModeScaleAspectFill,     // contents scaled to fill with fixed aspect. some portion of content may be clipped.
  //
  // // 不带有scale, 标明图片不可能被拉伸或压缩
  // // UIViewContentModeCenter,              // contents remain same size. positioned adjusted.
  // // UIViewContentModeTop,
  // // UIViewContentModeBottom,
  // // UIViewContentModeLeft,
  // // UIViewContentModeRight,
  // // UIViewContentModeTopLeft,
  // // UIViewContentModeTopRight,
  // // UIViewContentModeBottomLeft,
  // // UIViewContentModeBottomRight,
  // imageView.contentMode = options[@"contentMode"] ? [options[@"contentMode"] integerValue] : UIViewContentModeScaleToFill;
  //
  // if (options[@"glass"] && [options[@"glass"] boolValue] == YES) {
  //   // https://www.jianshu.com/p/d115836ed3fa
  //
  //   // iOS2.0
  //   // UIToolbar *toolbar = UIToolbar.new;
  //   // imageView.toolbar = toolbar;
  //   // toolbar.barStyle  = UIBarStyleDefault;
  //   // toolbar.alpha     = 0.8;
  //   // // bar.frame = CGRectMake(0, 0, imageView.width, imageView.height);
  //   // [imageView addSubview:toolbar];
  //   // [bar mas_makeConstraints:^(MASConstraintMaker *make) {
  //   //   make.top.mas_equalTo(imageView.mas_top).offset(0);
  //   //   make.left.mas_equalTo(imageView.mas_left).offset(0);
  //   //   make.right.mas_equalTo(imageView.mas_right).offset(0);
  //   //   make.bottom.mas_equalTo(imageView.mas_bottom).offset(0);
  //   // }];
  //
  //   // iOS8.0 UIVisuaEffectView
  //   UIBlurEffect       *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
  //   UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
  //   [imageView addSubview:visualView];
  //   [visualView mas_makeConstraints:^(MASConstraintMaker *make) {
  //     make.top.mas_equalTo(imageView.mas_top).offset(0);
  //     make.left.mas_equalTo(imageView.mas_left).offset(0);
  //     make.right.mas_equalTo(imageView.mas_right).offset(0);
  //     make.bottom.mas_equalTo(imageView.mas_bottom).offset(0);
  //   }];
  // }
  // return imageView;
}

- (void)setImageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName {

  [self setImageWithBundleName:bundleName imageName:imageName extension:nil];
}

// iOS中imageNamed 和 imageWithContentOfFile的区别
// 如果图片较小,并且频繁使用的图片,使用imageName:来加载图片(按钮图片/主页图片/占位图)
// 如果图片较大,并且使用次数较少,使用 imageWithContentOfFile:来加载(相册/版本新特性)
// 一.资源打包
//  图片是被放在image.xcassets里面
//  部署版本在>=iOS8.0时,打包的资源包图片被放在Assets.car中 ,图片被压缩
//  部署版本在<iOS8.0时,打包的资源包图片被放在MainBudnle中,图片没有被压缩
//  图片如果是被直接拖到项目当中,无论部署版本是多少,都会被放到MainBundle中,图片没有被压缩
// 二.内存分配
//  使用imageNamed:加载图片
//  加载到内存中后,会一直停留在内存中,不会随着对象销毁而销毁
//  加载进图片后,占用的内存归系统管理,我们无法管理
//  相同的图片,图片不会重新加载
//  加载到内存中后,占据内存空间较大
//  使用 imageWithContentOfFile:加载图片
//  加载到内存中后,占据内存空间比较小
//  相同的图片会被重复加载到内存中
//  对象销毁的时候,加载到内存中得图片会被一起销毁
- (void)setImageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName extension:(NSString *__nullable)extension {

  NSString *resource;

  if (extension) {
    resource = [NSString stringWithFormat:@"%@/%@.%@", bundleName, imageName, extension];
  } else {
    resource = [NSString stringWithFormat:@"%@/%@", bundleName, imageName];
  }

  NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:nil];
  self.image = [UIImage imageWithContentsOfFile:path];
}

- (void)setAction:(void (^)(UITapGestureRecognizer *))action {
  _action = [action copy];
  self.userInteractionEnabled = YES;
}

- (void)layoutSubviews {
  // 一定要调用super的layoutSubviews
  [super layoutSubviews];
  // _toolbar.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}

@end
