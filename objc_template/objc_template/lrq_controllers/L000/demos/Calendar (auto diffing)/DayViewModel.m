//
//  DayViewModel.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import "DayViewModel.h"

@interface DayViewModel ()

@end

@implementation DayViewModel

- (instancetype)initWithDay:(NSNumber *)day today:(BOOL)today selected:(BOOL)selected appointments:(NSNumber *)appointments {
  self = [super init];
  if (self) {
    self.day          = day;
    self.today        = today;
    self.selected     = selected;
    self.appointments = appointments;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return self.day;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {


  // other 不存在
  if (!other) { return NO; }
  // other 存在 且 全等
  if (self == other) { return YES; }
  // other 存在 指针不同, 使用diff算法

  DayViewModel *object = (DayViewModel *) other;
  return self.today == object.today && self.selected == object.selected && [self.appointments isEqualToNumber:object.appointments];
}


@end
