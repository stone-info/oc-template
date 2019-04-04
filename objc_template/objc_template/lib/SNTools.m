//
//  SNTools.m
//  006_UIAdvanced
//
//  Created by stone on 2018/8/2.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "SNTools.h"
#import <MobileCoreServices/MobileCoreServices.h>
// 需要SDWebImage
#import "NSData+ImageContentType.h"
#import "NSDate+Time.h"
#import "NSString+StringExtension.h"
#import <objc/message.h>

//sn_note:========= SNBigFileDownloadConnectionManager ============================ stone 🐳 ===========/
@implementation SNBigFileDownloadConnectionManager

// + (instancetype)managerWithResponse:(NSURLResponse *)response
//                            fileName:(NSString *)fileName {
//
//   SNBigFileDownloadConnectionManager *_self = [[SNBigFileDownloadConnectionManager alloc] init];
//   _self.totalSize = response.expectedContentLength;
//   NSString *filePath = kCachePathWithFileName(fileName);
//   [[NSFileManager defaultManager] createFileAtPath:filePath
//                                           contents:nil
//                                         attributes:nil];
//   _self.handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
//   return _self;
// }


+ (SNBigFileDownloadConnectionManager *(^)(NSURLResponse *, NSString *))createManager {
  return ^SNBigFileDownloadConnectionManager *(NSURLResponse *response, NSString *fileName) {

    SNBigFileDownloadConnectionManager *_self = [[SNBigFileDownloadConnectionManager alloc] init];
    _self.totalSize = response.expectedContentLength;

    NSString *filePath = nil;
    if (fileName) {
      filePath = kCachePathWithFileName(fileName);
    } else {
      filePath = kCachePathWithFileName(response.suggestedFilename);
    }

    _self.filePath = filePath;

    [[NSFileManager defaultManager] createFileAtPath:filePath
                                            contents:nil
                                          attributes:nil];
    _self.handle = [NSFileHandle fileHandleForWritingAtPath:filePath];
    return _self;
  };
}

// - (CGFloat)appendData:(NSData *)data {
//   [self.handle seekToEndOfFile];
//   [self.handle writeData:data];
//   self.currentSize += data.length;
//   CGFloat percent = 1.0 * self.currentSize / self.totalSize * 100;
//   return percent;
// }

- (CGFloat(^)(NSData *))appendData {
  return ^CGFloat(NSData *data) {
    [self.handle seekToEndOfFile];
    [self.handle writeData:data];
    self.currentSize += data.length;
    CGFloat percent = 1.0 * self.currentSize / self.totalSize * 100;
    return percent;
  };
}

// - (void)close {
//   [self.handle closeFile];
//   self.handle = nil;
// }

- (void (^)(void))close {
  return ^void(void) {
    [self.handle closeFile];
    self.handle = nil;
  };
}

- (void)dealloc {
  NSLog(@"■■■■■■%@ is dead ☠☠☠️■■■■■■", [self class]);
}
@end

//sn_note:========= SNBigFileDownloadSessionManager ============================ stone 🐳 ===========/

@interface SNBigFileDownloadSessionManager ()


@end

@implementation SNBigFileDownloadSessionManager

- (instancetype)initWithURLString:(NSString *)urlString
                           target:(id <NSURLSessionDataDelegate>)target {

  self = [super init];
  if (self) {

    self.urlString = urlString;
    // set filePath & currentSize
    {
      NSString *fileNameWithoutExtension = [SNTools getmd5WithString:urlString];
      NSString *extension                = urlString.pathExtension;
      self.filePath                      = kCachePathWithFileName([fileNameWithoutExtension stringByAppendingPathExtension:extension]);
      self.infoFilePath                  = kCachePathWithFileName([fileNameWithoutExtension stringByAppendingPathExtension:@"info"]);
      self.currentSize                   = [[kFileManager attributesOfItemAtPath:kCachePathWithFileName([fileNameWithoutExtension stringByAppendingPathExtension:extension])
                                                                           error:nil][@"NSFileSize"] unsignedIntegerValue];
    }

    NSURL               *url     = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // set range
    {
      /**
        * 格式有要求:
        * 表示头500个字节: Range: bytes=0-499
        * 表示第二个500个字节: Range: bytes=500-999
        * 表示最后500个字节: Range: bytes=-500
        * 表示500个字节以后的范围: Range: bytes=500-
        */
      NSString *range = [NSString stringWithFormat:@"bytes=%zd-",
                                                   self.currentSize];
      [request setValue:range
     forHTTPHeaderField:@"Range"];
    }
    // set dataTask & session
    {
      NSOperationQueue *queue = nil;
      {
        // 暂停不能重复点击...
        queue                            = [[NSOperationQueue alloc] init];
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        queue.underlyingQueue = concurrentQueue;

        // queue = [NSOperationQueue mainQueue]; // 不起作用...(暂停失效)
      }
      NSURLSessionConfiguration *configuration = nil;
      {
        configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
      }

      self.session  = [NSURLSession sessionWithConfiguration:configuration
                                                    delegate:target
                                               delegateQueue:queue];
      self.dataTask = [self.session dataTaskWithRequest:request];
    }
  }
  return self;
}

