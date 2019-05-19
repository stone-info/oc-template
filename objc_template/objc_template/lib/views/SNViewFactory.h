//
//  SNViewFactory.h
//  objc_template
//
//  Created by stone on 2019/5/11.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN UILabel *makeLabel(BOOL board);

UIKIT_EXTERN UIButton *makeButton(BOOL board);

UIKIT_EXTERN UIImageView *makeImageView(BOOL board);

UIKIT_EXTERN UISlider *makeSlider(BOOL board);

UIKIT_EXTERN UITextField *makeTextField(BOOL board);

NS_ASSUME_NONNULL_BEGIN

@interface SNViewFactory : NSObject

@end

NS_ASSUME_NONNULL_END
