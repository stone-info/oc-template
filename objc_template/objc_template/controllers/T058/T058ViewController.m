//
//  T058ViewController.m
//  objc_template
//
//  Created by stone on 2019-05-06.
//  Copyright © 2019 stone. All rights reserved.
//
#import "T058ViewController.h"
#import <YYText/YYText.h>
#import <YYImage/YYImage.h>
#import "NSString+YYAdd.h"
#import "UIImage+YYWebImage.h"
#import "NSBundle+YYAdd.h"

@interface T058ViewController () <YYTextViewDelegate>
@property (strong, nonatomic) NSMutableArray<__kindof UIView *> *views;
@property (nonatomic, strong) UIScrollView                      *scrollView;
@property (nonatomic, strong) YYTextView                        *textView;
@end

@implementation T058ViewController

- (NSMutableArray<__kindof UIView *> *)views {

  if (_views == nil) {
    _views = [NSMutableArray<__kindof UIView *> array];
  }
  return _views;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  [self entry];
}

- (void)entry {

  if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
    self.automaticallyAdjustsScrollViewInsets = NO;
  }

  self.view.backgroundColor = [UIColor whiteColor];

  UIScrollView *scrollView = [[UIScrollView alloc] init];
  {
    self.scrollView                         = scrollView;
    scrollView.backgroundColor              = [UIColor whiteColor];
    scrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:scrollView];

    kMasKey(scrollView);
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0)); }];
  }

  if (@available(iOS 11.0, *)) {
    // 取消自动调整内边距
    scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  } else {
    // view.automaticallyAdjustsScrollViewInsets = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
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

    __kindof UIView *lastView = nil;
    CGFloat         height    = 150;

    for (NSUInteger i = 0; i < self.views.count; i++) {
      __kindof UIView *view = self.views[i];
      [contentView addSubview:view];

      [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lastView ? lastView.mas_bottom : view.superview).offset(10);
        make.left.offset(10);
        make.right.offset(-10);
        // make.width.mas_equalTo(contentView.mas_width);
        make.height.mas_equalTo(i == (self.views.count - 1) ? 200 : height);
      }];
      lastView = view;
    }

    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(lastView.mas_bottom).offset(10);
    }];
  }
}

- (YYLabel *)makeYYLabelWithAttributedString:(NSAttributedString *)attributedString {
  YYLabel *label = [YYLabel new];
  label.attributedText        = attributedString;
  // label.textAlignment         = NSTextAlignmentCenter;
  label.textAlignment         = NSTextAlignmentLeft;
  label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
  label.numberOfLines         = 0;
  label.backgroundColor       = HexRGBA(@"#F0F0F0", 1.0);
  [self.views addObject:label];

  return label;
}

- (void)main {
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

  NSLog(@"arrM = %@", arrM);

  for (NSUInteger i = 0; i < arrM.count; ++i) {
    NSString *methodName = arrM[i];
    // NSLog(@"methodName = %@", methodName);
    [self performSelector:NSSelectorFromString(methodName)];
  }
}

- (void)demo01 {
  NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"Shadow"];
  text.yy_font  = [UIFont boldSystemFontOfSize:30];
  text.yy_color = [UIColor whiteColor];

  YYTextShadow *shadow = YYTextShadow.new;
  shadow.color       = HexRGBA(@"#FFC1C1", 1.0);
  shadow.offset      = CGSizeMake(0, 1);
  shadow.radius      = 5;
  text.yy_textShadow = shadow;
  [self makeYYLabelWithAttributedString:text];
}

- (void)demo02 {

  NSMutableAttributedString *text = NSMutableAttributedString.new;

  NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Inner Shadow"];
  one.yy_font  = [UIFont boldSystemFontOfSize:30];
  one.yy_color = [UIColor whiteColor];
  YYTextShadow *shadow = [YYTextShadow new];
  shadow.color           = [UIColor colorWithWhite:0.000 alpha:0.40];
  shadow.offset          = CGSizeMake(0, 1);
  shadow.radius          = 1;
  one.yy_textInnerShadow = shadow;

  [text appendAttributedString:one];
  [self makeYYLabelWithAttributedString:text];
}

