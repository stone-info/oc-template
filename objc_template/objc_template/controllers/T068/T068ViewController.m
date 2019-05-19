//
//  T068ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T068ViewController.h"
#import "T068View.h"
// RACReplaySubject:重复提供信号类，RACSubject的子类。
//
// RACReplaySubject与RACSubject区别:
//
// RACReplaySubject可以先发送信号，在订阅信号，RACSubject就不可以。

// RAC 5.0 以后是 swift了 , 怎么和我知道的不一样??? 不是 3.0 ? 难道是 ReactiveObjC 3.0以后是 swift? 那单独开一个项目搞蛋

// https://stackoverflow.com/questions/27459746/adding-space-padding-to-a-uilabel
// @interface CustomLabel : UILabel
//
// @property (assign, nonatomic) UIEdgeInsets textInsets;
//
// @end
//
// @implementation CustomLabel
//
// - (instancetype)init {
//   if (self = [super init]) {
//     _textInsets = UIEdgeInsetsZero;
//   }
//   return self;
// }
//
// - (instancetype)initWithFrame:(CGRect)frame {
//   if (self = [super initWithFrame:frame]) {
//     _textInsets = UIEdgeInsetsZero;
//   }
//   return self;
// }
//
// - (void)drawTextInRect:(CGRect)rect {
//   [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
// }
//
// // 内在内容尺寸
// - (CGSize)intrinsicContentSize {
//   // let size = super.intrinsicContentSize
//   // return CGSize(width: size.width + leftInset + rightInset,
//   //   height: size.height + topInset + bottomInset)
//   CGSize size = [super intrinsicContentSize];
//
//   return CGSizeMake(size.width + _textInsets.left + _textInsets.right, size.height + _textInsets.top + _textInsets.bottom);
// }
//
// @end
//sn_note:=========  ============================ stone 🐳 ===========/

// 解决block 循环引用 block 内部使用 下划线来访问 能解决? 如: _name , 好像有道理 , 这样 block 内部 无需保存self

@interface T068ViewController ()
@property (weak, nonatomic) UITextField *field;
@end

@implementation T068ViewController {
  // RACReplaySubject *_subject;
  id         _content;
  __weak UILabel     *_label;
  __strong RACSignal *_signal;
  RACSubject *_subject;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.view.backgroundColor = UIColor.lightTextColor;
  [self entry];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

}

