//
//  ActionViewModel.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T80ActionViewModel.h"

@interface T80ActionViewModel ()

@end

@implementation T80ActionViewModel
- (instancetype)initWithLikes:(NSInteger)likes {
  self = [super init];
  if (self) {
    self.likes = likes;
  }

  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return @"action"; // 这也是关键... // 和topmodel 一样 , 这个section中 只有一个 action , 可以这么写
  // return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  if (!other) { return NO; }
  if (self == other) { return YES; }
  T80ActionViewModel *model = (T80ActionViewModel *) other;
  return self.likes == model.likes;
}

@end