- (void)demo03 {

  NSMutableAttributedString *text = NSMutableAttributedString.new;
  {
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Multiple Shadows"];
    one.yy_font  = [UIFont boldSystemFontOfSize:30];
    one.yy_color = [UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000];

    YYTextShadow *shadow = [YYTextShadow new];
    shadow.color  = [UIColor colorWithWhite:0.000 alpha:0.20];
    shadow.offset = CGSizeMake(0, -1);
    shadow.radius = 1.5;
    YYTextShadow *subShadow = [YYTextShadow new];
    subShadow.color   = [UIColor colorWithWhite:1 alpha:0.99];
    subShadow.offset  = CGSizeMake(0, 1);
    subShadow.radius  = 1.5;
    shadow.subShadow  = subShadow;
    one.yy_textShadow = shadow;

    YYTextShadow *innerShadow = [YYTextShadow new];
    innerShadow.color      = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
    innerShadow.offset     = CGSizeMake(0, 1);
    innerShadow.radius     = 1;
    one.yy_textInnerShadow = innerShadow;

    [text appendAttributedString:one];
  }

  [self makeYYLabelWithAttributedString:text];
}

- (void)demo04 {
  NSMutableAttributedString *text = NSMutableAttributedString.new;
  {
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Background Image"];
    one.yy_font  = [UIFont boldSystemFontOfSize:30];
    one.yy_color = [UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000];

    CGSize  size        = CGSizeMake(20, 20);
    UIImage *background = [UIImage yy_imageWithSize:size drawBlock:^(CGContextRef context) {
      UIColor *c0 = [UIColor colorWithRed:0.054 green:0.879 blue:0.000 alpha:1.000];
      UIColor *c1 = [UIColor colorWithRed:0.869 green:1.000 blue:0.030 alpha:1.000];
      [c0 setFill];
      CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
      [c1 setStroke];
      CGContextSetLineWidth(context, 2);
      for (int i = 0; i < size.width * 2; i += 4) {
        CGContextMoveToPoint(context, i, -2);
        CGContextAddLineToPoint(context, i - size.height, size.height + 2);
      }
      CGContextStrokePath(context);
    }];
    one.yy_color = [UIColor colorWithPatternImage:background];

    [text appendAttributedString:one];
  }

  [self makeYYLabelWithAttributedString:text];
}

- (void)demo05 {
  NSMutableAttributedString *text = NSMutableAttributedString.new;
  {
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Border"];
    one.yy_font  = [UIFont boldSystemFontOfSize:30];
    one.yy_color = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];

    YYTextBorder *border = [YYTextBorder new];
    border.strokeColor          = [UIColor colorWithRed:1.000 green:0.029 blue:0.651 alpha:1.000];
    border.strokeWidth          = 3;
    border.lineStyle            = YYTextLineStylePatternCircleDot;
    border.cornerRadius         = 3;
    border.insets               = UIEdgeInsetsMake(0, -4, 0, -4);
    one.yy_textBackgroundBorder = border;

    [text appendAttributedString:one];
  }

  [self makeYYLabelWithAttributedString:text];
}

- (void)demo06 {
  __weak typeof(self)       _self = self;
  NSMutableAttributedString *text = NSMutableAttributedString.new;
  {
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Link"];
    one.yy_font           = [UIFont boldSystemFontOfSize:30];
    one.yy_underlineStyle = NSUnderlineStyleSingle;

    /// 1. you can set a highlight with these code
    /*
        one.yy_color = [UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000];

        YYTextBorder *border = [YYTextBorder new];
        border.cornerRadius = 3;
        border.insets = UIEdgeInsetsMake(-2, -1, -2, -1);
        border.fillColor = [UIColor colorWithWhite:0.000 alpha:0.220];

        YYTextHighlight *highlight = [YYTextHighlight new];
        [highlight setBorder:border];
        highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
            [_self showMessage:[NSString stringWithFormat:@"Tap: %@",[text.string substringWithRange:range]]];
        };
        [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];
    */

    /// 2. or you can use the convenience method
    [one yy_setTextHighlightRange:one.yy_rangeOfAll
         color:[UIColor colorWithRed:0.093 green:0.492 blue:1.000 alpha:1.000]
         backgroundColor:[UIColor colorWithWhite:0.000 alpha:0.220]
         tapAction:^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
           [_self showMessage:[NSString stringWithFormat:@"Tap: %@", [text.string substringWithRange:range]]];
         }];

    [text appendAttributedString:one];
  }

  [self makeYYLabelWithAttributedString:text];
}

