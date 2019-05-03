//
//  PersonOC.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import "PersonOC.h"
#import <IGListKit/IGListDiffable.h>

@interface PersonOC () <IGListDiffable>
@property (strong, nonatomic) NSNumber *pk;

@end

@implementation PersonOC

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
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {

  if (!other) { return NO; }
  if (self == other) { return YES; }

  return [self.name isEqualToString:[(PersonOC *) other name]];

  // return [self.name isEqualToString:[other name]] && [self.handle isEqualToString:[other handle]];
}

@end