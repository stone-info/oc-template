//
//  ImageViewModel.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import "ImageViewModel.h"

@interface ImageViewModel ()

@end

@implementation ImageViewModel

- (instancetype)initWithUrl:(NSURL *)url {
  self = [super init];
  if (self) {
    self.url = url;
  }

  return self;
}

- (instancetype)init {
  self = [super init];
  if (self) {

  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return @"image";
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {


  // other 不存在
  if (!other) { return NO; }

  // other 存在 且 全等
  if (self == other) { return YES; }

  // other 存在 指针不同, 使用diff算法
  ImageViewModel *model = (ImageViewModel *) other;
  return [self.url isEqual:model.url];
}


@end
