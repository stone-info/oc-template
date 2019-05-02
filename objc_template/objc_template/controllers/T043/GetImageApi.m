//
//  GetImageApi.m
//  objc_template
//
//  Created by stone on 2019/4/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "GetImageApi.h"

#import "GetImageApi.h"

@implementation GetImageApi {
  NSString *_imageId;
}

- (id)initWithImageId:(NSString *)imageId {
  self = [super init];
  if (self) {
    _imageId = imageId;
  }
  return self;
}

- (NSString *)requestUrl {
  return [NSString stringWithFormat:@"/images/%@", _imageId];
}

- (BOOL)useCDN {
  return YES;
}

// 断点续传
- (NSString *)resumableDownloadPath {
  NSString *libPath   = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
  NSString *cachePath = [libPath stringByAppendingPathComponent:@"Caches"];
  NSString *filePath  = [cachePath stringByAppendingPathComponent:_imageId];
  return filePath;
  // return @"/Users/stone/Desktop/abc101010.jpg";
}
@end