- (CGFloat)getTotalSize {

  NSInteger totalSize                 = [[NSString stringWithContentsOfFile:self.infoFilePath] integerValue];
  NSString  *fileNameWithoutExtension = [SNTools getmd5WithString:self.urlString];
  NSString  *extension                = self.urlString.pathExtension;
  NSInteger currentSize               = [[kFileManager attributesOfItemAtPath:kCachePathWithFileName([fileNameWithoutExtension stringByAppendingPathExtension:extension])
                                                                        error:nil][@"NSFileSize"] unsignedIntegerValue];
  if (totalSize != 0) {
    return 1.0 * currentSize / totalSize * 100;
  } else {
    return 0.f;
  }
}

- (void)didReceiveResponse:(NSURLResponse *)response {

  self.totalSize = (NSUInteger) response.expectedContentLength + self.currentSize;

  // save totalSize
  {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      NSString *sizeString = kStringFormat(@"%lu", self.totalSize);
      [sizeString writeToFile:self.infoFilePath
                   atomically:YES
                     encoding:NSUTF8StringEncoding
                        error:nil];
    });
  }

  NSString *filePath = self.filePath;

  if (self.currentSize <= 0) {
    [kFileManager createFileAtPath:filePath
                          contents:nil
                        attributes:nil];
  }
  self.fileHandle = [NSFileHandle fileHandleForWritingAtPath:filePath];
  [self.fileHandle seekToEndOfFile];
}

- (CGFloat)didReceiveData:(NSData *)data {
  @try {
    // 自动累加
    [self.fileHandle writeData:data];
  } @catch (NSException *exception) {
    DLog(@"%s | exception = %@", __func__, exception);
  }

  self.currentSize += data.length;

  CGFloat percent = 1.0 * self.currentSize / self.totalSize * 100;

  return percent;
}

- (void)didComplete {
  [self.fileHandle closeFile];
  self.fileHandle = nil;
}

- (void)dealloc {
  NSLog(@"■■■■■■%@ is dead ☠☠☠️■■■■■■", [self class]);

  // 一定要做清理工作...不然内存泄露
  [self.session invalidateAndCancel];// 两者都可以...
  // [self.session finishTasksAndInvalidate];
}
@end

//sn_note:=========  ============================ stone 🐳 ===========/

//sn_note:========= SNTools ============================ stone 🐳 ===========/
@interface SNTools ()

@end

@implementation SNTools

+ (UIColor *)randomColor {
  CGFloat hue        = (arc4random() % 256 / 256.0);  //  0.0 to 1.0
  CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from white
  CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from black
  return [UIColor colorWithHue:hue
                    saturation:saturation
                    brightness:brightness
                         alpha:1];
}

+ (instancetype)sharedInstance {
  static id              _sharedInstance = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    _sharedInstance = [[self alloc] init];
  });

  return _sharedInstance;
}

+ (void)promiseAll:(NSArray<SNTaskBlock> *)taskList
         completed:(void (^)(void))completed {

  dispatch_group_t group       = dispatch_group_create();
  dispatch_queue_t queue       = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_queue_t apply_queue = dispatch_queue_create("com.stone.task", DISPATCH_QUEUE_CONCURRENT);

  NSUInteger count = taskList.count;

  dispatch_apply(count, apply_queue, ^(size_t index) {
    SNTaskBlock taskBlock = taskList[index];
    dispatch_group_async(group, queue, ^{
      taskBlock();
    });
  });
  // for (int i = 0; i < count; i++) {
  //   SNTaskBlock block = taskList[i];
  //   dispatch_group_async(group, queue, ^{
  //     block();
  //   });
  // }

  dispatch_group_notify(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    // NSLog(@"所有任务执行完毕");
    completed();
  });

}
//sn_note:=========  ============================ stone 🐳 ===========/
#define CC_MD5_DIGEST_LENGTH 16

+ (NSString *)getmd5WithString:(NSString *)string {
  const char    *original_str = [string UTF8String];
  unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
  CC_MD5(original_str, (uint) strlen(original_str), digist);
  NSMutableString *outPutStr = [NSMutableString stringWithCapacity:10];
  for (int        i          = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
    [outPutStr appendFormat:@"%02x",
                            digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
  }
  return [outPutStr lowercaseString];
}

+ (NSString *)getMD5WithData:(NSData *)data {
  const char    *original_str = (const char *) [data bytes];
  unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
  CC_MD5(original_str, (uint) strlen(original_str), digist);
  NSMutableString *outPutStr = [NSMutableString stringWithCapacity:10];
  for (int        i          = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
    [outPutStr appendFormat:@"%02x",
                            digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
  }

  //也可以定义一个字节数组来接收计算得到的MD5值
  //    Byte byte[16];
  //    CC_MD5(original_str, strlen(original_str), byte);
  //    NSMutableString* outPutStr = [NSMutableString stringWithCapacity:10];
  //    for(int  i = 0; i<CC_MD5_DIGEST_LENGTH;i++){
  //        [outPutStr appendFormat:@"%02x",byte[i]];
  //    }
  //    [temp release];

  return [outPutStr lowercaseString];

}

+ (NSString *)getFileMD5WithPath:(NSString *)path {
  return (__bridge_transfer NSString *) FileMD5HashCreateWithPath((__bridge CFStringRef) path, FileHashDefaultChunkSizeForReadingData);
}

CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath, size_t chunkSizeForReadingData) {

  // Declare needed variables
  CFStringRef     result     = NULL;
  CFReadStreamRef readStream = NULL;

  // Get the file URL
  CFURLRef fileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef) filePath, kCFURLPOSIXPathStyle, (Boolean) false);

  CC_MD5_CTX hashObject;
  bool hasMoreData = true;
  bool didSucceed;

  if (!fileURL) {goto done;}

  // Create and open the read stream
  readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault, (CFURLRef) fileURL);
  if (!readStream) {goto done;}
  didSucceed = (bool) CFReadStreamOpen(readStream);
  if (!didSucceed) {goto done;}

  // Initialize the hash object
  CC_MD5_Init(&hashObject);

  // Make sure chunkSizeForReadingData is valid
  if (!chunkSizeForReadingData) {
    chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
  }

  // Feed the data to the hash object
  while (hasMoreData) {
    uint8_t buffer[chunkSizeForReadingData];
    CFIndex readBytesCount = CFReadStreamRead(readStream, (UInt8 *) buffer, (CFIndex) sizeof(buffer));
    if (readBytesCount == -1) {break;}
    if (readBytesCount == 0) {
      hasMoreData = false;
      continue;
    }
    CC_MD5_Update(&hashObject, (const void *) buffer, (CC_LONG) readBytesCount);
  }

  // Check if the read operation succeeded
  didSucceed    = !hasMoreData;

  // Compute the hash digest
  unsigned char digest[CC_MD5_DIGEST_LENGTH];
  CC_MD5_Final(digest, &hashObject);

  // Abort if the read operation failed
  if (!didSucceed) {goto done;}

  // Compute the string result
  char        hash[2 * sizeof(digest) + 1];
  for (size_t i = 0; i < sizeof(digest); ++i) {
    snprintf(hash + (2 * i), 3, "%02x", (int) (digest[i]));
  }
  result = CFStringCreateWithCString(kCFAllocatorDefault, (const char *) hash, kCFStringEncodingUTF8);

  done:

  if (readStream) {
    CFReadStreamClose(readStream);
    CFRelease(readStream);
  }
  if (fileURL) {
    CFRelease(fileURL);
  }
  return result;
}

