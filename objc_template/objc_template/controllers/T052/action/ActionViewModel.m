//
//  ActionViewModel.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import "ActionViewModel.h"

@interface ActionViewModel ()

@end

@implementation ActionViewModel
- (instancetype)initWithLikes:(NSInteger)likes {
  self = [super init];
  if (self) {
    self.likes = likes;
  }

  return self;
}

// - (instancetype)initWithLikes:(NSNumber *)likes {
//   self = [super init];
//   if (self) {
//     self.likes = likes;
//   }
//
//   return self;
// }

- (nonnull id <NSObject>)diffIdentifier {
  return @"action";
  // return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {


  // other 不存在
  if (!other) { return NO; }
  // other 存在 且 全等
  if (self == other) { return YES; }
  // other 存在 指针不同, 使用diff算法
  ActionViewModel *model = (ActionViewModel *) other;

  // return self.likes.integerValue == model.likes.integerValue;

  NSLog(@"%s", __func__);
  NSLog(@"self.likes = %li", self.likes);
  NSLog(@"model.likes = %li", model.likes);

  // return YES; // YES 表示相等 , 不更新

  return self.likes == model.likes;
  // return NO;

  // return self.likes == model.likes;
  // return self.likes.integerValue == model.likes.integerValue;

}

@end