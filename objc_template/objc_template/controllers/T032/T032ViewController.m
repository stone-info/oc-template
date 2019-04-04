//
//  T032ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>
#import <UIKit/UIKit.h>
#import "T032ViewController.h"
#import "AFNetworking.h"

@interface T032ViewController ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end

@implementation T032ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  self.manager = [AFHTTPSessionManager manager];

  // 如果返回的数据既不是xml也不是json那么应该修改解析方案为[AFHTTPResponseSerializer serializer],
  // 返回的是什么就接收什么
  self.manager.responseSerializer                        = [AFHTTPResponseSerializer serializer];
  self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                                                 @"text/json",
                                                                                 @"text/javascript",
                                                                                 @"text/html",
                                                                                 @"text/xml",
                                                                                 @"text/plain", nil
  ];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

  // [self demo1];
  // [self demo2];
  // [self demo3];
  // [self demo4];
  // [self demo5];
  // [self demo6];

  UIImage *image     = [UIImage imageNamed:@"abc001"];
  NSData  *imageData = UIImagePNGRepresentation(image);

  [SNHTTPManager uploadWithURLString:@"http://localhost:9000/upload-single" data:imageData fieldName:@"logo" fileName:@"xxx.png" mimeType:@"image/png" progress:^(double d) {
    NSLog(@"d = %lf", d);
  } callback:^(NSString *string, NSError *error) {
    NSLog(@"string = %@", string);
  }];

}

- (void)demo6 {
  // NSURL               *url     = [NSURL URLWithString:@"http://localhost:9000/upload-single"];
  // NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  // request.HTTPMethod = @"POST";
  // [request setValue:kStringFormat(@"multipart/form-data;boundary=%@", @"-----") forHTTPHeaderField:@"Content-Type"];
  // NSData                 *bodyData = nil;
  // NSURLSessionUploadTask *task     = [self.manager uploadTaskWithRequest:request fromData:bodyData progress:^(NSProgress *uploadProgress) {
  //   NSLog(@"百分比 %.2f%%", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount * 100);
  // } completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
  //   NSLog(@"response = %@", response);
  //   NSLog(@"responseObject = %@", responseObject);
  // }];
  //
  // [task resume];

  UIImage *image     = [UIImage imageNamed:@"abc001"];
  NSData  *imageData = UIImagePNGRepresentation(image);
  // NSData *imageData = UIImageJPEGRepresentation(image, 1.0);


  NSURLSessionDataTask *dataTask = [self.manager
    POST:@"http://localhost:9000/upload-single"
    parameters:nil
    constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {

      [formData appendPartWithFileData:imageData name:@"logo" fileName:@"abc001.png" mimeType:@"image/png"];

    } progress:^(NSProgress *uploadProgress) {
      NSLog(@"百分比 %.2f%%", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount * 100);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
      NSLog(@"responseObject = %@", responseObject);

      NSLog(@"sn.dataToString(responseObject) = %@", sn.dataToString(responseObject));
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      NSLog(@"error = %@", error);
    }];

  [dataTask resume];
}

- (void)demo5 {
  NSLog(@"%s", __func__);

  NSURL        *url     = [NSURL URLWithString:@"http://localhost:7000/video/abc.mp4"];
  // NSURL        *url     = [NSURL URLWithString:@"http://localhost:7000/images/abc.jpg"];
  // NSURL        *url     = [NSURL URLWithString:@"http://localhost:3000/img/abc003.jpg"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  // [SNHTTPManager downloadWithURLString:@"http://localhost:7000/images/abc.jpg" filePath:nil callback:^(NSURL *url) {
  //   NSLog(@"url = %@", url);
  // }];
  // NSString *string = @"http://localhost:7000/images/abc.jpg";
  NSString *string = @"http://localhost:7000/video/abc.mp4";
  [SNHTTPManager downloadWithURLString:string filePath:nil progress:^(double d) {
    NSLog(@"d = %lf", d);
  } callback:^(NSURL *url, NSError *error) {
    if (!error) {
      NSLog(@"url = %@", url);
    }
  }];
}

- (void)demo4 {
  // NSURL        *url     = [NSURL URLWithString:@"http://localhost:7000/video/abc.mp4"];
  NSURL        *url     = [NSURL URLWithString:@"http://localhost:7000/images/abc.jpg"];
  // NSURL        *url     = [NSURL URLWithString:@"http://localhost:3000/img/abc003.jpg"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  NSURLSessionDownloadTask *task = [self.manager downloadTaskWithRequest:request
                                                 progress:^(NSProgress *downloadProgress) {
                                                   // NSLog(@"%s | downloadProgress = %@", __func__, downloadProgress);

                                                   NSLog(@"百分比 %.2f%%", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount * 100);

                                                 }
                                                 destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                                   NSLog(@"targetPath = %@", targetPath);
                                                   NSLog(@"response = %@", response);

                                                   // return [NSURL fileURLWithPath:@"/Users/stone/Desktop/dddxxx.mp4"];
                                                   return [NSURL fileURLWithPath:@"/Users/stone/Desktop/dddxxx.jpg"];
                                                 }
                                                 completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                                   NSLog(@"response = %@", response);
                                                   NSLog(@"filePath = %@", filePath);
                                                   NSLog(@"error = %@", error);
                                                 }];

  [task resume];
}

- (void)demo3 {
  [SomeHTTPManager postsWithCompleted:^(NSString *jsonString, NSError *error) {

    NSLog(@"jsonString = %@", jsonString);

  }];
}

- (void)demo2 {
  [SNHTTPManager requestWithMethod:GET urlString:@"http://jsonplaceholder.typicode.com/posts" parameters:nil completed:^(NSString *string, NSError *error) {
    NSLog(@"string = %@", string);
    NSLog(@"error = %@", error);
  }];
}

- (void)demo1 {
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

  // 如果返回的数据既不是xml也不是json那么应该修改解析方案为[AFHTTPResponseSerializer serializer],
  // 返回的是什么就接收什么
  manager.responseSerializer                        = [AFHTTPResponseSerializer serializer];
  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                                            @"text/json",
                                                                            @"text/javascript",
                                                                            @"text/html",
                                                                            @"text/xml",
                                                                            @"text/plain", nil
  ];

  NSURLSessionDataTask *dataTask = [manager
    GET:@"http://jsonplaceholder.typicode.com/posts"
    parameters:nil
    progress:^(NSProgress *downloadProgress) {
      NSLog(@"downloadProgress = %@", downloadProgress);

    }
    success:^(NSURLSessionDataTask *task, id responseObject) {

      // NSLog(@"responseObject = %@", responseObject);

      NSLog(@"sn.dataToString(responseObject) = %@", sn.dataToString(responseObject));

    }
    failure:^(NSURLSessionDataTask *task, NSError *error) {

      NSLog(@"error = %@", error);

    }];

  [dataTask resume];
}

- (void)injected {

}

@end
    
    
    