/**
 开启一个定时器

 @param target 定时器持有者
 @param timeInterval 执行间隔时间
 @param handler 重复执行事件
 */
// void dispatchTimer(id target, double timeInterval, void (^handler)(dispatch_source_t timer)) {
//   dispatch_queue_t        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//   dispatch_source_t       timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//   // dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), (uint64_t)(timeInterval *NSEC_PER_SEC), 0);
//   dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, timeInterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
//   // 设置回调 // 奇淫技巧啊... 通过自己引用自己 不被释放 - - , 牛B死了...
//   __weak __typeof(target) weaktarget = target;
//   dispatch_source_set_event_handler(timer, ^{
//     if (!weaktarget) {
//       dispatch_source_cancel(timer);
//     } else {
//       // dispatch_async(dispatch_get_main_queue(), ^{
//       if (handler) {handler(timer);}
//       // });
//     }
//   });
//   // 启动定时器
//   dispatch_resume(timer);
// }

+ (void)addRunLoopObserver {

  CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {

    switch (activity) {
      case kCFRunLoopEntry :
        NSLog(@"即将进入runloop");
        break;
      case kCFRunLoopBeforeTimers:
        NSLog(@"即将处理timer事件");
        NSLog(@"\n[NSThread currentThread] = %@", [NSThread currentThread]);
        break;
      case kCFRunLoopBeforeSources:
        NSLog(@"即将处理source事件");
        break;
      case kCFRunLoopBeforeWaiting :
        NSLog(@"即将进入睡眠");
        break;
      case kCFRunLoopAfterWaiting :
        NSLog(@"被唤醒");
        break;
      case kCFRunLoopExit :
        NSLog(@"runloop退出");
        break;
      default:
        break;
    }
  });
  CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
  CFRelease(observer);
}

- (void)emptySelector:(id)sender {
  NSLog(@"%s", __func__);
}

- (void)emptySelector {
  NSLog(@"%s", __func__);
}

+ (NSString *(^)(NSData *))dataToString {
  return ^(NSData *data) {
    return [[NSString alloc] initWithData:data
                                 encoding:NSUTF8StringEncoding];;
  };
}

+ (NSData *(^)(NSString *))stringToData {
  return ^(NSString *string) {
    return [string dataUsingEncoding:NSUTF8StringEncoding];
  };
}

/**
 * adjustsInsets
 * @return void
 */
+ (void (^)(__kindof UIViewController *, __kindof UITableView *))adjustsInsets {
  void (^pFunction)(__kindof UIViewController *, __kindof UITableView *) = ^(__kindof UIViewController *viewController, __kindof UITableView *tableView) {
    if (@available(iOS 11.0, *)) {
      // 取消自动调整内边距
      tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
      viewController.automaticallyAdjustsScrollViewInsets = NO;
    }
  };
  return pFunction;
}

/**
 * URL encoding
 * @param NSString *
 * @return NSString *
 */
