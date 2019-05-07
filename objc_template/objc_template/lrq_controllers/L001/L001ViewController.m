//
//  L001ViewController.m
//  objc_template
//
//  Created by lirenqiang2 on 2019-05-06.
//  Copyright © 2019 lirenqiang2. All rights reserved.
//
#import "L001ViewController.h"
 #import "ChapterViewController.h"
 #import "SLSingleSectionViewController.h"
@interface L001ViewController ()
@property (strong, nonatomic) NSDictionary               *options;
@property (strong, nonatomic) NSMutableArray<SNButton *> *buttons;
@property (nonatomic, strong) UIScrollView               *scrollView;
@end

@implementation L001ViewController

- (NSMutableArray<SNButton *> *)buttons {

  if (_buttons == nil) {
    _buttons = [NSMutableArray<SNButton *> array];
  }
  return _buttons;
}

- (NSDictionary *)options {

  if (_options == nil) {
    _options = @{
      @"borderColor"     : HexRGBA(@"#CCCCCC", 1.0),
      @"borderWidth"     : @1,
      @"type"            : @(UIButtonTypeSystem),
      @"font"            : [UIFont fontWithName:@"PingFangSC-Regular" size:14],
      @"backgroundColor" : [UIColor whiteColor],
      @"titleColorNormal": UIColor.blackColor,
      @"masksToBounds"   : @YES,
      @"borderRadius"    : @4.f,
    };
  }
  return _options;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];

  UIScrollView *scrollView = [[UIScrollView alloc] init];
  {
    self.scrollView                         = scrollView;
    scrollView.backgroundColor              = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];

    kMasKey(scrollView);
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.insets(UIEdgeInsetsZero); }];
  }

  [self main];

  // layout
  {
    UIView *contentView = UIView.new;
    contentView.backgroundColor = UIColor.whiteColor;
    [scrollView addSubview:contentView];

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.mas_equalTo(scrollView);
      make.width.mas_equalTo(scrollView);
    }];

    SNButton *lastView = nil;
    CGFloat  height    = 55;

    for (NSUInteger i = 0; i < self.buttons.count; i++) {
      SNButton *view = self.buttons[i];
      [contentView addSubview:view];

      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView ? lastView.mas_bottom : view.superview).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
        // make.width.mas_equalTo(contentView.mas_width);
        make.height.mas_equalTo(height);
      }];
      lastView = view;
    }

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(lastView.mas_bottom).offset(10);
    }];
  }
}

- (SNButton *)makeButtonWithTitle:(NSString *)title action:(nullable void (^)(SNButton *sender))action {
  NSMutableDictionary *dictionary = self.options.mutableCopy;
  dictionary[@"titleNormal"] = title;

  if (action) { dictionary[@"action"] = action; }

  SNButton *button = [SNButton makeButtonWithOptions:dictionary];
  [self.buttons addObject:button];

  return button;
}

- (void)main {
  // [self demo1];
  // [self demo2];
  NSMutableArray<NSString *> *arrM = [NSMutableArray array];

  Class        cls      = self.class;
  unsigned int count    = 0;
  Method       *pMethod = class_copyMethodList(cls, &count);
  for (int     i        = 0; i < count; i++) {
    Method   pObjc_method = pMethod[i];
    SEL      pSelector    = method_getName(pObjc_method);
    NSString *methodName  = NSStringFromSelector(pSelector);
    if ([methodName hasPrefix:@"demo"]) {
      [arrM addObject:methodName];
    }
  }

  [arrM sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
    return [obj1 localizedCompare:obj2];
  }];

  for (NSUInteger i = 0; i < arrM.count; ++i) {
    NSString *methodName = arrM[i];
    // NSLog(@"methodName = %@", methodName);
    [self performSelector:NSSelectorFromString(methodName)];
  }
}

 - (UIColor *)randomColor {
   CGFloat hue        = (arc4random() % 256 / 256.0);  //  0.0 to 1.0
   CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from white
   CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from black
   return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
 }

- (void)demo1 {
  [self makeButtonWithTitle:@"Chapter Section Demo" action:^(SNButton *sender) {
    ChapterViewController *controller = [ChapterViewController new];
    [self.navigationController pushViewController:controller animated:YES];
  }];
}

- (void)demo2 {
  [self makeButtonWithTitle:@"Chapter Single Section Demo" action:^(SNButton *sender) {
    SLSingleSectionViewController *controller = [SLSingleSectionViewController new];
    [self.navigationController pushViewController:controller animated:YES];
  }];
}

@end
