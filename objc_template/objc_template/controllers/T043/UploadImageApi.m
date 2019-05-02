//
//  UploadImageApi.m
//  objc_template
//
//  Created by stone on 2019/4/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import <AFNetworking/AFURLRequestSerialization.h>
#import "UploadImageApi.h"

@implementation UploadImageApi {
  UIImage *_image;
}

- (id)initWithImage:(UIImage *)image {
  self = [super init];
  if (self) {
    _image = image;
  }
  return self;
}

- (YTKRequestMethod)requestMethod {
  return YTKRequestMethodPOST;
}

- (NSString *)requestUrl {
  return @"/upload-single";
}

- (AFConstructingBlock)constructingBodyBlock {
  return ^(id<AFMultipartFormData> formData) {
    NSData *data = UIImageJPEGRepresentation(_image, 0.9);
    NSString *name = @"header";
    NSString *formKey = @"avatar";
    NSString *type = @"image/jpeg";
    [formData appendPartWithFileData:data name:formKey fileName:name mimeType:type];
  };
}

- (id)jsonValidator {
    return @{ @"imageId": [NSString class] };
}

- (NSString *)responseImageId {
  NSDictionary *dict = self.responseJSONObject;
  return dict[@"imageId"];
}

@end
