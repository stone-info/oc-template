//
//  SNColorBoard.m
//  objc_template
//
//  Created by stone on 2019/5/9.
//  Copyright © 2019 stone. All rights reserved.
//

#define kScreenWidth    [UIScreen mainScreen].bounds.size.width
#define kScreenHeight   [UIScreen mainScreen].bounds.size.height

#import "SNColorBoard.h"

@interface SNColorBoard ()

@property (weak, nonatomic) UITextField *redTextField;
@property (weak, nonatomic) UITextField *greenTextField;
@property (weak, nonatomic) UITextField *blueTextField;
@property (weak, nonatomic) UITextField *alphaTextField;
@property (weak, nonatomic) UITextField *hexTextField;

@property (weak, nonatomic) UISlider *redSlider;
@property (weak, nonatomic) UISlider *greenSlider;
@property (weak, nonatomic) UISlider *blueSlider;
@property (weak, nonatomic) UISlider *alphaSlider;
// @property (weak, nonatomic) __kindof UIView *view;
@end

@implementation SNColorBoard

// - (instancetype)initWithTargetView:(__kindof UIView *)view {
//   self = [super init];
//   if (self) {
//     self.view = view;
//     [self addView];
//     [self addTarget];
//   }
//   return self;
// }

- (void)layoutSubviews {
  [super layoutSubviews];

  // kMasKey(board);
  // [board mas_makeConstraints:^(MASConstraintMaker *make) {
  //   make.bottom.offset(0);
  //   make.centerX.offset(0);
  //   make.width.mas_equalTo(kScreenWidth);
  //   make.height.mas_equalTo(180);
  // }];

}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    self.backgroundColor = HexRGBA(@"#C0C0C0", 1.0);

    [self addView];
    [self addTarget];

    CGFloat height = 220;
    self.frame = CGRectMake(0, kScreenHeight - height - 34, kScreenWidth, height);
    [UIApplication.sharedApplication.keyWindow addSubview:self];
  }
  return self;
}

- (void)changeColor {
  UIColor *color = [UIColor colorWithRed:self.redSlider.value / 255.0 green:self.greenSlider.value / 255.0 blue:self.blueSlider.value / 255.0 alpha:self.alphaSlider.value];

  // 2
  //
  // let rgbRedValue = 200
  // let rgbGreenValue = 13
  // let rgbBlueValue = 45
  //
  // let hexValue = String(format:"%02X", Int(rgbRedValue)) + String(format:"%02X", Int(rgbGreenValue)) + String(format:"%02X", Int(rgbBlueValue))

  NSString *R = [NSString stringWithFormat:@"%02X", (int) self.redSlider.value];
  NSString *G = [NSString stringWithFormat:@"%02X", (int) self.greenSlider.value];
  NSString *B = [NSString stringWithFormat:@"%02X", (int) self.blueSlider.value];

  // NSString *string = [NSString stringWithFormat:@"%@%@%@", R, G, B];

  self.hexTextField.text = [NSString stringWithFormat:@"HexRGBA(@\"#%@%@%@\", %.1f)", R, G, B, self.alphaSlider.value];

  !self.changeColorWithBlock ?: self.changeColorWithBlock(color);
}

