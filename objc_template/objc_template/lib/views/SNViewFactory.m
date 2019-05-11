//
//  SNViewFactory.m
//  objc_template
//
//  Created by stone on 2019/5/11.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNViewFactory.h"

static void addBoard(__kindof UIView *view) {
  view.layer.borderWidth   = 1.0;
  view.layer.borderColor   = HexRGBA(@"#C0C0C0", 1.0).CGColor;
  view.layer.cornerRadius  = 4.0;
  view.layer.masksToBounds = YES;
}

UIView *makeView() {

  UIView *view = UIView.new;

  addBoard(view);

  view.backgroundColor = UIColor.whiteColor;

  return view;
}

UILabel *makeLabel() {
  UILabel *label = UILabel.new;

  addBoard(label);
  // layer
  // label.layer.borderWidth   = 1.0;
  // label.layer.borderColor   = HexRGBA(@"#C0C0C0", 1.0).CGColor;
  // label.layer.cornerRadius  = 4.0;
  // label.layer.masksToBounds = YES;

  /** GPU 优化 */
  label.opaque              = YES;
  label.backgroundColor     = [UIColor whiteColor];
  label.layer.masksToBounds = YES;
  //------------------------------
  label.numberOfLines       = 0;
  label.textColor           = [UIColor blackColor];
  label.textAlignment       = NSTextAlignmentCenter;
  // label.text                = @"";
  label.font                = [UIFont fontWithName:@"PingFangSC-Regular" size:14];

  return label;
}

UIButton *makeButton() {

  UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];

  addBoard(button);

  // button.layer.borderWidth   = 1.0;
  // button.layer.borderColor   = HexRGBA(@"#C0C0C0", 1.0).CGColor;
  // button.layer.cornerRadius  = 4.0;
  // button.layer.masksToBounds = YES;

  [button setAdjustsImageWhenHighlighted:NO];

  [button setTitle:@"Click me" forState:UIControlStateNormal];

  [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

  button.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];

  return button;

}

UIImageView *makeImageView() {
  UIImageView *imageView = UIImageView.new;

  addBoard(imageView);
  // layer
  // imageView.layer.borderWidth   = 1.0;
  // imageView.layer.borderColor   = HexRGBA(@"#C0C0C0", 1.0).CGColor;
  // imageView.layer.cornerRadius  = 4.0;
  // imageView.layer.masksToBounds = YES;

  // UI优化
  // https://www.jianshu.com/p/85837799f3eb
  imageView.opaque                = YES;
  // imageView.layer.cornerRadius    = 14.0;
  // imageView需要这步操作, 因为layer.contents
  // imageView.layer.masksToBounds   = YES;
  // 光栅化
  imageView.layer.shouldRasterize = YES;

  // imageView.backgroundColor       = UIColor.whiteColor;

  return imageView;
}

UISlider *makeSlider() {

  UISlider *slider = UISlider.new;

  addBoard(slider);

  slider.value = 0;

  return slider;
}

UITextField *makeTextField() {

  UITextField *field = UITextField.new;
  field.placeholder        = @"placeholder";
  field.textAlignment      = NSTextAlignmentNatural;
  field.borderStyle        = UITextBorderStyleRoundedRect;
  field.clearButtonMode    = UITextFieldViewModeWhileEditing;
  field.keyboardAppearance = UIKeyboardAppearanceDefault;
  field.returnKeyType      = UIReturnKeyDone;
  field.font               = [UIFont fontWithName:@"PingFangSC-Regular" size:14];

  return field;
}

@implementation SNViewFactory

@end
