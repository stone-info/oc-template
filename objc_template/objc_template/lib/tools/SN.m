//
//  SNTools.m
//  006_UIAdvanced
//
//  Created by stone on 2018/8/2.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "SN.h"
#import <objc/message.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import <SSZipArchive/SSZipArchive.h>
//需要引入此头文件来使用CC_MD5
#import <CommonCrypto/CommonDigest.h>
// 需要SDWebImage
#import <SDWebImage/NSData+ImageContentType.h>

#define FileHashDefaultChunkSizeForReadingData 1024*8 // 8K

// #if DEBUG
//
// /** 为了编译时 不报错, 声明就好, 系统已经时间, 我们只需把消息发出去就可以 */
// @interface NSObject (Private)
// // 返回格式化的字符串，
// // 内容为该对象的成员变量以及类型和值（并且明确标出继承自父类的成员变量）
// - (id)_ivarDescription;
//
// // 返回格式化的字符串，内容为该对象的成员方法和属性列表，
// // 包括getter和setter，省略掉父类中继承来的方法等信息
// - (id)_shortMethodDescription;
//
// // 返回格式化的字符串，内容为该对象的成员方法和属性列表，
// // 包括getter和setter，包含完整父类中继承来的方法等信息
// - (id)_methodDescription;
// @end
//
// #endif

@interface SN ()

@end

@implementation SN

#if DEBUG

+ (id (^)(id))ivarDescription {
  return ^id(id obj) {
    return ((id (*)(id, SEL)) (void *) objc_msgSend)(obj, NSSelectorFromString(@"_ivarDescription"));
  };
}

+ (id (^)(id))shortMethodDescription {
  return ^id(id obj) {
    return ((id (*)(id, SEL)) (void *) objc_msgSend)(obj, NSSelectorFromString(@"_shortMethodDescription"));
  };
}

+ (id (^)(id))methodDescription {
  return ^id(id obj) {
    return ((id (*)(id, SEL)) (void *) objc_msgSend)(obj, NSSelectorFromString(@"_methodDescription"));
  };
}

#endif

+ (NSString *(^)(id))getClassName {
  return ^NSString *(id obj) {
    return [NSString stringWithFormat:@"%@", object_getClass(obj)];
  };
}

// + (BOOL)isEmpty:(id)obj {
//
//   NSString *type = SN.getClassName(obj);
//
//   if ([type containsString:@"String"]) {
//     NSUInteger length = ((NSUInteger (*)(id, SEL)) (void *) objc_msgSend)(obj, NSSelectorFromString(@"length"));
//     if (length == 0) {
//       return YES;
//     } else {
//       return NO;
//     }
//   }
//
//   if ([type containsString:@"Array"]) {
//     NSUInteger count = ((NSUInteger (*)(id, SEL)) (void *) objc_msgSend)(obj, NSSelectorFromString(@"count"));
//     if (count == 0) {
//       return YES;
//     } else {
//       return NO;
//     }
//   }
//
//   if ([type containsString:@"Dictionary"]) {
//     NSArray *keys = ((NSArray *(*)(id, SEL)) (void *) objc_msgSend)(obj, NSSelectorFromString(@"allKeys"));
//     if (keys.count == 0) {
//       return YES;
//     } else {
//       return NO;
//     }
//   }
//
//   return NO;
// }

+ (BOOL(^)(__kindof NSObject *))isEmpty {

  return ^BOOL(__kindof NSObject *obj) {

    NSString *type = SN.getClassName(obj);

    if ([type containsString:@"String"]) {
      NSUInteger length = ((NSUInteger (*)(id, SEL)) (void *) objc_msgSend)(obj, NSSelectorFromString(@"length"));
      if (length == 0) { return YES; } else { return NO; }
    }

    if ([type containsString:@"Array"]) {
      NSUInteger count = ((NSUInteger (*)(id, SEL)) (void *) objc_msgSend)(obj, NSSelectorFromString(@"count"));
      if (count == 0) { return YES; } else { return NO; }
    }

    if ([type containsString:@"Dictionary"]) {
      NSArray *keys = ((NSArray *(*)(id, SEL)) (void *) objc_msgSend)(obj, NSSelectorFromString(@"allKeys"));
      if (keys.count == 0) { return YES; } else { return NO; }
    }

    return NO;
  };
}

