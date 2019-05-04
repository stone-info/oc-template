//
//  CommentOC.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import "CommentOC.h"

@interface CommentOC ()

@end

@implementation CommentOC

- (instancetype)initWithUsername:(NSString *)username text:(NSString *)text {
  self = [super init];
  if (self) {
    self.username = username;
    self.text     = text;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return kStringFormat(@"%@%@", _username, _text);
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {

  return YES;
}


@end
