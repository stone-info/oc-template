//
//  SNTools.h
//  006_UIAdvanced
//
//  Created by stone on 2018/8/2.
//  Copyright © 2018年 stone. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "SSZipArchive.h"
//sn_note:========= SNBigFileDownloadConnectionManager ============================ stone 🐳 ===========/

@interface SNBigFileDownloadConnectionManager : NSObject
@property(nonatomic, strong) NSFileHandle *handle;
@property(nonatomic) NSUInteger           currentSize;
@property(nonatomic) long long int        totalSize;
@property(copy, nonatomic) NSString       *filePath;

// + (instancetype)managerWithResponse:(NSURLResponse *)response fileName:(NSString *)fileName;
+ (SNBigFileDownloadConnectionManager *(^)(NSURLResponse *, NSString *))createManager;

// - (CGFloat)appendData:(NSData *)data;
- (CGFloat(^)(NSData *))appendData;

// - (void)close;
- (void (^)(void))close;
@end

//sn_note:========= SNBigFileDownloadSessionManager ============================ stone 🐳 ===========/

@interface SNBigFileDownloadSessionManager : NSObject
@property(nonatomic, strong) NSFileHandle         *fileHandle;
@property(nonatomic, assign) NSUInteger           currentSize;
@property(nonatomic, assign) NSUInteger           totalSize;
@property(nonatomic, copy) NSString               *filePath;
@property(nonatomic, strong) NSURLSession         *session;
@property(nonatomic, strong) NSURLSessionDataTask *dataTask;
@property(nonatomic, copy) NSString               *urlString;
@property(nonatomic, copy) NSString               *infoFilePath;

- (instancetype)initWithURLString:(NSString *)urlString
                           target:(id <NSURLSessionDataDelegate>)target;

- (void)didReceiveResponse:(NSURLResponse *)response;

- (CGFloat)didReceiveData:(NSData *)data;

- (void)didComplete;

- (CGFloat)getTotalSize;
@end

//sn_note:========= SNTools ============================ stone 🐳 ===========/

#define FileHashDefaultChunkSizeForReadingData 1024*8 // 8K

typedef void (^SNTaskBlock)(void);

@interface SNTools : NSObject

+ (instancetype)sharedInstance;

+ (UIColor *)randomColor;

+ (void)promiseAll:(NSArray<SNTaskBlock> *)taskList
         completed:(void (^)(void))completed;

//sn_note:=========  ============================ stone 🐳 ===========/

+ (NSString *)getMD5WithData:(NSData *)data;

//计算字符串的MD5值，
+ (NSString *)getmd5WithString:(NSString *)string;

//计算大文件的MD5值
+ (NSString *)getFileMD5WithPath:(NSString *)path;

//sn_note:========= GCD Timer ============================ stone 🐳 ===========/

// void dispatchTimer(id target, double timeInterval, void (^handler)(dispatch_source_t timer));

+ (void)addRunLoopObserver;

- (void)emptySelector:(id)sender;

- (void)emptySelector;

+ (NSString *(^)(NSData *))dataToString;

+ (NSData *(^)(NSString *))stringToData;

+ (void (^)(__kindof UIViewController *, __kindof UITableView *))adjustsInsets;

+ (NSString *(^)(NSString *))encoding;

+ (id(^)(NSData *))deserialization;

+ (NSData *(^)(id))serialization;

+ (id(^)(NSData *, NSJSONReadingOptions))deserializationWithOptions;

+ (id(^)(NSString *))jsonFileToObject;

+ (UIImage *(^)(NSData *))dataToImage;

+ (NSUInteger (^)(NSString *filePath))fileSize;

+ (NSMutableURLRequest *(^)(NSString *, UIImage *))upload;

// + (NSMutableURLRequest *)uploadWithImage:(UIImage *)image urlString:(NSString*)urlString;
+ (NSString *(^)(NSString *))getMIMETypeWithMainQueue;

+ (void (^)(NSString *, void(^)(NSString *MIMEType)))getMIMETypeWithConcurrentQueue;

+ (NSString *(^)(NSString *))getMIMETypeWithSystem;

+ (BOOL (^)(NSString *, NSArray<NSString *> *))zip;

+ (BOOL (^)(NSString *, NSArray<NSString *> *, NSString *))zipWithPassword;

+ (BOOL (^)(NSString *, NSString *))zipWithDirectory;

+ (BOOL (^)(NSString *, NSString *))unzip;

+ (BOOL (^)(NSString *, NSString *, void(^)(NSString *, unz_file_info, long, long), void(^)(NSString *, BOOL, NSError *)))unzipWithBlock;

+ (NSString *(^)(NSString *))imageExtension;

+ (BOOL (^)(NSData *, NSString *))dataWriteToFileToDesktop;

+ (BOOL (^)(NSData *, NSString *))dataWriteToFile;

+ (NSString *(^)(id))getClassName;

+ (NSDictionary *(^)(NSString *))plistToDictionary;

+ (NSArray *(^)(NSString *))plistToArray;

+ (NSDictionary *(^)(NSString *))jsonToDictionary;

+ (NSArray *(^)(NSString *))jsonToArray;

+ (NSString *(^)(NSDictionary *))dictionaryToProperties;
#if DEBUG
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"
+ (NSDictionary *(^)(id))getAllKeyAndValues;
+ (NSArray<NSString *> *(^)(id))getAllMethodNamesWithObj;
+ (NSArray<NSString *> *(^)(Class))getAllMethodNamesWithClass;
#pragma clang diagnostic pop
#endif


@end


