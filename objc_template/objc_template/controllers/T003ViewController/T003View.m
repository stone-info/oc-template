//
//  T003View.m
//  objective_c_template
//
//  Created by stone on 2019/3/27.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T003View.h"

@interface T003View ()

@property(weak, nonatomic) IBOutlet UIButton* mButton;
@property(weak, nonatomic) IBOutlet UITextField* leftTextField;
@property(weak, nonatomic) IBOutlet UITextField* rightTextField;
@property(weak, nonatomic) IBOutlet UILabel* resultLabel;

@end

@implementation T003View

// 觉醒 一 一 |||
- (void)awakeFromNib {
  [super awakeFromNib];

  // kShadow(self.mButton)
  kBorder(self.mButton)
      // typedef NS_ENUM(NSInteger, UIKeyboardType) {
      //     UIKeyboardTypeDefault,                // Default type for the
      //     current input method.
      //     UIKeyboardTypeASCIICapable,           // Displays a keyboard which
      //     can enter ASCII characters
      //     UIKeyboardTypeNumbersAndPunctuation,  // Numbers and assorted
      //     punctuation.
      //     UIKeyboardTypeURL,                    // A type optimized for URL
      //     entry (shows . / .com prominently).
      //     UIKeyboardTypeNumberPad,              // A number pad with
      //     locale-appropriate digits (0-9, ۰-۹, ०-९, etc.). Suitable for PIN
      //     entry.
      //     UIKeyboardTypePhonePad,               // A phone pad (1-9, *, 0, #,
      //     with letters under the numbers).
      //     UIKeyboardTypeNamePhonePad,           // A type optimized for
      //     entering a person's name or phone number.
      //     UIKeyboardTypeEmailAddress,           // A type optimized for
      //     multiple email address entry (shows space @ . prominently).
      //     UIKeyboardTypeDecimalPad NS_ENUM_AVAILABLE_IOS(4_1),   // A number
      //     pad with a decimal point.
      //     UIKeyboardTypeTwitter NS_ENUM_AVAILABLE_IOS(5_0),      // A type
      //     optimized for twitter text entry (easy access to @ #)
      //     UIKeyboardTypeWebSearch NS_ENUM_AVAILABLE_IOS(7_0),    // A default
      //     keyboard type with URL-oriented addition (shows space .
      //     prominently).
      //     UIKeyboardTypeASCIICapableNumberPad NS_ENUM_AVAILABLE_IOS(10_0), //
      //     A number pad (0-9) that will always be ASCII digits.
      //
      //     UIKeyboardTypeAlphabet = UIKeyboardTypeASCIICapable, // Deprecated
      //
      // };
      self.leftTextField.keyboardType = UIKeyboardTypeNumberPad;
  self.rightTextField.keyboardType = UIKeyboardTypeNumberPad;
}

- (IBAction)calculateButtonClicked:(UIButton*)sender {
  NSInteger sum1 = self.leftTextField.text.integerValue;
  NSInteger sum2 = self.rightTextField.text.integerValue;

  self.resultLabel.text = kStringFormat(@"%zd", sum1 + sum2);
}

@end