+ (NSString *(^)(NSString *))encoding {
  return ^(NSString *string) {
    if (@available(iOS 9.0, *)) {
      // iOS 9之后
      // Returns a new string made from the receiver by replacing all characters not in the allowedCharacters set with percent encoded characters.
      // UTF-8 encoding is used to determine the correct percent encoded characters.
      // Entire URL strings cannot be percent-encoded.
      // This method is intended to percent-encode an URL component or subcomponent string, NOT the entire URL string.
      // Any characters in allowedCharacters outside of the 7-bit ASCII range are ignored.

      // 最后一句Any characters in allowedCharacters outside of the 7-bit ASCII range are ignored.
      // 意思就是说，任何非7-bit ASCII字符搁到allowedCharacters里面也将被忽略，
      // 也就是allowedCharacters里面的字符跟7-bit ASCII字符不会被编码。

      // URLHostAllowedCharacterSet      "#%/<>?@\^`{|}
      // URLFragmentAllowedCharacterSet  "#%<>[\]^`{|}
      // URLPasswordAllowedCharacterSet  "#%/:<>?@[\]^`{|}
      // URLPathAllowedCharacterSet      "#%;<>?[\]^`{|}
      // URLQueryAllowedCharacterSet     "#%<>[\]^`{|}
      // URLUserAllowedCharacterSet      "#%/:<>?@[\]^`

      // 注意：如果是自定义 记得在字符串最后加个 空格

      // {
      //  [aString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      //  // 等价于
      //  [aString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "]];
      // }

      // 字符集最后是一个空格！
      // 这里字符集的意思就是，字符串中含有字符集里面的字符将不会被编码。
      return [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    } else {
      // iOS 9之前
      return [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
  };
}

// json数据 -> OC对象 反序列化
+ (id(^)(NSData *))deserialization {
  return ^(NSData *data) {
    id obj = self.deserializationWithOptions(data, NSJSONReadingMutableContainers);
    return obj;
  };
}

// json数据 -> OC对象 反序列化
+ (id(^)(NSData *, NSJSONReadingOptions))deserializationWithOptions {
  //  NSJSONReadingMutableContainers = (1UL << 0), // 序列化之后 返回 NSMutableDictionary 或 NSMutableArray
  //  NSJSONReadingMutableLeaves = (1UL << 1), // 内部所有的字符串都是可变的...iOS7之后有问题, 一般不用
  //  NSJSONReadingAllowFragments = (1UL << 2) // 如果服务器返回的JSON数据，不是标准的JSON，那么就必须使用这个值，否则无法解析
  // 注意：什么是不标准的 JSON 呢？
  // 当我们将字符串 json 的值分别设置为，10、10.1、true、false、null的时候，
  // options 必须选择 NSJSONReadingAllowFragments 这种类型，否则就会无法解析出其中的内容。
  // ------------------------------------------------------------------------------
  // NSString *json = @"null";
  // // NSString *json = @"10";
  // // NSString *json = @"10.1;
  // // 10 --> NSNumber
  // // 10.1 --> NSNumber
  // // true/false --> NSNumber
  // // null --> NSNull(空对象)
  // NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
  // id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
  // NSLog(@"%@", [obj class]);
  // ------------------------------------------------------------------------------

  return ^(NSData *data, NSJSONReadingOptions options) {
    id obj = [NSJSONSerialization JSONObjectWithData:data
                                             options:options
                                               error:nil];
    return obj;
  };
}

// OC对象 -> JSON数据 序列化
+ (NSData *(^)(id))serialization {

  return ^NSData *(id obj) {
    /* Returns YES if the given object can be converted to JSON data, NO otherwise. The object must have the following properties:
    - Top level object is an NSArray or NSDictionary
    - All objects are NSString, NSNumber, NSArray, NSDictionary, or NSNull
    - All dictionary keys are NSStrings
    - NSNumbers are not NaN or infinity
    - Other rules may apply. Calling this method or attempting a conversion are the definitive ways to tell if a given object can be converted to JSON data.
    - 如果给定对象可以转换为JSON数据，则返回yes，否则不返回。
    - 对象必须具有以下属性：-顶级对象是NSArray或NSDictionary
    - 所有对象都是NSString、NSNumber、NSArray、NSDicary或NSNull-所有字典键都是NSStrings-NSNumbers不是NaN或无穷大
    - 其他规则可能适用. 调用此方法或尝试转换是判断给定对象是否可以转换为JSON数据的明确方法。
    */
    BOOL i = [NSJSONSerialization isValidJSONObject:obj];
    if (i) {
      NSData *data = [NSJSONSerialization dataWithJSONObject:obj
                                                     options:NSJSONWritingPrettyPrinted
                                                       error:nil];
      return data;
    }
    return nil;
  };

}

+ (id(^)(NSString *))jsonFileToObject {
  return ^id(NSString *fileName) {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName
                                                         ofType:nil];
    NSData   *data     = [NSData dataWithContentsOfFile:filePath];
    id       obj       = self.deserialization(data);
    return obj;
  };
}

+ (UIImage *(^)(NSData *))dataToImage {
  return ^UIImage *(NSData *data) {
    return [UIImage imageWithData:data];
  };
}

+ (NSUInteger (^)(NSString *filePath))fileSize {
  return ^NSUInteger(NSString *filePath) {
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath
                                                                                error:nil];
    NSNumber     *size       = dictionary[@"NSFileSize"];
    return [size unsignedIntegerValue];
  };
}

// // #define kNewLine [dataM appendData:SNTools.stringToData(@"\r\n")]
// + (NSMutableURLRequest *)uploadWithImage:(UIImage *)image
//                                urlString:(NSString *)urlString {
//
//   // NSString * kBoundary = @"----WebKitFormBoundaryjv0UfA04ED44AhWx"
//   NSString *kBoundary = kConcat(@"----WebKitFormBoundary", [self getmd5WithString:NSDate.new.toTimeStamp]);
//
//   NSData *imageData = UIImagePNGRepresentation(image);
//
//   NSURL *url = [NSURL URLWithString:urlString];
//
//   NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//
//   request.HTTPMethod = @"POST";
//
//   [request setValue:kStringFormat(@"multipart/form-data; boundary=%@", kBoundary)
//  forHTTPHeaderField:@"Content-Type"];
//
//   NSMutableData *dataM = nil;
//
//   void (^kNewLine)(NSMutableData *) = ^void(NSMutableData *mutableData) {
//     [mutableData appendData:SNTools.stringToData(@"\r\n")];
//   };
//
//   {
//     dataM = [NSMutableData data];
//
//     [dataM appendData:SNTools.stringToData(kStringFormat(@"--%@", kBoundary))];
//     kNewLine(dataM);
//     {
//       NSString *str = [self getmd5WithString:NSDate.new.toTimeStamp];
//       [dataM appendData:SNTools.stringToData(kStringFormat(@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.png\"", str))];
//       kNewLine(dataM);
//       [dataM appendData:SNTools.stringToData(@"Content-Type: image/png")];
//       kNewLine(dataM);
//       kNewLine(dataM);
//       {
//         // UIImage *image = kImageWithName(@"temp");
//         // NSData  *data  = UIImageJPEGRepresentation(image, 1.0);
//         [dataM appendData:imageData];
//       }
//     }
//     [dataM appendData:SNTools.stringToData(kStringFormat(@"--%@", kBoundary))];
//     kNewLine(dataM);
//     // [dataM appendData:SNTools.stringToData(kStringFormat(@"Content-Disposition: form-data; name=\"%@\"", @"username"))];
//     // kNewLine;
//     // kNewLine;
//     // [dataM appendData:SNTools.stringToData(@"123456")];
//     kNewLine(dataM);
//     [dataM appendData:SNTools.stringToData(kStringFormat(@"--%@--", kBoundary))];
//   }
//
//   request.HTTPBody = dataM;
//
//   return request;
// }

// ( ‾ ʖ̫ ‾)
+ (NSMutableURLRequest *(^)(NSString *, UIImage *))upload {
  NSMutableURLRequest *(^pFunction)(NSString *, UIImage *)=^NSMutableURLRequest *(NSString *urlString, UIImage *image) {
    // NSString * kBoundary = @"----WebKitFormBoundaryjv0UfA04ED44AhWx"
    NSString *kBoundary = kConcat(@"----WebKitFormBoundary", [self getmd5WithString:NSDate.new.toTimeStamp]);

    // NSData *imageData = UIImagePNGRepresentation(image);
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);

    NSURL *url = [NSURL URLWithString:urlString];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    request.HTTPMethod = @"POST";

    [request setValue:kStringFormat(@"multipart/form-data; boundary=%@", kBoundary)
   forHTTPHeaderField:@"Content-Type"];

    NSMutableData *dataM = nil;

    void (^kNewLine)(NSMutableData *) = ^void(NSMutableData *mutableData) {
      [mutableData appendData:SNTools.stringToData(@"\r\n")];
    };

    {
      dataM = [NSMutableData data];

      [dataM appendData:SNTools.stringToData(kStringFormat(@"--%@", kBoundary))];
      kNewLine(dataM);
      {
        NSString *str = [self getmd5WithString:NSDate.new.toTimeStamp];
        [dataM appendData:SNTools.stringToData(kStringFormat(@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.jpg\"", str))];
        kNewLine(dataM);
        [dataM appendData:SNTools.stringToData(@"Content-Type: image/jpeg")];
        kNewLine(dataM);
        kNewLine(dataM);
        {
          // UIImage *image = kImageWithName(@"temp");
          // NSData  *data  = UIImageJPEGRepresentation(image, 1.0);
          [dataM appendData:imageData];
        }
      }
      [dataM appendData:SNTools.stringToData(kStringFormat(@"--%@", kBoundary))];
      kNewLine(dataM);
      // [dataM appendData:SNTools.stringToData(kStringFormat(@"Content-Disposition: form-data; name=\"%@\"", @"username"))];
      // kNewLine;
      // kNewLine;
      // [dataM appendData:SNTools.stringToData(@"123456")];
      kNewLine(dataM);
      [dataM appendData:SNTools.stringToData(kStringFormat(@"--%@--", kBoundary))];
    }

    request.HTTPBody = dataM;

    return request;
  };

  return pFunction;
}