+ (double)SNDeviceSystemVersion {

  static double          version;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    version = [UIDevice currentDevice].systemVersion.doubleValue;
  });
  return version;
}

+ (CGSize)SNDeviceScreenSize {

  static CGSize size;

  static dispatch_once_t onceToken;

  dispatch_once(&onceToken, ^{
    size = [UIScreen mainScreen].bounds.size;
    if (size.height <= size.width) {
      CGFloat tmp = size.height;
      size.height = size.width;
      size.width  = tmp;
    }
  });
  return size;
}

+ (UIImage *)imageNamedWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName extension:(NSString *__nullable)extension {

  NSString *resource;

  if (extension) {
    resource = [NSString stringWithFormat:@"%@/%@.%@", bundleName, imageName, extension];
  } else {
    resource = [NSString stringWithFormat:@"%@/%@", bundleName, imageName];
  }

  NSString *path = [[NSBundle mainBundle] pathForResource:resource ofType:nil];

  return [UIImage imageWithContentsOfFile:path];
}

// + (NSString *)randomString {
//
//   NSString *chars = @"abcdefghijklmnopqrstuvwxzyABCDEFGHIJKLMNOPQRSTUVWXZY0123456789  ";
//
//   NSString      *str = @"";
//   for (uint32_t i    = 0; arc4random_uniform(100) > 0; i--) {
//     uint32_t uniform = arc4random_uniform((uint32_t) chars.length - 1);
//
//     NSLog(@"uniform = %u", uniform);
//     NSString *string = [chars substringWithRange:NSMakeRange(uniform, 1)];
//     NSLog(@"string = %@", string);
//
//     str = [NSString stringWithFormat:@"%@%@", str, string];
//   }
//
//   return str;
// }
+ (NSString *)randomString {

  NSString      *chars = @"abcdefghijklmnopqrstuvwxzyABCDEFGHIJKLMNOPQRSTUVWXZY0123456789~!@#$%^&*()_+-=<>?,./{}|[]\\";
  NSString      *str   = @"";
  for (uint32_t i      = 32; i > 0; i--) {
    uint32_t uniform = arc4random_uniform((uint32_t) chars.length);
    NSString *string = [chars substringWithRange:NSMakeRange(uniform, 1)];
    // str = [NSString stringWithFormat:@"%@%@", str, string];
    str = [str stringByAppendingString:string];
  }

  return str;
}

