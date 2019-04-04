//
//  T018ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T018ViewController.h"
#import "SNTextField.h"

@interface T018ViewController ()<UITextFieldDelegate>
@property(strong, nonatomic) SNTextField* field1;
@property(strong, nonatomic) SNTextField* field2;
@end

@implementation T018ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  {
    SNTextField* field = [SNTextField makeTextFieldWithOptions:@{
      @"placeholder" : @"请输入手机号",
      @"textAlignment" : @(NSTextAlignmentNatural),
      @"borderStyle" : @(UITextBorderStyleRoundedRect),
      @"clearButtonMode" : @(UITextFieldViewModeWhileEditing),
      @"keyboardAppearance" : @(UIKeyboardAppearanceDark),
      @"returnKeyType" : @(UIReturnKeyDone),
      @"font" : [UIFont fontWithName:@"PingFangSC-Regular" size:16],
    }];

    self.field1 = field;
    field.delegate = self;

    field.frame = CGRectMake(10, kStatusBarHeight + kNavigationBarHeight + 10,
                             kScreenWidth - 20, 30);

    [self.view addSubview:field];
  }

  {
    SNTextField* field = [SNTextField makeTextFieldWithOptions:@{
      @"placeholder" : @"请输入手机号",
      @"textAlignment" : @(NSTextAlignmentNatural),
      @"borderStyle" : @(UITextBorderStyleRoundedRect),
      @"clearButtonMode" : @(UITextFieldViewModeWhileEditing),
      @"keyboardAppearance" : @(UIKeyboardAppearanceDark),
      @"returnKeyType" : @(UIReturnKeyDone),
      @"font" : [UIFont fontWithName:@"PingFangSC-Regular" size:16],
      @"frame" : sn.valueWithCGRect(
          CGRectMake(10, self.field1.bottom + 10, kScreenWidth - 20, 30))
    }];
    self.field2 = field;
    [self.view addSubview:field];

    [field addTarget:self
                  action:@selector(beginEditing:)
        forControlEvents:UIControlEventEditingDidBegin];
    [field addTarget:self
                  action:@selector(endEditing:)
        forControlEvents:UIControlEventEditingDidEnd];
    [field addTarget:self
                  action:@selector(changedEditing:)
        forControlEvents:UIControlEventEditingChanged];
  }
}

- (void)beginEditing:(SNTextField*)sender {
  NSLog(@"%s", __func__);
}

- (void)endEditing:(SNTextField*)sender {
  NSLog(@"%s", __func__);
}

- (void)changedEditing:(SNTextField*)sender {
  NSLog(@"%s", __func__);
}

- (void)touchesBegan:(NSSet<UITouch*>*)touches
           withEvent:(nullable UIEvent*)event {
  // 退出键盘
  // 方法1:
  // [self.view endEditing:YES];
  // 方法2:
  // [self.field1 resignFirstResponder];
}

// sn_note:========= text field delegate ============================ stone 🐳
// ===========/

- (BOOL)textFieldShouldBeginEditing:(UITextField*)textField {
  NSLog(@"%s", __func__);
  return YES;
}

- (void)textFieldDidBeginEditing:(UITextField*)textField {
  NSLog(@"%s", __func__);
}

- (BOOL)textFieldShouldEndEditing:(UITextField*)textField {
  NSLog(@"%s", __func__);
  return YES;
}

- (void)textFieldDidEndEditing:(UITextField*)textField {
  NSLog(@"%s", __func__);
}

- (void)textFieldDidEndEditing:(UITextField*)textField
                        reason:(UITextFieldDidEndEditingReason)reason {
  NSLog(@"%s", __func__);
}

- (BOOL)textField:(UITextField*)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString*)string {
  NSLog(@"%s", __func__);
  return YES;
}

- (BOOL)textFieldShouldClear:(UITextField*)textField {
  NSLog(@"%s", __func__);
  return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
  NSLog(@"%s", __func__);
  return YES;
}

- (void)demo1 {
}

- (void)injected {
  // [self.view removeAllSubviews];

  // [self demo1];
}

@end