+ (NSString *(^)(NSString *))getMIMETypeWithMainQueue {
  return ^NSString *(NSString *filePath) {
    NSURL               *url      = [NSURL fileURLWithPath:filePath];
    NSMutableURLRequest *request  = [NSMutableURLRequest requestWithURL:url];
    NSURLResponse       *response = nil;
    [NSURLConnection sendSynchronousRequest:request
                          returningResponse:&response
                                      error:nil];
    return response.MIMEType;
  };
}

+ (void (^)(NSString *, void(^)(NSString *MIMEType)))getMIMETypeWithConcurrentQueue {
  return ^void(NSString *filePath, void(^callback)(NSString *MIMEType)) {
    NSURL               *url     = [NSURL fileURLWithPath:filePath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                             callback(response.MIMEType);
                           }];
  };
}

+ (NSString *(^)(NSString *))getMIMETypeWithSystem {
  return ^NSString *(NSString *filePath) {
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
      return nil;
    }
    CFStringRef UTI      = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef) filePath.pathExtension, NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) {
      return @"application/octet-stream";
    }
    return (__bridge NSString *) (MIMEType);
  };
}

+ (BOOL (^)(NSString *, NSArray<NSString *> *))zip {
  return ^BOOL(NSString *destinationFilePath, NSArray<NSString *> *filePaths) {
    return [SSZipArchive createZipFileAtPath:destinationFilePath
                            withFilesAtPaths:filePaths];
  };
}