+ (UIColor *)randomColor {
  CGFloat hue        = (arc4random() % 256 / 256.0);  //  0.0 to 1.0
  CGFloat saturation = (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from white
  CGFloat brightness = (arc4random() % 128 / 256.0) + 0.5;  //  0.5 to 1.0, away from black
  return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIImage *(^)(NSString *))resizableImageWithImageName {
  return ^UIImage *(NSString *imageName) {
    UIImage *image      = [UIImage imageNamed:imageName];
    CGFloat imageWidth  = image.size.width;
    CGFloat imageHeight = image.size.height;
    return [image stretchableImageWithLeftCapWidth:(NSInteger) (imageWidth * 0.5) topCapHeight:(NSInteger) (imageHeight * 0.5)];
  };
}

+ (UIImage *(^)(UIImage *))resizableImageWithImage {
  return ^UIImage *(UIImage *image) {
    CGFloat imageWidth  = image.size.width;
    CGFloat imageHeight = image.size.height;
    return [image stretchableImageWithLeftCapWidth:(NSInteger) (imageWidth * 0.5) topCapHeight:(NSInteger) (imageHeight * 0.5)];
  };
}

+ (NSValue *(^)(CGRect))valueWithCGRect {
  return ^NSValue *(CGRect rect) {
    return [NSValue valueWithCGRect:rect];
  };
}

+ (NSValue *(^)(CGSize))valueWithCGSize {
  return ^NSValue *(CGSize size) {
    return [NSValue valueWithCGSize:size];
  };
}

+ (NSValue *(^)(CGPoint))valueWithCGPoint {
  return ^NSValue *(CGPoint point) {
    return [NSValue valueWithCGPoint:point];
  };
}

+ (NSValue *(^)(UIEdgeInsets))valueWithUIEdgeInsets {
  return ^NSValue *(UIEdgeInsets insets) {
    return [NSValue valueWithUIEdgeInsets:insets];
  };
}

+ (NSValue *(^)(CGFloat, CGFloat, CGFloat, CGFloat))valueWithRect {
  return ^NSValue *(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
    return [NSValue valueWithCGRect:CGRectMake(x, y, width, height)];
  };
}

+ (NSValue *(^)(CGFloat, CGFloat))valueWithSize {
  return ^NSValue *(CGFloat width, CGFloat height) {
    return [NSValue valueWithCGSize:CGSizeMake(width, height)];
  };
}

+ (NSValue *(^)(CGFloat, CGFloat))valueWithPoint {
  return ^NSValue *(CGFloat x, CGFloat y) {
    return [NSValue valueWithCGPoint:CGPointMake(x, y)];;
  };
}

+ (NSValue *(^)(CGFloat, CGFloat, CGFloat, CGFloat))valueWithEdgeInsets {
  return ^NSValue *(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right) {
    return [NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(top, left, bottom, right)];
  };
}

// - (CGFloat)suggestHeight:(CGFloat)width
//                    image:(UIImage *)image {
//   return width * image.size.height / image.size.width;
// }
//
// - (CGFloat)suggestWidth:(CGFloat)height
//                   image:(UIImage *)image {
//   return height * image.size.width / image.size.height;
// }

+ (CGFloat (^)(CGFloat, UIImage *))suggestHeight {
  return ^CGFloat(CGFloat width, UIImage *image) {
    return width * image.size.height / image.size.width;
  };
}

+ (CGFloat (^)(CGFloat, UIImage *))suggestWidth {
  return ^CGFloat(CGFloat height, UIImage *image) {
    return height * image.size.width / image.size.height;
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
        if (strcmp(ivarGetTypeEncoding, @encode(char)) == 0) { type = @"BOOL"; }
        if (strcmp(ivarGetTypeEncoding, @encode(unsigned char)) == 0) { type = @"unsigned char"; }
        if (strcmp(ivarGetTypeEncoding, @encode(short)) == 0) { type = @"v"; }
        if (strcmp(ivarGetTypeEncoding, @encode(unsigned short)) == 0) { type = @"unsigned short"; }
        if (strcmp(ivarGetTypeEncoding, @encode(int)) == 0) { type = @"int"; }
        if (strcmp(ivarGetTypeEncoding, @encode(unsigned int)) == 0) { type = @"unsigned int"; }
        if (strcmp(ivarGetTypeEncoding, @encode(long)) == 0) { type = @"long"; }
        if (strcmp(ivarGetTypeEncoding, @encode(unsigned long)) == 0) { type = @"unsigned long"; }
        if (strcmp(ivarGetTypeEncoding, @encode(long long)) == 0) { type = @"long long"; }
        if (strcmp(ivarGetTypeEncoding, @encode(unsigned long long)) == 0) { type = @"unsigned long long"; }
        if (strcmp(ivarGetTypeEncoding, @encode(float)) == 0) { type = @"float"; }
        if (strcmp(ivarGetTypeEncoding, @encode(double)) == 0) { type = @"double"; }
        if (strcmp(ivarGetTypeEncoding, @encode(CGFloat)) == 0) { type = @"CGFloat"; }
        if (strcmp(ivarGetTypeEncoding, @encode(BOOL)) == 0) { type = @"BOOL"; }
        if (strcmp(ivarGetTypeEncoding, @encode(NSInteger)) == 0) { type = @"NSInteger"; }
        if (strcmp(ivarGetTypeEncoding, @encode(NSUInteger)) == 0) { type = @"NSUInteger"; }

        if (type == nil) { type = [NSString stringWithUTF8String:ivarGetTypeEncoding]; }
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
      if (!o) { o = [NSNull null]; }

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

+ (__kindof UITableViewCell *(^)(__kindof UITableView *, Class))dequeueForCell {
  return ^__kindof UITableViewCell *(__kindof UITableView *tableView, Class cls) {
    return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cls)];
  };
}

+ (__kindof UITableViewHeaderFooterView *(^)(__kindof UITableView *, Class))dequeueForHeaderView {
  return ^__kindof UITableViewHeaderFooterView *(__kindof UITableView *tableView, Class cls) {
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(cls)];
  };
}

