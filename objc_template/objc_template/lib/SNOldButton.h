//
//  SNOldButton.h
//  006_UIAdvanced
//
//  Created by stone on 2018/7/29.
//  Copyright © 2018年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const SNButtonStateNormalImage;
UIKIT_EXTERN NSString *const SNButtonStateHighlightedImage;
UIKIT_EXTERN NSString *const SNButtonStateNormalTitle;
UIKIT_EXTERN NSString *const SNButtonStateNormalTitleColor;
UIKIT_EXTERN NSString *const SNButtonTitleLabelFont;
UIKIT_EXTERN NSString *const SNButtonBorder;

@class SNOldButton;

typedef void(^SNButtonAction)(SNOldButton *sender);

@interface SNOldButton : UIButton

@property(nullable, nonatomic, copy) SNButtonAction       tapAction;
@property(strong, nonatomic) NSDictionary<NSString *, id> *attributes;

- (instancetype)initWithFrame:(CGRect)frame
                addAttributes:(NSDictionary *)addAttributes
                    tapAction:(SNButtonAction)tapAction;

- (instancetype)initWithFrame:(CGRect)frame
                    tapAction:(SNButtonAction)tapAction
                addAttributes:(NSDictionary *)addAttributes;

@end
