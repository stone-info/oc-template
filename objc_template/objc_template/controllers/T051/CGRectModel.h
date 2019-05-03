//
// Created by stone on 2019-05-03.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CGRectModel : NSObject
- (instancetype)initWithRect:(CGRect)rect;
- (NSDictionary<NSString *, NSValue *> *)dividedWithAmout:(CGFloat)amout edge:(CGRectEdge)edge;
- (NSDictionary<NSString *, NSValue *> *)dividedWithPadding:(CGFloat)padding amout:(CGFloat)amout edge:(CGRectEdge)edge;
@end