//
//  SNHTTPManager.h
//  objc_template
//
//  Created by stone on 2019/3/31.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SDWebImage/SDWebImageManager.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, HTTPMethod) {
  POST,
  GET,
};

@interface SNHTTPManager : NSObject

// GET & POST with NSData
+ (void)requestWithMethod:(HTTPMethod)method urlString:(NSString *)urlString parameters:(__nullable id)parameters finished:(void (^)(id responseObject, NSError *error))finished;

// GET & POST with JSON
+ (void)requestWithMethod:(HTTPMethod)method urlString:(NSString *)urlString parameters:(__nullable id)parameters completed:(void (^)(NSString *, NSError *))completed;

// download
+ (void)downloadWithURLString:(NSString *)urlString filePath:(nullable NSString *)filePath progress:(nullable void (^)(double))progress callback:(void (^)(NSURL *, NSError *))callback;

// upload
+ (void)uploadWithURLString:(NSString *)urlString data:(NSData *)data fieldName:(NSString *)fieldName fileName:(NSString *)fileName mimeType:(NSString *)mimeType progress:(nullable void (^)(double))progress callback:(void (^)(NSString *, NSError *))callback;

// download image 1
+ (void)downloadImageWithURLString:(NSString *)urlString options:(SDWebImageOptions)options progress:(nullable void (^)(double))progress callback:(void (^)(UIImage *, NSData *, NSError *))callback;

// download image 2
+ (void)downloadImageWithURLString:(NSString *)urlString options:(SDWebImageDownloaderOptions)options progress:(nullable void (^)(double))progress completed:(void (^)(UIImage *, NSData *, NSError *))completed;

// sd web image clear cache
+ (void)clearCacheWithCallback:(void (^)(void))callback;

// sd web image cancel request;
+ (void)cancelAll;
@end

NS_ASSUME_NONNULL_END