+ (BOOL (^)(NSString *, NSArray<NSString *> *, NSString *))zipWithPassword {
  return ^BOOL(NSString *destinationFilePath, NSArray<NSString *> *filePaths, NSString *password) {
    return [SSZipArchive createZipFileAtPath:destinationFilePath
                            withFilesAtPaths:filePaths
                                withPassword:password];
  };
}

+ (BOOL (^)(NSString *, NSString *))zipWithDirectory {
  return ^BOOL(NSString *destinationFilePath, NSString *directory) {
    return [SSZipArchive createZipFileAtPath:destinationFilePath
                     withContentsOfDirectory:directory];
  };
}

+ (BOOL (^)(NSString *, NSString *))unzip {
  return ^BOOL(NSString *zipFilePath, NSString *destinationFilePath) {
    return [SSZipArchive unzipFileAtPath:zipFilePath
                           toDestination:destinationFilePath];
  };
}

+ (BOOL (^)(NSString *, NSString *, void(^)(NSString *, unz_file_info, long, long), void(^)(NSString *, BOOL, NSError *)))unzipWithBlock {
  return ^BOOL(NSString *zipFilePath, NSString *destinationFilePath, void(^progressHandler)(NSString *entry, unz_file_info zipInfo, long entryNumber, long total),
               void(^completionHandler)(NSString *path, BOOL succeeded, NSError *error)) {
    return [SSZipArchive unzipFileAtPath:zipFilePath
                           toDestination:destinationFilePath
                         progressHandler:^(NSString *entry, unz_file_info zipInfo, long entryNumber, long total) {
                           progressHandler(entry, zipInfo, entryNumber, total);
                         }
                       completionHandler:^(NSString *path, BOOL succeeded, NSError *error) {
                         completionHandler(path, succeeded, error);
                       }];
  };
}

+ (NSString *(^)(NSString *))imageExtension {
  return ^NSString *(NSString *filePath) {

    NSData *data = [NSData dataWithContentsOfFile:filePath];

    SDImageFormat imageFormat = [NSData sd_imageFormatForImageData:data];

    //   SDImageFormatUndefined = -1,
    //   SDImageFormatJPEG = 0,
    //   SDImageFormatPNG,
    //   SDImageFormatGIF,
    //   SDImageFormatTIFF,
    //   SDImageFormatWebP,
    //   SDImageFormatHEIC

    switch (imageFormat) {
      case SDImageFormatJPEG:
        return @".jpg";
      case SDImageFormatPNG:
        return @".png";
      case SDImageFormatGIF:
        return @".gif";
      case SDImageFormatTIFF:
        return @".tiff";
      case SDImageFormatWebP:
        return @".webp";
      case SDImageFormatHEIC:
        return @".heic";
      default:
        return @"";
        break;
    }
  };
}

+ (BOOL (^)(NSData *, NSString *))dataWriteToFileToDesktop {
  return ^BOOL(NSData *data, NSString *fileName) {
    // atomically：这个参数意思是如果为YES则保证文件的写入原子性,就是说会先创建一个临时文件,直到文件内容写入成功再导入到目标文件里.
    // 如果为NO,则直接写入目标文件里.
    return [data writeToFile:[@"/Users/stone/Desktop" stringByAppendingPathComponent:fileName]
                  atomically:YES];
  };
}

+ (BOOL (^)(NSData *, NSString *))dataWriteToFile {
  return ^BOOL(NSData *data, NSString *filePath) {
    // atomically：这个参数意思是如果为YES则保证文件的写入原子性,就是说会先创建一个临时文件,直到文件内容写入成功再导入到目标文件里.
    // 如果为NO,则直接写入目标文件里.
    return [data writeToFile:filePath
                  atomically:YES];
  };
}

- (void)typeof {

}

+ (NSString *(^)(id))getClassName {
  return ^NSString *(id obj) {
    return [NSString stringWithFormat:@"%@", object_getClass(obj)];
  };
}

+ (NSDictionary *(^)(NSString *))plistToDictionary {
  return ^NSDictionary *(NSString *fileName) {

    NSString *filePath = nil;
    if ([fileName containsString:@"plist"]) {
      filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    } else {
      filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    }
    NSDictionary *dictionary = [NSDictionary dictionaryWithContentsOfFile:filePath];
    return dictionary;
  };
}

+ (NSArray *(^)(NSString *))plistToArray {
  return ^NSArray *(NSString *fileName) {
    NSString *filePath = nil;
    if ([fileName containsString:@"plist"]) {
      filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    } else {
      filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    }
    NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
    return array;
  };
}

+ (NSDictionary *(^)(NSString *))jsonToDictionary {
  return ^NSDictionary *(NSString *fileName) {
    NSString *filePath = nil;
    if ([fileName containsString:@"json"]) {
      filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    } else {
      filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    }
    NSData       *data       = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    return dictionary;
  };
}

+ (NSArray *(^)(NSString *))jsonToArray {
  return ^NSArray *(NSString *fileName) {
    NSString *filePath = nil;
    if ([fileName containsString:@"json"]) {
      filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    } else {
      filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    }
    NSData  *data  = [NSData dataWithContentsOfFile:filePath];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

    return array;
  };
}