+ (__kindof UITableViewHeaderFooterView *(^)(__kindof UITableView *, Class))dequeueForFooterView {
  return ^__kindof UITableViewHeaderFooterView *(__kindof UITableView *tableView, Class cls) {
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(cls)];
  };
}

/**
 开启一个定时器

 @param target 定时器持有者
 @param timeInterval 执行间隔时间
 @param handler 重复执行事件
 */
void dispatchTimer(id target, double timeInterval, void (^handler)(dispatch_source_t timer)) {
  dispatch_queue_t        queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_source_t       timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
  // dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), (uint64_t)(timeInterval *NSEC_PER_SEC), 0);
  dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, timeInterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
  // 设置回调 // 奇淫技巧啊... 通过自己引用自己 不被释放 - - , 牛B死了...
  __weak __typeof(target) weaktarget = target;
  // https://www.jianshu.com/p/0f9b0aec9f60
  // 闭包引用外部变量, 这个外部变量不能死, 死了, 闭包引用他 是个鬼啊?
  dispatch_source_set_event_handler(timer, ^{
    if (!weaktarget) {
      dispatch_source_cancel(timer);
    } else {
      // dispatch_async(dispatch_get_main_queue(), ^{
      //编译时block会对timer对象强引用，使timer不会被过早释放
      if (handler) { handler(timer); }
      // });
    }
  });
  // 启动定时器
  dispatch_resume(timer);
}


// SEC   秒
// PER   每
// NSEC 纳秒
// MSEC 毫秒
// USEC 微秒
//
// #define NSEC_PER_SEC 1000000000ull     多少纳秒 = 1秒            1秒 = 10亿纳秒
// #define NSEC_PER_MSEC 1000000ull       多少纳秒 = 1毫秒          1毫秒 = 100万纳秒
// #define USEC_PER_SEC 1000000ull        多少微秒 = 1秒            1秒 = 100万微秒
// #define NSEC_PER_USEC 1000ull          多少纳秒 = 1微秒           1微秒 = 1000 纳秒

