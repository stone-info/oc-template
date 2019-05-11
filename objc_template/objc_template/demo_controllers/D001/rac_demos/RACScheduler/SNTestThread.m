//
// Created by stone on 2019-05-11.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "SNTestThread.h"

@interface SNTestThread ()

@end

@implementation SNTestThread {}

- (void)dealloc {
  NSLog(@"■■■■■■\t%@ is dead ☠☠☠\t■■■■■■", [self class]);
}

@end