- (void)demo07 {
  __weak typeof(self)       _self = self;
  NSMutableAttributedString *text = NSMutableAttributedString.new;
  {
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Another Link"];
    one.yy_font  = [UIFont boldSystemFontOfSize:30];
    one.yy_color = [UIColor redColor];

    YYTextBorder *border = [YYTextBorder new];
    border.cornerRadius         = 50;
    border.insets               = UIEdgeInsetsMake(0, -10, 0, -10);
    border.strokeWidth          = 0.5;
    border.strokeColor          = one.yy_color;
    border.lineStyle            = YYTextLineStyleSingle;
    one.yy_textBackgroundBorder = border;

    YYTextBorder *highlightBorder = border.copy;
    highlightBorder.strokeWidth = 0;
    highlightBorder.strokeColor = one.yy_color;
    highlightBorder.fillColor   = one.yy_color;

    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setColor:[UIColor whiteColor]];
    [highlight setBackgroundBorder:highlightBorder];
    highlight.tapAction = ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect) {
      [_self showMessage:[NSString stringWithFormat:@"Tap: %@", [text.string substringWithRange:range]]];
    };
    [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];

    [text appendAttributedString:one];
  }
  [self makeYYLabelWithAttributedString:text];
}

- (void)demo08 {
  __weak typeof(self)       _self = self;
  NSMutableAttributedString *text = NSMutableAttributedString.new;
  {
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"Yet Another Link"];
    one.yy_font  = [UIFont boldSystemFontOfSize:30];
    one.yy_color = [UIColor whiteColor];

    YYTextShadow *shadow = [YYTextShadow new];
    shadow.color      = [UIColor colorWithWhite:0.000 alpha:0.490];
    shadow.offset     = CGSizeMake(0, 1);
    shadow.radius     = 5;
    one.yy_textShadow = shadow;

    YYTextShadow *shadow0 = [YYTextShadow new];
    shadow0.color  = [UIColor colorWithWhite:0.000 alpha:0.20];
    shadow0.offset = CGSizeMake(0, -1);
    shadow0.radius = 1.5;
    YYTextShadow *shadow1 = [YYTextShadow new];
    shadow1.color     = [UIColor colorWithWhite:1 alpha:0.99];
    shadow1.offset    = CGSizeMake(0, 1);
    shadow1.radius    = 1.5;
    shadow0.subShadow = shadow1;

    YYTextShadow *innerShadow0 = [YYTextShadow new];
    innerShadow0.color  = [UIColor colorWithRed:0.851 green:0.311 blue:0.000 alpha:0.780];
    innerShadow0.offset = CGSizeMake(0, 1);
    innerShadow0.radius = 1;

    YYTextHighlight *highlight = [YYTextHighlight new];
    [highlight setColor:[UIColor colorWithRed:1.000 green:0.795 blue:0.014 alpha:1.000]];
    [highlight setShadow:shadow0];
    [highlight setInnerShadow:innerShadow0];
    [one yy_setTextHighlight:highlight range:one.yy_rangeOfAll];

    [text appendAttributedString:one];
  }
  [self makeYYLabelWithAttributedString:text];
}

- (void)demo09 {

  NSMutableAttributedString *text = [NSMutableAttributedString new];

  UIFont *font = [UIFont systemFontOfSize:16];
  {
    UIImage *image = [UIImage imageNamed:@"dribbble64_imageio"];

    image = [UIImage imageWithCGImage:image.CGImage scale:3 orientation:UIImageOrientationUp];

    NSMutableAttributedString *attachText = [NSMutableAttributedString
      yy_attachmentStringWithContent:image
      contentMode:UIViewContentModeCenter
      attachmentSize:image.size
      alignToFont:font
      alignment:YYTextVerticalAlignmentCenter];

    [text appendAttributedString:attachText];

    NSString *title = @"This is UIImage attachment:This is UIImage attachment:This is UIImage attachment:This is UIImage attachment:This is UIImage attachment:";

    [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];

    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
  }

  [self makeYYLabelWithAttributedString:text];
}

- (void)demo10 {

  NSMutableAttributedString *text = [NSMutableAttributedString new];

  UIFont *font = [UIFont systemFontOfSize:16];
  {
    NSString *title = @"This is UIView attachment: ";

    [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];

    UISwitch *switcher = [UISwitch new];
    [switcher sizeToFit];

    NSMutableAttributedString *attachText = [NSMutableAttributedString
      yy_attachmentStringWithContent:switcher
      contentMode:UIViewContentModeCenter
      attachmentSize:switcher.size
      alignToFont:font
      alignment:YYTextVerticalAlignmentCenter];

    [text appendAttributedString:attachText];

    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
  }

  [self makeYYLabelWithAttributedString:text];
}

