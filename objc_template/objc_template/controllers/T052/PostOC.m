//
//  PostOC.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import "PostOC.h"
#import "CommentOC.h"

@interface PostOC ()

@end

@implementation PostOC

// - (instancetype)initWithUsername:(NSString *)username timestamp:(NSString *)timestamp imageURL:(NSURL *)imageURL likes:(NSNumber*)likes comments:(NSArray<CommentOC *> *)comments {
- (instancetype)initWithUsername:(NSString *)username timestamp:(NSString *)timestamp imageURL:(NSURL *)imageURL likes:(NSInteger)likes comments:(NSArray<CommentOC *> *)comments {
  self = [super init];
  if (self) {
    self.username  = username;
    self.timestamp = timestamp;
    self.imageURL  = imageURL;
    self.likes     = likes;
    self.comments  = comments;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return kStringFormat(@"%@%@", _username, _timestamp);
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {

  return YES;
}


@end