- (void)injected {

  [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  // [self.views removeAllObjects];
  // self.views = nil;
  [self entry];
}

- (void)entry {
  // [self demo1];
  // [self demo2];
  // [self demo3];

  T068View *view = T068View.new;

  [self.view addSubview:view];

  kMasKey(view);
  [view mas_makeConstraints:^(MASConstraintMaker *make) {
    /** button */
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(200);

  }];

  [view.buttonClickSignal subscribeNext:^(id x) {
    // NSLog(@"接收到 x = %@", x);
    NSLog(@"接收到 x = %@", x);

    if ([x isKindOfClass:[UIColor class]]) {
      UIColor *color = (UIColor *) x;
      view.backgroundColor = color;
    }
  }];
}

- (void)demo3 {
  UITextField *field = makeTextField(YES);
  _field = field;

  [self.view addSubview:field];

  [field mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  UILabel *label = makeLabel(YES);
  _label = label;

  [self.view addSubview:label];

  [label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(field.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];


  //
  RACSubject *subject = [RACSubject subject];
  _subject = subject;

  [subject subscribeNext:^(id x) {
    NSLog(@"接收到 x = %@", x);
    _label.text = x;
  }];

  [subject subscribeNext:^(id x) {
    NSLog(@"接收到 x = %@", x);
    _field.text = x;
  }];
}

- (void)demo2 {
  UILabel *label = [self makeLabel];
  _label = label;
  kMasKey(label);
  [label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(50);
    make.right.offset(-50);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  UILabel *uiLabel = makeLabel(YES);
  [self.view addSubview:uiLabel];
  kMasKey(uiLabel);
  [uiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(label.mas_bottom).offset(10);
    make.left.offset(50);
    make.right.offset(-50);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
    [subscriber sendNext:_content];
    [subscriber sendCompleted];
    return [RACDisposable disposableWithBlock:^{

      NSLog(@"销毁 %s", __func__);
      uiLabel.text = @"销毁";
    }];
  }];

  _signal = signal;


  // - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  //   NSLog(@"%s", __func__);
  //
  //   _content = kStringFormat(@"%@%@", sn.randomString, sn.randomString);
  //
  //   RACDisposable *disposable = [_signal subscribeNext:^(id x) {
  //     NSLog(@"接收信号 x = %@", x);
  //     _label.text = x;
  //   }];
  //   //
  //   // [disposable dispose];
  //   // [disposable dispose];
  //   // [disposable dispose];
  //   // [disposable dispose];
  //
  // }
}

- (void)demo1 {
  UIButton *button1 = [self makeButton];

  [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_equalTo(50);
  }];

  UIButton *button2 = [self makeButton];

  [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(button1.mas_bottom).offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_equalTo(50);
  }];

  UISlider *slider = [self makeSlider];

  [slider mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(button2.mas_bottom).offset(10);
    make.left.offset(50);
    make.right.offset(-50);
    make.height.mas_equalTo(50);
  }];

  UILabel *label = [self makeLabel];

  kMasKey(label);
  [label mas_makeConstraints:^(MASConstraintMaker *make) {

    make.top.mas_equalTo(slider.mas_bottom).offset(10);
    make.left.offset(50);
    make.right.offset(-50);
    make.height.mas_equalTo(50);
  }];

  RACReplaySubject *subject = [RACReplaySubject subject];

  _subject = subject;

  [subject subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
    [button1 setTitle:kStringFormat(@"%@", x) forState:UIControlStateNormal];
  }];

  [subject subscribeNext:^(id x) {
    NSLog(@"x = %@", x);
    label.text = kStringFormat(@"%@", x);
  }];

  // [subject subscribeNext:^(id x) {
  //   NSLog(@"x = %@", x);
  //   button1.backgroundColor = x;
  // }];
  //
  // [subject subscribeNext:^(id x) {
  //   NSLog(@"x = %@", x);
  //   button2.backgroundColor = x;
  // }];

  // [subject sendNext:@"hello 订阅者们"];
  // [subject sendNext:sn.randomColor];

}

- (void)btnClicked:(UIButton *)sender {
  NSLog(@"%s", __func__);
}

- (UIButton *)makeButton {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];

  button.layer.borderWidth   = 1.0;
  button.layer.borderColor   = [UIColor orangeColor].CGColor;
  button.layer.cornerRadius  = 4.0;
  button.layer.masksToBounds = YES;

  [button setAdjustsImageWhenHighlighted:NO];
  [button setTitle:@"Click me" forState:UIControlStateNormal];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
  [button addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:button];

  return button;
}

- (UILabel *)makePaddingLabel {

  UIView *view = UIView.new;

  [self.view addSubview:view];

  return nil;
}

- (UILabel *)makeLabel {

  UILabel *label = UILabel.new;
  // CustomLabel *label = CustomLabel.new;
  // label.textInsets = UIEdgeInsetsMake(15.f, 15.f, 15.f, 15.f); // 设置左内边距

  label.layer.borderWidth   = 1.0;
  label.layer.borderColor   = HexRGBA(@"#C0C0C0", 1.0).CGColor;
  label.layer.cornerRadius  = 4.0;
  label.layer.masksToBounds = YES;

  label.textAlignment = NSTextAlignmentCenter;
  label.textColor     = UIColor.whiteColor;
  label.numberOfLines = 0;

  [self.view addSubview:label];

  return label;
}

- (UISlider *)makeSlider {

  UISlider *slider = UISlider.new;
  [self.view addSubview:slider];

  [slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];

  return slider;
}

- (void)sliderValueChanged:(UISlider *)sender {

  [_subject sendNext:@(sender.value)];
}
@end
    
