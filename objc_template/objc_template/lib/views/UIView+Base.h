//
//  UIView+Base.h
//  objc_template
//
//  Created by stone on 2019/4/5.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Base)

// rotate
- (void)rotateMakeWithAngle:(CGFloat)angle xAxis:(CGFloat)xAxis yAxis:(CGFloat)yAxis zAxis:(CGFloat)zAxis;

- (void)rotateMakeWithAngle:(CGFloat)angle;

- (void)rotateMakeWithRadian:(CGFloat)radian xAxis:(CGFloat)xAxis yAxis:(CGFloat)yAxis zAxis:(CGFloat)zAxis;

- (void)rotateMakeWithRadian:(CGFloat)radian;

// scale
- (void)scaleMakeWithSx:(CGFloat)sx sy:(CGFloat)sy sz:(CGFloat)sz;

- (void)scaleMakeWithMultiple:(CGFloat)multiple;

// translate
- (void)translationMakeWithTx:(CGFloat)tx ty:(CGFloat)ty tz:(CGFloat)tz;
@end

NS_ASSUME_NONNULL_END
