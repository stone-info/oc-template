//
//  LabelsItem.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import "LabelsItem.h"

@interface LabelsItem ()

@end

@implementation LabelsItem

- (instancetype)initWithColor:(UIColor *)color labels1:(NSArray<NSString *> *)labels1 labels2:(NSArray<NSString *> *)labels2 {
  self = [super init];
  if (self) {
    self.color = color;
    self.labels1 = labels1;
    self.labels2 = labels2;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {


  // other 不存在
  if (!other) { return NO; }
  // other 存在 且 全等
  if (self == other) { return YES; }
  // other 存在 指针不同, 使用diff算法
  return [self isEqual:other];
  // return [self.user isEqualToDiffableObject:other.user] && [self.comments isEqualToArray:other.comments];
  // return [self.name isEqualToString:[other name]] && [self.handle isEqualToString:[other handle]];
}


@end
