//
//  UIView+Base.m
//  objc_template
//
//  Created by stone on 2019/4/5.
//  Copyright © 2019 stone. All rights reserved.
//

//由角度获取弧度
// #define kDegreesToRadian(angle) (M_PI * (angle) / 180.0)
//有弧度获取角度
// #define kRadianToDegrees(radian) (radian*180.0)/(M_PI)

// https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/Key-ValueCodingExtensions/Key-ValueCodingExtensions.html

// rotation.x Set to an NSNumber object whose value is the rotation, in radians, in the x axis.
//
// rotation.y Set to an NSNumber object whose value is the rotation, in radians, in the y axis.
//
// rotation.z Set to an NSNumber object whose value is the rotation, in radians, in the z axis.
//
// 设置为NSNumber对象，其值为z轴中的旋转(以弧度表示)。此字段与设置rotes.z字段相同。
// rotation Set to an NSNumber object whose value is the rotation, in radians, in the z axis. This field is identical to setting the rotation.z field.
//
// scale.x Set to an NSNumber object whose value is the scale factor for the x axis.
//
// scale.y Set to an NSNumber object whose value is the scale factor for the y axis.
//
// scale.z Set to an NSNumber object whose value is the scale factor for the z axis.
//
// 设置为NSNumber对象，该对象的值是所有三个缩放因子的平均值。
// scale Set to an NSNumber object whose value is the average of all three scale factors.
//
// translation.x Set to an NSNumber object whose value is the translation factor along the x axis.
//
// translation.y Set to an NSNumber object whose value is the translation factor along the y axis.
//
// translation.z Set to an NSNumber object whose value is the translation factor along the z axis.
//
// 设置为包含NSSize或CGSize数据类型的NSValue对象。该数据类型指示要在x和y轴中转换的数量。
// translation Set to an NSValue object containing an NSSize or CGSize data type. That data type indicates the amount to translate in the x and y axis.

#import "UIView+Base.h"

@implementation UIView (Base)

- (void)rotateMakeWithAngle:(CGFloat)angle xAxis:(CGFloat)xAxis yAxis:(CGFloat)yAxis zAxis:(CGFloat)zAxis {
  self.layer.transform = CATransform3DMakeRotation(kDegreesToRadian(angle), xAxis, yAxis, zAxis);
  // kvc
  // [self.layer setValue:@(kDegreesToRadian(angle)) forKeyPath:@"transform.rotation"]; //默认z轴
  // [self.layer setValue:@(kDegreesToRadian(angle)) forKeyPath:@"transform.rotation.z"];
  // [self.layer setValue:@(kDegreesToRadian(angle)) forKeyPath:@"transform.rotation.x"];
  // [self.layer setValue:@(kDegreesToRadian(angle)) forKeyPath:@"transform.rotation.y"];
}
- (void)rotateMakeWithAngle:(CGFloat)angle {
  [self rotateMakeWithAngle:angle xAxis:0 yAxis:0 zAxis:1];
}

- (void)rotateMakeWithRadian:(CGFloat)radian xAxis:(CGFloat)xAxis yAxis:(CGFloat)yAxis zAxis:(CGFloat)zAxis {
  self.layer.transform = CATransform3DMakeRotation(radian, xAxis, yAxis, zAxis);
}

- (void)rotateMakeWithRadian:(CGFloat)radian {
  [self rotateMakeWithRadian:radian xAxis:0 yAxis:0 zAxis:1];
}


- (void)scaleMakeWithSx:(CGFloat)sx sy:(CGFloat)sy sz:(CGFloat)sz {

  //
  self.layer.transform = CATransform3DMakeScale(sx, sy, sz);

  // kvc
  // [self.layer setValue:@(1.5) forKeyPath:@"transform.scale"];
  // [self.layer setValue:@(1.5) forKeyPath:@"transform.scale.x"];
  // [self.layer setValue:@(1.5) forKeyPath:@"transform.scale.y"];
  // [self.layer setValue:@(1.5) forKeyPath:@"transform.scale.z"];
}

- (void)scaleMakeWithMultiple:(CGFloat)multiple {
  [self scaleMakeWithSx:multiple sy:multiple sz:1];
}

- (void)translationMakeWithTx:(CGFloat)tx ty:(CGFloat)ty tz:(CGFloat)tz {
  //
  self.layer.transform = CATransform3DMakeTranslation(tx, ty, tz);

  // kvc
  // [self.layer setValue:@(1.5) forKeyPath:@"transform.translation"];
  // [self.layer setValue:@(1.5) forKeyPath:@"transform.translation.x"];
  // [self.layer setValue:@(1.5) forKeyPath:@"transform.translation.y"];
  // [self.layer setValue:@(1.5) forKeyPath:@"transform.translation.z"];
}

@end
