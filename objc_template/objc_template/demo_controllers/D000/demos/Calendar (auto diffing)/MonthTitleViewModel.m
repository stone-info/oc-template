//
//  MonthTitleViewModel.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import "MonthTitleViewModel.h"

@interface MonthTitleViewModel ()

@end

@implementation MonthTitleViewModel

- (instancetype)initWithName:(NSString *)name {
  self = [super init];
  if (self) {
    self.name = name;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return self.name;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {


  // other 不存在
  if (!other) { return NO; }
  // other 存在 且 全等
  if (self == other) { return YES; }
  // name is checked in the diffidentifier, so we can assume its equal
  return YES;
}


@end

