//
//  FeedItem.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import "FeedItem.h"
#import "User.h"
#import <IGListKit/IGListDiffable.h>

@interface FeedItem () <IGListDiffable>
@property (strong, nonatomic) NSNumber *pk;

@end

@implementation FeedItem

- (instancetype)initWithPk:(NSNumber *)pk user:(User *)user comments:(NSArray<NSString *> *)comments {
  self = [super init];
  if (self) {
    self.pk       = pk;
    self.user     = user;
    self.comments = comments;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return self.pk;
}

- (BOOL)isEqualToDiffableObject:(nullable FeedItem <IGListDiffable> *)other {

  // other 不存在
  if (!other) { return NO; }
  // other 存在 且 全等
  if (self == other) { return YES; }
  // other 存在 指针不同, 使用diff算法
  return [self.user isEqualToDiffableObject:other.user] && [self.comments isEqualToArray:other.comments];

  // return [self.name isEqualToString:[other name]] && [self.handle isEqualToString:[other handle]];
}

@end

