//
//  Month.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import "Month.h"

@interface Month ()

@end

@implementation Month

- (instancetype)initWithName:(NSString *)name days:(NSNumber *)days appointments:(NSDictionary<NSNumber *, NSArray<NSString *> *> *)appointments {
  self = [super init];
  if (self) {
    self.name         = name;
    self.days         = days;
    self.appointments = appointments;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return self.name;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  return YES;
}


@end
