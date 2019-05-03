//
//  T051ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T051ViewController.h"
#import "CGRectModel.h"

@interface T051ViewController ()

@end

@implementation T051ViewController

// 【iOS】CGRectDivide
// https://www.jianshu.com/p/c94b0637f41b
// http://ju.outofmemory.cn/entry/119786

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  // [self gridLayout];
  // [self gridLayoutWithPadding];

  //
  [self gridLayoutByOOP];
  // [self gridLayoutWithPaddingByOOP];
}

// 生成小网格
- (void)addGrid:(CGRect)rect {

  UIView *gridView = [UIView.alloc initWithFrame:rect];

  // gridView.layer.borderWidth = 0.5;
  // gridView.layer.borderColor = [UIColor colorWithHue:drand48() saturation:1 brightness:1 alpha:1].CGColor;

  gridView.backgroundColor = [UIColor colorWithHue:drand48() saturation:1 brightness:1 alpha:1];

  [self.view addSubview:gridView];

}

// 网格布局
- (void)gridLayout {
  CGFloat   gridWidth      = (kScreenWidth / 10);
  CGFloat   gridHeight     = (kScreenHeight / 20);
  CGFloat   navHeight      = kStatusBarHeight + kNavigationBarHeight;
  NSInteger numberOfRow    = (NSInteger) floor((self.view.bounds.size.height - navHeight - kSafeAreaBottomHeight) / gridHeight);
  NSInteger numberOfColumn = (NSInteger) floor((self.view.bounds.size.width) / gridWidth);
  CGRect    slice;
  CGRect    rowReminder    = CGRectMake(0, navHeight, self.view.bounds.size.width, self.view.bounds.size.height - navHeight - kSafeAreaBottomHeight);
  CGRect    columnReminder;

  for (NSInteger i = 0; i < numberOfRow; ++i) {
    CGRectDivide(rowReminder, &slice, &rowReminder, gridHeight, CGRectMinYEdge);

    columnReminder = slice;

    for (NSInteger j = 0; j < numberOfColumn; ++j) {
      CGRectDivide(columnReminder, &slice, &columnReminder, gridWidth, CGRectMinXEdge);
      [self addGrid:slice];
    }
  }
}

- (void)rectDividedWithPading:(CGRect)rect slice:(CGRect *)slice reminder:(CGRect *)reminder amout:(CGFloat)amout padding:(CGFloat)padding edge:(CGRectEdge)edge {
  CGRectDivide(rect, slice, &rect, amout, edge);
  CGRect tmpSlice;
  CGRectDivide(rect, &tmpSlice, reminder, padding, edge);
}

// 带padding的网格布局
- (void)gridLayoutWithPadding {

  CGFloat paddingX = 3;
  CGFloat paddingY = 5;

  CGFloat   gridWidth      = (kScreenWidth / 10);
  CGFloat   gridHeight     = (kScreenHeight / 20);
  CGFloat   navHeight      = kStatusBarHeight + kNavigationBarHeight;
  NSInteger numberOfRow    = (NSInteger) floor((self.view.bounds.size.height - navHeight - kSafeAreaBottomHeight) / gridHeight);
  NSInteger numberOfColumn = (NSInteger) floor((self.view.bounds.size.width) / gridWidth);
  CGRect    slice;
  CGRect    rowReminder    = CGRectMake(0, navHeight, self.view.bounds.size.width, self.view.bounds.size.height - navHeight - kSafeAreaBottomHeight);
  CGRect    columnReminder;

  for (NSInteger i = 0; i < numberOfRow; ++i) {
    [self rectDividedWithPading:rowReminder slice:&slice reminder:&rowReminder amout:gridHeight padding:paddingY edge:CGRectMinYEdge];
    columnReminder = slice;
    for (NSInteger j = 0; j < numberOfColumn; ++j) {
      [self rectDividedWithPading:columnReminder slice:&slice reminder:&columnReminder amout:gridWidth padding:paddingX edge:CGRectMinXEdge];
      [self addGrid:slice];
    }
  }
}

// 利用面向对象的方式来使用CGRectDivide

// 利用面向对象的方式来使用CGRectDivide
- (void)gridLayoutByOOP {
  CGFloat   gridWidth      = (kScreenWidth / 10);
  CGFloat   gridHeight     = (kScreenHeight / 20);
  CGFloat   navHeight      = kStatusBarHeight + kNavigationBarHeight;
  NSInteger numberOfRow    = (NSInteger) floor((self.view.bounds.size.height - navHeight - kSafeAreaBottomHeight) / gridHeight);
  NSInteger numberOfColumn = (NSInteger) floor((self.view.bounds.size.width) / gridWidth);

  CGRectModel *horizontalRectModel = [CGRectModel.alloc initWithRect:CGRectMake(0, navHeight, self.view.bounds.size.width, self.view.bounds.size.height - navHeight - kSafeAreaBottomHeight)];
  CGRectModel *verticalRectModel;

  for (NSInteger i = 0; i < numberOfRow; ++i) {

    NSDictionary<NSString *, NSValue *> *tmpTuple = [horizontalRectModel dividedWithAmout:gridHeight edge:CGRectMinYEdge];
    horizontalRectModel = [CGRectModel.alloc initWithRect:tmpTuple[@"reminder"].CGRectValue];
    verticalRectModel   = [CGRectModel.alloc initWithRect:tmpTuple[@"slice"].CGRectValue];

    for (NSInteger j = 0; j < numberOfColumn; ++j) {

      NSDictionary<NSString *, NSValue *> *tuple = [verticalRectModel dividedWithAmout:gridWidth edge:CGRectMinXEdge];

      verticalRectModel = [CGRectModel.alloc initWithRect:tuple[@"reminder"].CGRectValue];

      [self addGrid:tuple[@"slice"].CGRectValue];
    }
  }
}

- (void)gridLayoutWithPaddingByOOP {
  CGFloat   paddingX       = 3;
  CGFloat   paddingY       = 5;
  CGFloat   gridWidth      = (kScreenWidth / 10);
  CGFloat   gridHeight     = (kScreenHeight / 20);
  CGFloat   navHeight      = kStatusBarHeight + kNavigationBarHeight;
  NSInteger numberOfRow    = (NSInteger) floor((self.view.bounds.size.height - navHeight - kSafeAreaBottomHeight) / gridHeight);
  NSInteger numberOfColumn = (NSInteger) floor((self.view.bounds.size.width) / gridWidth);

  CGRectModel *horizontalRectModel = [CGRectModel.alloc initWithRect:CGRectMake(0, navHeight, self.view.bounds.size.width, self.view.bounds.size.height - navHeight - kSafeAreaBottomHeight)];
  CGRectModel *verticalRectModel;

  for (NSInteger i = 0; i < numberOfRow; ++i) {

    NSDictionary<NSString *, NSValue *> *tmpTuple = [horizontalRectModel dividedWithPadding:paddingY amout:gridHeight edge:CGRectMinYEdge];
    horizontalRectModel = [CGRectModel.alloc initWithRect:tmpTuple[@"reminder"].CGRectValue];
    verticalRectModel   = [CGRectModel.alloc initWithRect:tmpTuple[@"slice"].CGRectValue];

    for (NSInteger j = 0; j < numberOfColumn; ++j) {

      NSDictionary<NSString *, NSValue *> *tuple = [verticalRectModel dividedWithPadding:paddingX amout:gridWidth edge:CGRectMinXEdge];
      verticalRectModel = [CGRectModel.alloc initWithRect:tuple[@"reminder"].CGRectValue];
      [self addGrid:tuple[@"slice"].CGRectValue];
    }
  }
}


@end
    