// 主线程中执行 毫秒
void setTimeout(id target, void (^handler)(dispatch_source_t timer), uint64_t timeout) {

  dispatch_queue_t       queue    = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_source_t      timer    = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
  // unsigned long long int start    = DISPATCH_TIME_NOW;
  unsigned long long int start    = dispatch_time(DISPATCH_TIME_NOW, timeout * NSEC_PER_MSEC);
  uint64_t               interval = timeout * NSEC_PER_MSEC;
  // dispatch_source_set_timer 的第四个参数 leeway 指的是一个期望的容忍时间，将它设置为 1 秒，
  // 意味着系统有可能在定时器时间到达的前 1 秒或者后 1 秒才真正触发定时器。
  // 在调用时推荐设置一个合理的 leeway 值。需要注意，就算指定 leeway 值为 0，
  // 系统也无法保证完全精确的触发时间，只是会尽可能满足这个需求。
  unsigned long long int leeway   = 0 * NSEC_PER_MSEC;

  dispatch_source_set_timer(timer, start, interval, leeway);
  // 设置回调 // 奇淫技巧啊... 通过自己引用自己 不被释放 - - , 牛B死了...
  __weak __typeof(target) weaktarget = target;
  // https://www.jianshu.com/p/0f9b0aec9f60
  // 闭包引用外部变量, 这个外部变量不能死, 死了, 闭包引用他 是个鬼啊?
  dispatch_source_set_event_handler(timer, ^{
    if (!weaktarget) {
      dispatch_source_cancel(timer);
    } else {
      dispatch_async(dispatch_get_main_queue(), ^{
        if (handler) { handler(timer); }
        dispatch_source_cancel(timer);
      });
    }
  });
  // 启动定时器
  dispatch_resume(timer);
}

// 主线程中执行 毫秒
void setInterval(id target, void (^handler)(dispatch_source_t timer), uint64_t timeout) {

  dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

  // 何时开始执行第一个任务 (开始计时时间)
  // dispatch_time(DISPATCH_TIME_NOW, 3.0 * NSEC_PER_SEC) 比当前时间晚3秒
  unsigned long long int start    = dispatch_time(DISPATCH_TIME_NOW, timeout * NSEC_PER_MSEC);
  uint64_t               interval = timeout * NSEC_PER_MSEC;
  // dispatch_source_set_timer 的第四个参数 leeway 指的是一个期望的容忍时间，将它设置为 1 秒，
  // 意味着系统有可能在定时器时间到达的前 1 秒或者后 1 秒才真正触发定时器。
  // 在调用时推荐设置一个合理的 leeway 值。需要注意，就算指定 leeway 值为 0，
  // 系统也无法保证完全精确的触发时间，只是会尽可能满足这个需求。
  unsigned long long int leeway   = 0 * NSEC_PER_MSEC;

  dispatch_source_set_timer(timer, start, interval, leeway);

  // 设置回调 // 奇淫技巧啊... 通过自己引用自己 不被释放 - - , 牛B死了...
  __weak __typeof(target) weaktarget = target;
  // https://www.jianshu.com/p/0f9b0aec9f60
  // 闭包引用外部变量, 这个外部变量不能死, 死了, 闭包引用他 是个鬼啊?
  dispatch_source_set_event_handler(timer, ^{
    if (!weaktarget) {
      dispatch_source_cancel(timer);
    } else {
      dispatch_async(dispatch_get_main_queue(), ^{
        if (handler) { handler(timer); }
      });
    }
  });
  // 启动定时器
  dispatch_resume(timer);
}

+ (MBProgressHUD *(^)(__kindof UIView *, NSString *))showHUD {
  return ^MBProgressHUD *(__kindof UIView *containerView, NSString *message) {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:containerView animated:YES];
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.backgroundView.color = [UIColor colorWithWhite:0.f alpha:0.1f];
    hud.label.text           = message;
    hud.label.font           = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    return hud;
  };
}

+ (void (^)(MBProgressHUD *))hideHUD {
  return ^void(MBProgressHUD *hud) {
    return [hud hideAnimated:YES];;
  };
}

+ (void (^)(NSString *, id))writeFile {
  return ^void(NSString *path, id content) {
    if ([content isKindOfClass:NSDictionary.class] || [content isKindOfClass:NSArray.class] || [content isKindOfClass:NSData.class]) {
      // 如果是，则将数据写入备份文件，然后假设没有发生错误，
      // 则将备份文件重命名为PATH指定的名称；否则，数据将直接写入PATH。
      [content writeToFile:path atomically:YES];
      NSLog(@"%s", __func__);
    }
  };
}