+ (NSString *(^)(NSDictionary *))dictionaryToProperties {
  return ^NSString *(NSDictionary *dictionary) {
    NSMutableString *strM = [NSMutableString string];
    [dictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
      NSString *code = nil;
      if ([obj isKindOfClass:[NSNumber class]]) {
        NSString *type = nil;
        if (strcmp([obj objCType], @encode(char)) == 0) {type = @"BOOL";}
        if (strcmp([obj objCType], @encode(unsigned char)) == 0) {type = @"unsigned char";}
        if (strcmp([obj objCType], @encode(short)) == 0) {type = @"v";}
        if (strcmp([obj objCType], @encode(unsigned short)) == 0) {type = @"unsigned short";}
        if (strcmp([obj objCType], @encode(int)) == 0) {type = @"int";}
        if (strcmp([obj objCType], @encode(unsigned int)) == 0) {type = @"unsigned int";}
        if (strcmp([obj objCType], @encode(long)) == 0) {type = @"long";}
        if (strcmp([obj objCType], @encode(unsigned long)) == 0) {type = @"unsigned long";}
        if (strcmp([obj objCType], @encode(long long)) == 0) {type = @"long long";}
        if (strcmp([obj objCType], @encode(unsigned long long)) == 0) {type = @"unsigned long long";}
        if (strcmp([obj objCType], @encode(float)) == 0) {type = @"float";}
        if (strcmp([obj objCType], @encode(double)) == 0) {type = @"double";}
        if (strcmp([obj objCType], @encode(CGFloat)) == 0) {type = @"CGFloat";}
        if (strcmp([obj objCType], @encode(BOOL)) == 0) {type = @"BOOL";}
        if (strcmp([obj objCType], @encode(NSInteger)) == 0) {type = @"NSInteger";}
        if (strcmp([obj objCType], @encode(NSUInteger)) == 0) {type = @"NSUInteger";}
        code = [NSString stringWithFormat:@"@property(nonatomic, assign) %@  %@", type, key];
      } else if ([obj isKindOfClass:[NSString class]]) {
        code = [NSString stringWithFormat:@"@property(nonatomic, copy) NSString * %@", key];
      } else if ([obj isKindOfClass:[NSArray class]]) {
        id o = ((NSArray *) obj).firstObject;
        if ([o isKindOfClass:[NSArray class]]) {
          code = [NSString stringWithFormat:@"@property(nonatomic, strong) NSArray<NSArray *> * %@", key];
        }
        if ([o isKindOfClass:[NSDictionary class]]) {
          code = [NSString stringWithFormat:@"@property(nonatomic, strong) NSArray<NSDictionary *> * %@", key];
        }
      } else if ([obj isKindOfClass:[NSDictionary class]]) {
        code = [NSString stringWithFormat:@"@property(nonatomic, strong) NSDictionary * %@", key];
      } else {
        code = [NSString stringWithFormat:@"@property(nonatomic, strong) NSObject * %@", key];
      }
      [strM appendFormat:@"\n%@\n", code];
    }];
    return strM.copy;
  };
}

#if DEBUG

+ (NSDictionary *(^)(id))getAllKeyAndValues {
  return ^NSDictionary *(id obj) {

    NSMutableDictionary *dictionaryM = [NSMutableDictionary dictionary];
    // runtime:根据模型中属性,去字典中取出对应的value给模型属性赋值
    // 1.获取模型中所有成员变量 key
    // 获取哪个类的成员变量
    // count:成员变量个数
    unsigned int        count        = 0;
    // 获取成员变量数组
    Ivar                *ivarList    = class_copyIvarList(object_getClass(obj), &count);
    // 遍历所有成员变量
    for (int            i            = 0; i < count; i++) {
      // 获取成员变量
      Ivar ivar = ivarList[i];

      NSString *type = nil;
      {
        const char *ivarGetTypeEncoding = ivar_getTypeEncoding(ivar);
        if (strcmp(ivarGetTypeEncoding, @encode(char)) == 0) {type = @"BOOL";}
        if (strcmp(ivarGetTypeEncoding, @encode(unsigned char)) == 0) {type = @"unsigned char";}
        if (strcmp(ivarGetTypeEncoding, @encode(short)) == 0) {type = @"v";}
        if (strcmp(ivarGetTypeEncoding, @encode(unsigned short)) == 0) {type = @"unsigned short";}
        if (strcmp(ivarGetTypeEncoding, @encode(int)) == 0) {type = @"int";}
        if (strcmp(ivarGetTypeEncoding, @encode(unsigned int)) == 0) {type = @"unsigned int";}
        if (strcmp(ivarGetTypeEncoding, @encode(long)) == 0) {type = @"long";}
        if (strcmp(ivarGetTypeEncoding, @encode(unsigned long)) == 0) {type = @"unsigned long";}
        if (strcmp(ivarGetTypeEncoding, @encode(long long)) == 0) {type = @"long long";}
        if (strcmp(ivarGetTypeEncoding, @encode(unsigned long long)) == 0) {type = @"unsigned long long";}
        if (strcmp(ivarGetTypeEncoding, @encode(float)) == 0) {type = @"float";}
        if (strcmp(ivarGetTypeEncoding, @encode(double)) == 0) {type = @"double";}
        if (strcmp(ivarGetTypeEncoding, @encode(CGFloat)) == 0) {type = @"CGFloat";}
        if (strcmp(ivarGetTypeEncoding, @encode(BOOL)) == 0) {type = @"BOOL";}
        if (strcmp(ivarGetTypeEncoding, @encode(NSInteger)) == 0) {type = @"NSInteger";}
        if (strcmp(ivarGetTypeEncoding, @encode(NSUInteger)) == 0) {type = @"NSUInteger";}

        if (type == nil) {type = [NSString stringWithUTF8String:ivarGetTypeEncoding];}
      }

      // NSLog(@"--------------------ivar = %s", ivarGetTypeEncoding);
      NSMutableString *strM = type.mutableCopy;
      if ([strM containsString:@"@"]) {
        [strM replaceOccurrencesOfString:@"@" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, strM.length)];
        [strM replaceOccurrencesOfString:@"\"" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, strM.length)];
        [strM appendFormat:@" *"];
      }
      // 获取成员变量名字
      NSString *ivarName  = [NSString stringWithUTF8String:ivar_getName(ivar)];
      NSString *keyString = [NSString stringWithFormat:@"%-20s%-20s", strM.UTF8String, ivarName.UTF8String];

      id o = [obj valueForKey:ivarName];
      if (!o) {o = [NSNull null];}

      dictionaryM[keyString] = o;
    }

    return dictionaryM.copy;
  };
}