- (void)demo11 {

  NSMutableAttributedString *text = [NSMutableAttributedString new];

  UIFont *font = [UIFont systemFontOfSize:16];
  {
    NSString *title = @"This is Animated Image attachment:";
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];

    NSArray       *names = @[@"001", @"022", @"019", @"056", @"085"];
    for (NSString *name in names) {
      NSString *path  = [[NSBundle mainBundle] pathForScaledResource:name ofType:@"gif" inDirectory:@"EmoticonQQ.bundle"];
      NSData   *data  = [NSData dataWithContentsOfFile:path];
      YYImage  *image = [YYImage imageWithData:data scale:2];
      image.preloadAllAnimatedImageFrames = YES;
      YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];

      NSMutableAttributedString *attachText = [NSMutableAttributedString yy_attachmentStringWithContent:imageView contentMode:UIViewContentModeCenter attachmentSize:imageView.size alignToFont:font alignment:YYTextVerticalAlignmentCenter];
      [text appendAttributedString:attachText];
    }

    [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
  }

  [self makeYYLabelWithAttributedString:text];
}

- (void)demo12 {

  NSMutableAttributedString *text = [NSMutableAttributedString new];

  UIFont *font = [UIFont systemFontOfSize:16];
  {
    NSString *title = @"This is Animated Image attachment:";
    [text appendAttributedString:[[NSAttributedString alloc] initWithString:title attributes:nil]];

    // 加载 asset 资源里 竟然不起作用, 什么鬼...
    YYImage *image = [YYImage imageNamed:@"pia"];
    image.preloadAllAnimatedImageFrames = YES;
    YYAnimatedImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
    imageView.autoPlayAnimatedImage = NO;
    [imageView startAnimating];

    NSMutableAttributedString *attachText = [NSMutableAttributedString
      yy_attachmentStringWithContent:imageView
      contentMode:UIViewContentModeCenter
      attachmentSize:imageView.size
      alignToFont:font
      alignment:YYTextVerticalAlignmentBottom];

    [text appendAttributedString:attachText];
  }

  [self makeYYLabelWithAttributedString:text];
}

- (void)demo13 {

  NSMutableDictionary *mapper = [NSMutableDictionary new];
  mapper[@":smile:"]    = [self imageWithName:@"002"];
  mapper[@":cool:"]     = [self imageWithName:@"013"];
  mapper[@":biggrin:"]  = [self imageWithName:@"047"];
  mapper[@":arrow:"]    = [self imageWithName:@"007"];
  mapper[@":confused:"] = [self imageWithName:@"041"];
  mapper[@":cry:"]      = [self imageWithName:@"010"];
  mapper[@":wink:"]     = [self imageWithName:@"085"];

  YYTextSimpleEmoticonParser *parser = [YYTextSimpleEmoticonParser new];
  parser.emoticonMapper = mapper;

  YYTextLinePositionSimpleModifier *mod = [YYTextLinePositionSimpleModifier new];
  mod.fixedLineHeight = 22;

  YYTextView *textView = [YYTextView new];
  textView.backgroundColor       = HexRGBA(@"#F0F0F0", 1.0);
  textView.text                  = @"Hahahah:smile:, it\'s emoticons::cool::arrow::cry::wink:\n\nYou can input \":\" + \"smile\" + \":\" to display smile emoticon, or you can copy and paste these emoticons.\n";
  textView.font                  = [UIFont systemFontOfSize:17];
  textView.textParser            = parser;
  textView.size                  = self.view.size;
  textView.linePositionModifier  = mod;
  textView.textContainerInset    = UIEdgeInsetsMake(10, 10, 10, 10);
  textView.delegate              = self;
  if (kiOS7Later) {
    textView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;
  }
  textView.contentInset          = UIEdgeInsetsMake(64, 0, 0, 0);
  textView.scrollIndicatorInsets = textView.contentInset;

  [self.views addObject:textView];
}