+ (id (^)(NSString *))readFile {
  return ^id(NSString *path) {
    id content = [NSDictionary dictionaryWithContentsOfFile:path];
    if (content) {
      return content;
    } else {
      content = [NSArray arrayWithContentsOfFile:path];
      return content;
    }
  };
}

+ (NSString *(^)(NSString *, NSString *))pathJoin {
  return ^NSString *(NSString *path, NSString *file) {
    return [path stringByAppendingPathComponent:file];
  };
}

+ (void (^)(__nullable id, NSString *))writeToPreferences {
  return ^void(__nullable id obj, NSString *key) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obj forKey:key];
    // [defaults synchronize]; // 遗弃的方法
  };
}

+ (__nullable id (^)(NSString *))readFromPreferences {
  return ^__nullable id(NSString *key) {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:key];
    // [defaults synchronize]; // 遗弃的方法
  };
}

+ (void (^)(id, NSCoder *))encode {
  return ^void(id obj, NSCoder *encoder) {
    unsigned int count;
    Ivar         *ivar = class_copyIvarList([obj class], &count);
    for (int     i     = 0; i < count; i++) {
      Ivar       iv       = ivar[i];
      const char *name    = ivar_getName(iv);
      NSString   *strName = [NSString stringWithUTF8String:name];
      //利用KVC取值
      id         value    = [obj valueForKey:strName];
      [encoder encodeObject:value forKey:strName];
    }
    free(ivar);
  };
}

+ (void (^)(id, NSCoder *))decode {
  return ^void(id obj, NSCoder *decoder) {
    unsigned int count = 0;
    Ivar         *ivar = class_copyIvarList([self class], &count);
    for (int     i     = 0; i < count; i++) {
      Ivar       var      = ivar[i];
      const char *keyName = ivar_getName(var);
      NSString   *key     = [NSString stringWithUTF8String:keyName];
      id         value    = [decoder decodeObjectForKey:key];
      [self setValue:value forKey:key];
    }
    free(ivar);
  };
}

+ (BOOL (^)(id, NSString *))archive {
  return ^BOOL(id obj, NSString *filename) {
    return [NSKeyedArchiver archiveRootObject:obj toFile:kCachePathWithFileName(filename)];
  };
}

+ (id (^)(NSString *))unarchive {
  return ^id(NSString *filename) {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kCachePathWithFileName(filename)];
  };
}

/** 16进制(字符串形式) 返回 图片 */
+ (UIImage *(^)(NSString *))imageWithString {
  return ^UIImage *(NSString *string) {
    return self.imageWithColor(self.colorWithString(string));
  };
}

/** 16进制返回颜色 */
+ (UIColor *(^)(NSString *string))colorWithString {
  return ^UIColor *(NSString *string) {
    CGFloat  alpha  = 1.0f;
    NSNumber *red   = @0.0;
    NSNumber *green = @0.0;
    NSNumber *blue  = @0.0;

    NSMutableArray<NSNumber *> *colors = [NSMutableArray arrayWithArray:@[red, green, blue]];

    unsigned hexComponent;
    NSString *colorString              = [string uppercaseString];

    for (int i = 0; i < colors.count; i++) {
      NSString *substring = [colorString substringWithRange:NSMakeRange(i * 2, 2)];

      [[NSScanner scannerWithString:substring] scanHexInt:&hexComponent];

      NSNumber *temp = colors[i];
      temp = @(hexComponent / 255.0);
      colors[i] = temp;
    }

    return [UIColor colorWithRed:[colors[0] floatValue] green:[colors[1] floatValue] blue:[colors[2] floatValue] alpha:alpha];
  };
}

/** 颜色 返回 图片 */
+ (UIImage *(^)(UIColor *))imageWithColor {
  return ^UIImage *(UIColor *color) {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
  };
}

+ (NSString *(^)(NSData *))dataToString {
  return ^(NSData *data) {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];;
  };
}

