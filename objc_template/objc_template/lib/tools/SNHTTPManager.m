//
//  SNHTTPManager.m
//  objc_template
//
//  Created by stone on 2019/3/31.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNHTTPManager.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/UIImage+GIF.h>
#import <SDWebImage/SDWebImageDownloader.h>
#import <SDWebImage/NSData+ImageContentType.h>

@interface SNHTTPManager ()


@end

@implementation SNHTTPManager

+ (AFHTTPSessionManager *)commonManager {
  AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
  // 如果返回的数据既不是xml也不是json那么应该修改解析方案为[AFHTTPResponseSerializer serializer],
  // 返回的是什么就接收什么
  manager.responseSerializer                        = [AFHTTPResponseSerializer serializer];
  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];
  return manager;
}

//封装 get & post 请求方法
+ (void)requestWithMethod:(HTTPMethod)method urlString:(NSString *)urlString parameters:(__nullable id)parameters finished:(void (^)(id responseObject, NSError *error))finished {

  NSString *_urlString = sn.encoding(urlString);

  void (^success)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask *task, id result) { finished(result, nil); };
  void (^failure)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask *task, NSError *error) { finished(nil, error); };

  if (method == GET) {
    [[[self commonManager] GET:_urlString parameters:parameters progress:nil success:success failure:failure] resume];
  } else {
    [[[self commonManager] POST:_urlString parameters:parameters progress:nil success:success failure:failure] resume];
  }
}

+ (void)requestWithMethod:(HTTPMethod)method urlString:(NSString *)urlString parameters:(__nullable id)parameters completed:(void (^)(NSString *, NSError *))completed {

  [self requestWithMethod:method urlString:urlString parameters:parameters finished:^(id responseObject, NSError *error) {
    if (error) {
      completed(nil, error);
    } else {
      NSString *jsonString = sn.dataToString(responseObject);
      completed(jsonString, nil);
    }
  }];
}

+ (void)downloadWithURLString:(NSString *)urlString filePath:(nullable NSString *)filePath progress:(nullable void (^)(double))progress callback:(void (^)(NSURL *, NSError *))callback {
  // NSURL        *url     = [NSURL URLWithString:@"http://localhost:7000/video/abc.mp4"];
  // NSURL        *url     = [NSURL URLWithString:@"http://localhost:3000/img/abc003.jpg"];
  NSURL        *url     = [NSURL URLWithString:urlString];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];

  NSURLSessionDownloadTask *task = [[self commonManager] downloadTaskWithRequest:request
                                          progress:^(NSProgress *downloadProgress) {
                                            // NSLog(@"%s | downloadProgress = %@", __func__, downloadProgress);
                                            // NSLog(@"百分比 %.2f%%", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount * 100);
                                            // progress(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount * 100);
                                            !progress ?: progress(1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
                                          }
                                          destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {

                                            // return [NSURL fileURLWithPath:@"/Users/stone/Desktop/dddxxx.mp4"];

                                            NSString *contentType = [response valueForKey:@"allHeaderFields"][@"Content-Type"];

                                            NSArray<NSString *> *array = sn.split(contentType, @"/");
                                            if (filePath) {
                                              return [NSURL fileURLWithPath:filePath];
                                            } else {
                                              NSString *filename = sn.md5WithString(urlString);
                                              if (array[1]) {
                                                filename = kStringFormat(@"%@.%@", filename, array[1]);
                                              }
                                              return [NSURL fileURLWithPath:kCachePathWithFileName(filename)];
                                            }
                                          }
                                          completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                                            // 将NSString转成NSURL的API是fileURLWithPath，从NSURL转成NSString的API是path
                                            // NSLog(@"filePath.path = %@", filePath.path);
                                            callback(filePath, error);
                                          }];

  [task resume];
}

+ (void)uploadWithURLString:(NSString *)urlString
        data:(NSData *)data
        fieldName:(NSString *)fieldName
        fileName:(NSString *)fileName
        mimeType:(NSString *)mimeType
        progress:(nullable void (^)(double))progress
        callback:(void (^)(NSString *, NSError *))callback {
  NSURLSessionDataTask *dataTask = [[self commonManager]
                                          POST:urlString
                                          parameters:nil
                                          constructingBodyWithBlock:^(id <AFMultipartFormData> formData) {

                                            [formData appendPartWithFileData:data name:fieldName fileName:fileName mimeType:mimeType];

                                          } progress:^(NSProgress *uploadProgress) {
      // NSLog(@"百分比 %.2f%%", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount * 100);
      !progress ?: progress(1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
      // NSLog(@"sn.dataToString(responseObject) = %@", sn.dataToString(responseObject));
      callback(sn.dataToString(responseObject), nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
      // NSLog(@"error = %@", error);
      callback(nil, error);
    }];

  [dataTask resume];
}

+ (void)downloadImageWithURLString:(NSString *)urlString options:(SDWebImageOptions)options progress:(nullable void (^)(double))progress callback:(void (^)(UIImage *, NSData *, NSError *))callback {
  SDWebImageManager *manager = [SDWebImageManager sharedManager];

  NSURL *url = [NSURL URLWithString:urlString];
  [
    manager
    loadImageWithURL:url
    options:options
    progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
      !progress ?: progress(1.0 * receivedSize / expectedSize);
    } completed:^(UIImage *image, NSData *data, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {

      SDImageFormat imageFormat = [NSData sd_imageFormatForImageData:data];

      if (imageFormat == SDImageFormatGIF) { image = [UIImage sd_animatedGIFWithData:data]; }

      callback(image, data, error);

      // NSLog(@"data = %@", data);
      // NSLog(@"image = %@", image);
      // self.imageView.image = image;
      //
      // [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
      //   // make.center;
      //   int w = 200;
      //   make.width.mas_equalTo(w);
      //   CGFloat height = sn.suggestHeight(w, self.imageView.image);
      //   make.height.mas_equalTo(height); // 高/宽
      // }];
      // // 修改值之后 再做标记 , 如果在updateViewConstraints里面做 修改值 没有动画
      //
      // [self.view setNeedsUpdateConstraints];
    }
  ];
}

+ (void)downloadImageWithURLString:(NSString *)urlString options:(SDWebImageDownloaderOptions)options progress:(nullable void (^)(double))progress completed:(void (^)(UIImage *, NSData *, NSError *))completed {
  SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
  NSURL                *url        = [NSURL URLWithString:urlString];
  [
    downloader
    downloadImageWithURL:url
    options:options
    progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL *targetURL) {
      !progress ?: progress(1.0 * receivedSize / expectedSize);
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
      SDImageFormat imageFormat = [NSData sd_imageFormatForImageData:data];
      if (imageFormat == SDImageFormatGIF) { image = [UIImage sd_animatedGIFWithData:data]; }
      completed(image, data, error);
    }
  ];
}

+ (void)clearCacheWithCallback:(void (^)(void))callback {
  // 清楚整个缓存... 重新创建...
  [[SDWebImageManager sharedManager].imageCache clearDiskOnCompletion:^{
    !callback ?: callback();
  }];
}

+ (void)cancelAll {
  [[SDWebImageManager sharedManager] cancelAll];
}

@end
