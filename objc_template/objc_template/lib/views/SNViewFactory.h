//
//  SNViewFactory.h
//  objc_template
//
//  Created by stone on 2019/5/11.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN UILabel *makeLabel();

UIKIT_EXTERN UIButton *makeButton();

UIKIT_EXTERN UIImageView *makeImageView();

UIKIT_EXTERN UISlider *makeSlider();

UIKIT_EXTERN UITextField *makeTextField();

NS_ASSUME_NONNULL_BEGIN

@interface SNViewFactory : NSObject

@end

NS_ASSUME_NONNULL_END