+ (NSData *(^)(NSString *))stringToData {
  return ^(NSString *string) {
    return [string dataUsingEncoding:NSUTF8StringEncoding];
  };
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
    id obj = [NSJSONSerialization JSONObjectWithData:data options:options error:nil];
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
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
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

// ( ‾ ʖ̫ ‾)
+ (NSMutableURLRequest *(^)(NSString *, UIImage *))upload {
  NSMutableURLRequest *(^pFunction)(NSString *, UIImage *) =^NSMutableURLRequest *(NSString *urlString, UIImage *image) {
    // NSString * kBoundary = @"----WebKitFormBoundaryjv0UfA04ED44AhWx"
    // NSString *kBoundary = kConcat(@"----WebKitFormBoundary", [self getMD5WithString:NSDate.new.toTimeStamp]);
    NSString *kBoundary = [NSString JoinedWithSubStrings:@"----WebKitFormBoundary", [self getMD5WithString:NSDate.new.toTimeStamp], nil];
    // NSData *imageData = UIImagePNGRepresentation(image);
    NSData   *imageData = UIImageJPEGRepresentation(image, 1.0);

    NSURL *url = [NSURL URLWithString:urlString];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

    request.HTTPMethod = @"POST";

    [request setValue:kStringFormat(@"multipart/form-data; boundary=%@", kBoundary)
             forHTTPHeaderField:@"Content-Type"];

    NSMutableData *dataM = nil;

    void (^kNewLine)(NSMutableData *) = ^void(NSMutableData *mutableData) {
      [mutableData appendData:self.stringToData(@"\r\n")];
    };

    {
      dataM = [NSMutableData data];

      [dataM appendData:self.stringToData(kStringFormat(@"--%@", kBoundary))];
      kNewLine(dataM);
      {
        NSString *str = [self getMD5WithString:NSDate.new.toTimeStamp];
        [dataM appendData:self.stringToData(kStringFormat(@"Content-Disposition: form-data; name=\"file\"; filename=\"%@.jpg\"", str))];
        kNewLine(dataM);
        [dataM appendData:self.stringToData(@"Content-Type: image/jpeg")];
        kNewLine(dataM);
        kNewLine(dataM);
        {
          // UIImage *image = kImageWithName(@"temp");
          // NSData  *data  = UIImageJPEGRepresentation(image, 1.0);
          [dataM appendData:imageData];
        }
      }
      [dataM appendData:self.stringToData(kStringFormat(@"--%@", kBoundary))];
      kNewLine(dataM);
      // [dataM appendData:SNTools.stringToData(kStringFormat(@"Content-Disposition: form-data; name=\"%@\"", @"username"))];
      // kNewLine;
      // kNewLine;
      // [dataM appendData:SNTools.stringToData(@"123456")];
      kNewLine(dataM);
      [dataM appendData:self.stringToData(kStringFormat(@"--%@--", kBoundary))];
    }

    request.HTTPBody = dataM;

    return request;
  };

  return pFunction;
}

+ (NSString *(^)(NSString *))md5WithString {
  return ^NSString *(NSString *string) {
    return [self getMD5WithString:string];
  };
}

+ (NSString *(^)(NSData *))md5WithData {
  return ^NSString *(NSData *data) {
    return [self getMD5WithData:data];
  };
}

+ (NSString *(^)(NSString *))md5WithFilePath {
  return ^NSString *(NSString *path) {
    return [self getFileMD5WithPath:path];
  };
}

+ (NSString *)getMD5WithString:(NSString *)string {
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

static CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath, size_t chunkSizeForReadingData) {

  // Declare needed variables
  CFStringRef     result     = NULL;
  CFReadStreamRef readStream = NULL;

  // Get the file URL
  CFURLRef fileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault, (CFStringRef) filePath, kCFURLPOSIXPathStyle, (Boolean) false);

  CC_MD5_CTX hashObject;
  bool hasMoreData = true;
  bool didSucceed;

  if (!fileURL) { goto done; }

  // Create and open the read stream
  readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault, (CFURLRef) fileURL);
  if (!readStream) { goto done; }
  didSucceed = (bool) CFReadStreamOpen(readStream);
  if (!didSucceed) { goto done; }

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
    if (readBytesCount == -1) { break; }
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
  if (!didSucceed) { goto done; }

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

