//
// Created by stone on 2019-05-12.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "T074Person.h"

@interface T074Person ()
@property (strong, nonatomic) NSNumber *pk;
@end

@implementation T074Person {}

- (instancetype)initWithPk:(NSNumber *)pk name:(NSString *)name {
  self = [super init];
  if (self) {
    self.pk   = pk;
    self.name = name;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return self.pk;
  // return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {

  NSLog(@"other = %@", other);

  if (!other) { return NO; }
  if (self == other) { return YES; }

  NSLog(@"会来这里吗?");
  return [self.name isEqualToString:[(T074Person *) other name]];
}
@end