- (void)demo14 {

  NSMutableAttributedString *text = [NSMutableAttributedString new];

  if (kSystemVersion < 8) {
    [text yy_appendString:@"Only support iOS8 Later"];
    text.yy_font = [UIFont systemFontOfSize:30];

  } else {
    NSMutableAttributedString *one = [[NSMutableAttributedString alloc] initWithString:@"这是用汉语写的一段文字。"];
    one.yy_font = [UIFont boldSystemFontOfSize:30];

    YYTextRubyAnnotation *ruby;
    ruby = [YYTextRubyAnnotation new];
    ruby.textBefore = @"hàn yŭ";
    [one yy_setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"汉语"]];

    ruby = [YYTextRubyAnnotation new];
    ruby.textBefore = @"wén";
    [one yy_setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"文"]];

    ruby = [YYTextRubyAnnotation new];
    ruby.textBefore = @"zì";
    ruby.alignment  = kCTRubyAlignmentCenter;
    [one yy_setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"字"]];

    [text appendAttributedString:one];
    [text appendAttributedString:[self padding]];

    one = [[NSMutableAttributedString alloc] initWithString:@"日本語で書いた作文です。"];
    one.yy_font = [UIFont boldSystemFontOfSize:30];

    ruby = [YYTextRubyAnnotation new];
    ruby.textBefore = @"に";
    [one yy_setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"日"]];

    ruby = [YYTextRubyAnnotation new];
    ruby.textBefore = @"ほん";
    [one yy_setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"本"]];

    ruby = [YYTextRubyAnnotation new];
    ruby.textBefore = @"ご";
    [one yy_setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"語"]];

    ruby = [YYTextRubyAnnotation new];
    ruby.textBefore = @"か";
    [one yy_setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"書"]];

    ruby = [YYTextRubyAnnotation new];
    ruby.textBefore = @"さく";
    [one yy_setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"作"]];

    ruby = [YYTextRubyAnnotation new];
    ruby.textBefore = @"ぶん";
    [one yy_setTextRubyAnnotation:ruby range:[one.string rangeOfString:@"文"]];

    [text appendAttributedString:one];
  }

  YYLabel *label = [YYLabel new];
  label.attributedText        = text;
  label.width                 = self.view.width - 60;
  label.centerX               = self.view.width / 2;
  label.height                = self.view.height - (kiOS7Later ? 64 : 44) - 60;
  label.top                   = (kiOS7Later ? 64 : 0) + 30;
  label.textAlignment         = NSTextAlignmentCenter;
  label.textVerticalAlignment = YYTextVerticalAlignmentCenter;
  label.numberOfLines         = 0;
  label.backgroundColor       = [UIColor colorWithWhite:0.933 alpha:1.000];
  // [self.view addSubview:label];

  [self.views addObject:label];
}

- (void)injected {
  [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  [self.views removeAllObjects];
  self.views = nil;
  [self entry];
}

- (void)showMessage:(NSString *)msg {
  CGFloat padding = 10;

  YYLabel *label = [YYLabel new];
  label.text          = msg;
  label.font          = [UIFont systemFontOfSize:16];
  label.textAlignment = NSTextAlignmentCenter;

  label.textColor          = [UIColor whiteColor];
  label.backgroundColor    = [UIColor colorWithRed:0.033 green:0.685 blue:0.978 alpha:0.730];
  label.width              = self.view.width;
  label.textContainerInset = UIEdgeInsetsMake(padding, padding, padding, padding);
  label.height             = [msg heightForFont:label.font width:label.width] + 2 * padding;

  label.bottom = (kiOS7Later ? 64 : 0);
  [self.view addSubview:label];
  [UIView animateWithDuration:0.3 animations:^{
    label.top = (kiOS7Later ? kStatusBarHeight + kNavigationBarHeight + 10 : 0);
  } completion:^(BOOL finished) {
    [UIView animateWithDuration:0.2 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
      label.bottom = (kiOS7Later ? 64 : 0);
    } completion:^(BOOL finished) {
      [label removeFromSuperview];
    }];
  }];
}

- (NSAttributedString *)padding {
  NSMutableAttributedString *pad = [[NSMutableAttributedString alloc] initWithString:@"\n\n"];
  pad.yy_font = [UIFont systemFontOfSize:4];
  return pad;
}

- (UIImage *)imageWithName:(NSString *)name {
  NSBundle *bundle = [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"EmoticonQQ" ofType:@"bundle"]];
  NSString *path   = [bundle pathForScaledResource:name ofType:@"gif"];
  NSData   *data   = [NSData dataWithContentsOfFile:path];
  YYImage  *image  = [YYImage imageWithData:data scale:2];
  image.preloadAllAnimatedImageFrames = YES;
  return image;
}

- (void)edit:(UIBarButtonItem *)item {
  if (_textView.isFirstResponder) {
    [_textView resignFirstResponder];
  } else {
    [_textView becomeFirstResponder];
  }
}

- (void)textViewDidBeginEditing:(YYTextView *)textView {
  UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self
                                                  action:@selector(edit:)];
  self.navigationItem.rightBarButtonItem = buttonItem;
}

- (void)textViewDidEndEditing:(YYTextView *)textView {
  self.navigationItem.rightBarButtonItem = nil;
}


@end