+ (NSString *(^)(NSString *))getMIMETypeWithMainQueue {
  return ^NSString *(NSString *filePath) {
    NSURL               *url      = [NSURL fileURLWithPath:filePath];
    NSMutableURLRequest *request  = [NSMutableURLRequest requestWithURL:url];
    NSURLResponse       *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    return response.MIMEType;
  };
}

+ (void (^)(NSString *, void(^)(NSString *MIMEType)))getMIMETypeWithConcurrentQueue {
  return ^void(NSString *filePath, void(^callback)(NSString *MIMEType)) {
    NSURL               *url     = [NSURL fileURLWithPath:filePath];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
      callback(response.MIMEType);
    }];
  };
}

+ (NSString *(^)(NSString *))getMIMETypeWithSystem {
  return ^NSString *(NSString *filePath) {
    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) { return nil; }
    CFStringRef UTI      = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (__bridge CFStringRef) filePath.pathExtension, NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass(UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
    if (!MIMEType) { return @"application/octet-stream"; }
    return (__bridge NSString *) (MIMEType);
  };
}

+ (BOOL (^)(NSString *, NSArray<NSString *> *))zip {
  return ^BOOL(NSString *destinationFilePath, NSArray<NSString *> *filePaths) {
    return [SSZipArchive createZipFileAtPath:destinationFilePath withFilesAtPaths:filePaths];
  };
}

+ (BOOL (^)(NSString *, NSArray<NSString *> *, NSString *))zipWithPassword {
  return ^BOOL(NSString *destinationFilePath, NSArray<NSString *> *filePaths, NSString *password) {
    return [SSZipArchive createZipFileAtPath:destinationFilePath withFilesAtPaths:filePaths withPassword:password];
  };
}

+ (BOOL (^)(NSString *, NSString *))zipWithDirectory {
  return ^BOOL(NSString *destinationFilePath, NSString *directory) {
    return [SSZipArchive createZipFileAtPath:destinationFilePath withContentsOfDirectory:directory];
  };
}

+ (BOOL (^)(NSString *, NSString *))unzip {
  return ^BOOL(NSString *zipFilePath, NSString *destinationFilePath) {
    return [SSZipArchive unzipFileAtPath:zipFilePath toDestination:destinationFilePath];
  };
}

+ (BOOL (^)(NSString *, NSString *, void(^)(NSString *, unz_file_info, long, long), void(^)(NSString *, BOOL, NSError *)))unzipWithBlock {

  return ^BOOL(NSString *zipFilePath, NSString *destinationFilePath, void(^progressHandler)(NSString *entry, unz_file_info zipInfo, long entryNumber, long total), void(^completionHandler)(NSString *path, BOOL succeeded, NSError *error)) {

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

+ (void)promiseAll:(NSArray<SNTaskBlock> *)taskList completed:(void (^)(void))completed {

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

+ (NSArray<NSString *> *(^)(NSString *, NSString *))split {
  return ^NSArray<NSString *> *(NSString *source, NSString *splitString) {
    return [source componentsSeparatedByString:splitString];
  };
}

+ (BOOL (^)(NSString *))xibExists {
  return ^BOOL(NSString *xibName) {
    NSString *nibPath = [[NSBundle mainBundle] pathForResource:xibName ofType:@"nib"];

    if (nibPath) {
      return YES;
    } else {
      return NO;
    }

  };
}

+ (BOOL (^)(NSString *, NSString *))compare {
  return ^BOOL(NSString *l, NSString *r) {
    return [l isEqualToString:r];
  };
}

@end