- (void)addTarget {
  [self.redTextField addTarget:self action:@selector(redTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
  [self.greenTextField addTarget:self action:@selector(greenTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
  [self.blueTextField addTarget:self action:@selector(blueTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
  [self.alphaTextField addTarget:self action:@selector(alphaTextFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];

  [self.redSlider addTarget:self action:@selector(redSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
  [self.greenSlider addTarget:self action:@selector(greenSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
  [self.blueSlider addTarget:self action:@selector(blueSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
  [self.alphaSlider addTarget:self action:@selector(alphaSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)redSliderValueChanged:(UISlider *)sender {
  self.redTextField.text = [NSString stringWithFormat:@"%d", (int) sender.value];
  [self changeColor];
}

- (void)greenSliderValueChanged:(UISlider *)sender {
  self.greenTextField.text = [NSString stringWithFormat:@"%d", (int) sender.value];
  [self changeColor];
}

- (void)blueSliderValueChanged:(UISlider *)sender {
  self.blueTextField.text = [NSString stringWithFormat:@"%d", (int) sender.value];
  [self changeColor];
}

- (void)alphaSliderValueChanged:(UISlider *)sender {
  self.alphaTextField.text = [NSString stringWithFormat:@"%.2f", sender.value];
  [self changeColor];
}

- (void)redTextFieldEditingChanged:(SNTextField *)sender {
  NSString *string = sender.text;

  // NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(0\\.\\d+)|(1\\.\\d+)|(\\d+)|(\\d+\\.\\d+)" options:NSRegularExpressionCaseInsensitive error:nil];
  // NSArray<NSTextCheckingResult *> *matche_list = [regex matchesInString:string options:(NSMatchingOptions) kNilOptions range:NSMakeRange(0, string.length)];
  //
  // NSLog(@"matche_list = %@", matche_list);
  //
  // for (NSTextCheckingResult       *match in matche_list) {
  //   NSRange range = [match rangeAtIndex:0];
  //   NSString *substring = [string substringWithRange:range];
  //   NSLog(@"substring = %@", substring);
  // }

  NSString    *regex     = @"(0\\.\\d+)|(1\\.\\d+)|(\\d+)|(\\d+\\.\\d+)";
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
  if (![predicate evaluateWithObject:string]) { return; }
  self.redSlider.value = [string floatValue];

  [self changeColor];
}

- (void)greenTextFieldEditingChanged:(SNTextField *)sender {
  NSString    *string    = sender.text;
  NSString    *regex     = @"(0\\.\\d+)|(1\\.\\d+)|(\\d+)|(\\d+\\.\\d+)";
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
  if (![predicate evaluateWithObject:string]) { return; }
  self.greenSlider.value = [string floatValue];

  [self changeColor];
}

- (void)blueTextFieldEditingChanged:(SNTextField *)sender {
  NSString    *string    = sender.text;
  NSString    *regex     = @"(0\\.\\d+)|(1\\.\\d+)|(\\d+)|(\\d+\\.\\d+)";
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
  if (![predicate evaluateWithObject:string]) { return; }
  self.blueSlider.value = [string floatValue];

  [self changeColor];
}

- (void)alphaTextFieldEditingChanged:(SNTextField *)sender {
  NSString    *string    = sender.text;
  NSString    *regex     = @"(0\\.\\d+)|(1\\.\\d+)|(\\d+)|(\\d+\\.\\d+)";
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
  if (![predicate evaluateWithObject:string]) { return; }
  self.alphaSlider.value = [string floatValue];

  [self changeColor];
}

- (void)setupTextField:(UITextField *)textField {
  textField.textAlignment      = NSTextAlignmentNatural;
  textField.borderStyle        = UITextBorderStyleRoundedRect;
  textField.keyboardAppearance = UIKeyboardAppearanceDark;
  textField.returnKeyType      = UIReturnKeyDone;
  textField.font               = [UIFont fontWithName:@"PingFangSC-Regular" size:11];
  textField.keyboardType       = UIKeyboardTypeNumberPad;
  textField.text               = @"0";
}

- (void)setupSlider:(UISlider *)slider {
  slider.maximumValue = 255;
  slider.minimumValue = 0;
  slider.value        = 0;
}

- (void)addView {

  UITextField *redTextField   = UITextField.new;
  UITextField *greenTextField = UITextField.new;
  UITextField *blueTextField  = UITextField.new;
  UITextField *alphaTextField = UITextField.new;
  UITextField *hexTextField   = UITextField.new;

  [self setupTextField:redTextField];
  [self setupTextField:greenTextField];
  [self setupTextField:blueTextField];
  [self setupTextField:alphaTextField];
  [self setupTextField:hexTextField];

  [self addSubview:redTextField];
  [self addSubview:greenTextField];
  [self addSubview:blueTextField];
  [self addSubview:alphaTextField];
  [self addSubview:hexTextField];

  alphaTextField.text = @"1.00";
  hexTextField.text   = @"HexRGBA(@\"#000000\", 1.0)";

  [hexTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(10);
    make.right.offset(-10);
    make.left.offset(10);
  }];

  [redTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(hexTextField.mas_bottom).offset(10);
    make.right.offset(-10);
    make.width.mas_equalTo(50);
  }];

  [greenTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(redTextField.mas_bottom).offset(10);
    make.right.offset(-10);
    make.width.mas_equalTo(50);
  }];

  [blueTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(greenTextField.mas_bottom).offset(10);
    make.right.offset(-10);
    make.width.mas_equalTo(50);
  }];

  [alphaTextField mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(blueTextField.mas_bottom).offset(10);
    make.right.offset(-10);
    make.width.mas_equalTo(50);
  }];

  UISlider *redSlider   = UISlider.new;
  UISlider *greenSlider = UISlider.new;
  UISlider *blueSlider  = UISlider.new;
  UISlider *alphaSlider = UISlider.new;

  [self setupSlider:redSlider];
  [self setupSlider:greenSlider];
  [self setupSlider:blueSlider];
  [self setupSlider:alphaSlider];

  alphaSlider.maximumValue = 1.0;
  alphaSlider.minimumValue = 0;
  alphaSlider.value        = 1.0;

  [self addSubview:redSlider];
  [self addSubview:greenSlider];
  [self addSubview:blueSlider];
  [self addSubview:alphaSlider];

  [redSlider mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.edges.insets(UIEdgeInsetsZero);
    make.centerY.mas_equalTo(redTextField.mas_centerY).offset(0);
    make.right.mas_equalTo(redTextField.mas_left).offset(-10);
    make.left.offset(30);
  }];

  [greenSlider mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.edges.insets(UIEdgeInsetsZero);
    make.centerY.mas_equalTo(greenTextField.mas_centerY).offset(0);
    make.right.mas_equalTo(greenTextField.mas_left).offset(-10);
    make.left.offset(30);
  }];

  [blueSlider mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.edges.insets(UIEdgeInsetsZero);
    make.centerY.mas_equalTo(blueTextField.mas_centerY).offset(0);
    make.right.mas_equalTo(blueTextField.mas_left).offset(-10);
    make.left.offset(30);
  }];

  [alphaSlider mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.edges.insets(UIEdgeInsetsZero);
    make.centerY.mas_equalTo(alphaTextField.mas_centerY).offset(0);
    make.right.mas_equalTo(alphaTextField.mas_left).offset(-10);
    make.left.offset(30);
  }];

  UILabel *redLabel   = UILabel.new;
  UILabel *greenLabel = UILabel.new;
  UILabel *blueLabel  = UILabel.new;
  UILabel *alphaLabel = UILabel.new;

  redLabel.text   = @"R";
  greenLabel.text = @"G";
  blueLabel.text  = @"B";
  alphaLabel.text = @"A";

  [self addSubview:redLabel];
  [self addSubview:greenLabel];
  [self addSubview:blueLabel];
  [self addSubview:alphaLabel];

  [redLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.mas_equalTo(redTextField.mas_centerY).offset(0);
    make.right.mas_equalTo(redSlider.mas_left).offset(-10);
    make.left.offset(10);
  }];

  [greenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.mas_equalTo(greenTextField.mas_centerY).offset(0);
    make.right.mas_equalTo(greenSlider.mas_left).offset(-10);
    make.left.offset(10);
  }];

  [blueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.mas_equalTo(blueTextField.mas_centerY).offset(0);
    make.right.mas_equalTo(blueSlider.mas_left).offset(-10);
    make.left.offset(10);
  }];

  [alphaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.mas_equalTo(alphaTextField.mas_centerY).offset(0);
    make.right.mas_equalTo(alphaSlider.mas_left).offset(-10);
    make.left.offset(10);
  }];

  self.redTextField   = redTextField;
  self.greenTextField = greenTextField;
  self.blueTextField  = blueTextField;
  self.alphaTextField = alphaTextField;
  self.hexTextField   = hexTextField;

  self.redSlider   = redSlider;
  self.greenSlider = greenSlider;
  self.blueSlider  = blueSlider;
  self.alphaSlider = alphaSlider;
}
@end
