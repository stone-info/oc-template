//
//  User.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import "User.h"

@interface User ()

@end

@implementation User

- (instancetype)initWithPk:(NSNumber *)pk name:(NSString *)name handle:(NSString *)handle {
  self = [super init];
  if (self) {
    self.pk     = pk;
    self.name   = name;
    self.handle = handle;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return self.pk;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {

  if (self == other) { return YES; }
  if (!other) { return NO; }

  return [self.name isEqualToString:[(User*)other name]] && [self.handle isEqualToString:[(User *)other handle]];
}

@end

