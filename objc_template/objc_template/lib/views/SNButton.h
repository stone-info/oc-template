//
//  SNButton.h
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// @class SNButton;

// typedef void(^SNButtonAction)(SNButton *sender);

@interface SNButton : UIButton

+ (instancetype)makeButton;

+ (instancetype)makeButtonWithOptions:(NSDictionary *)options;

@property (copy, nonatomic) void (^action)(SNButton *);

@end

NS_ASSUME_NONNULL_END
