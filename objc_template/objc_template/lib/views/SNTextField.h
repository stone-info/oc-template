//
//  SNTextField.h
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNTextField : UITextField
+ (instancetype)makeTextField;

+ (instancetype)makeTextFieldWithOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