+ (NSArray<NSString *> *(^)(id))getAllMethodNamesWithObj {

  return ^NSArray<NSString *> *(id obj) {

    NSMutableArray *arrM  = [NSMutableArray array];
    // 对象方法
    Class          pClass = object_getClass(obj);
    {
      unsigned int count    = 0;
      Method       *pMethod = class_copyMethodList(pClass, &count);
      for (int     i        = 0; i < count; i++) {
        Method     pObjc_method  = pMethod[i];
        SEL        pSelector     = method_getName(pObjc_method);
        NSString   *methodName   = NSStringFromSelector(pSelector);
        // IMP        imp_f     = method_getImplementation(pObjc_method);
        int        argumentCount = method_getNumberOfArguments(pObjc_method);
        const char *typeEncoding = method_getTypeEncoding(pObjc_method);
        [arrM addObject:[NSString stringWithFormat:@"-[%@]\t\t\t\targument-count: %d\t\t\t\ttype-encoding: %@", methodName, argumentCount, [NSString stringWithUTF8String:typeEncoding]]];
      }
    }

    // 类方法
    Class metaClass = object_getClass(pClass);
    {
      unsigned int count    = 0;
      Method       *pMethod = class_copyMethodList(metaClass, &count);
      for (int     i        = 0; i < count; i++) {
        Method     pObjc_method  = pMethod[i];
        SEL        pSelector     = method_getName(pObjc_method);
        NSString   *methodName   = NSStringFromSelector(pSelector);
        // IMP        imp_f     = method_getImplementation(pObjc_method);
        int        argumentCount = method_getNumberOfArguments(pObjc_method);
        const char *typeEncoding = method_getTypeEncoding(pObjc_method);
        [arrM addObject:[NSString stringWithFormat:@"+[%@]\t\t\t\targument-count: %d\t\t\t\ttype-encoding: %@", methodName, argumentCount, [NSString stringWithUTF8String:typeEncoding]]];
      }
    }

    [arrM sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
      return (NSComparisonResult) (obj1.length - obj2.length);
    }];

    return arrM.copy;
  };
}

+ (NSArray<NSString *> *(^)(Class))getAllMethodNamesWithClass {

  return ^NSArray<NSString *> *(Class cls) {

    NSMutableArray<NSString *> *arrM = [NSMutableArray array];
    // 对象方法
    {
      unsigned int count    = 0;
      Method       *pMethod = class_copyMethodList(cls, &count);
      for (int     i        = 0; i < count; i++) {
        Method     pObjc_method  = pMethod[i];
        SEL        pSelector     = method_getName(pObjc_method);
        NSString   *methodName   = NSStringFromSelector(pSelector);
        // IMP        imp_f     = method_getImplementation(pObjc_method);
        int        argumentCount = method_getNumberOfArguments(pObjc_method);
        const char *typeEncoding = method_getTypeEncoding(pObjc_method);
        [arrM addObject:[NSString stringWithFormat:@"-[%@]\t\t\t\targument-count: %d\t\t\t\ttype-encoding: %@", methodName, argumentCount, [NSString stringWithUTF8String:typeEncoding]]];
      }
    }

    // 类方法
    Class metaClass = object_getClass(cls);
    {
      unsigned int count    = 0;
      Method       *pMethod = class_copyMethodList(metaClass, &count);
      for (int     i        = 0; i < count; i++) {
        Method     pObjc_method  = pMethod[i];
        SEL        pSelector     = method_getName(pObjc_method);
        NSString   *methodName   = NSStringFromSelector(pSelector);
        // IMP        imp_f     = method_getImplementation(pObjc_method);
        int        argumentCount = method_getNumberOfArguments(pObjc_method);
        const char *typeEncoding = method_getTypeEncoding(pObjc_method);
        [arrM addObject:[NSString stringWithFormat:@"+[%@]\t\t\t\targument-count: %d\t\t\t\ttype-encoding: %@", methodName, argumentCount, [NSString stringWithUTF8String:typeEncoding]]];
      }
    }

    [arrM sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
      return (NSComparisonResult) (obj1.length - obj2.length);
    }];

    return arrM.copy;
  };
}

#endif

@end

//sn_note:=========  ============================ stone 🐳 ===========/


