//
//  SNMacro.h
//  objc_template
//
//  Created by stone on 2019/4/7.
//  Copyright © 2019 stone. All rights reserved.
//

#ifndef SNMacro_h
#define SNMacro_h


//                              /* 代码块 */
/************************************************************************************/
// #define kBorder(view)  view.layer.borderColor  = HexRGBA(@"0xcccccc", 1.0).CGColor; \
//   view.layer.borderWidth   = 1.0;\
//   view.layer.masksToBounds = YES;
#define kBorder(view)  view.layer.borderColor  = HexRGBA(@"#cccccc", 1.0).CGColor; view.layer.borderWidth   = 1.0; KLog(@"kBorder(%s)", #view);

#define kShadow(view)  view.layer.shadowColor  = HexRGBA(@"#a0a0a0", 1.0).CGColor; \
view.layer.shadowOffset = CGSizeMake(0, 0);\
view.layer.shadowOpacity = 1;\
view.layer.shadowRadius  = 1;

//                              /* 设置角度 | 动画 */
/************************************************************************************/
// #define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
//由角度获取弧度
// #define kDegreesToRadian(angle) (M_PI * (angle) / 180.0)
//有弧度获取角度
#define kRadianToDegrees(radian) (radian*180.0)/(M_PI)
#define kScale(view, sx, sy) (view.transform = CGAffineTransformScale(view.transform, sx, sy))
#define kRotate(view, degrees) (view.transform = CGAffineTransformRotate(view.transform, (M_PI * (degrees) / 180.0)))
#define kRotateWithRadian(view, radian) (view.transform = CGAffineTransformRotate(view.transform, radian))
#define kRotateWithDegrees(view, degrees) (view.transform = CGAffineTransformRotate(view.transform, (M_PI * (degrees) / 180.0)))
#define kTranslate(view, tx, ty) (view.transform = CGAffineTransformTranslate(view.transform, tx, ty))
#define kScaleWithMake(view, sx, sy) (view.transform = CGAffineTransformMakeScale(sx, sy))
#define kRotateWithMake(view, degrees) (view.transform = CGAffineTransformMakeRotation((M_PI * (degrees) / 180.0)))
#define kRotateWithMakeRadian(view, radian) (view.transform = CGAffineTransformMakeRotation(radian))
#define kRotateWithMakeDegrees(view, degrees) (view.transform = CGAffineTransformMakeRotation((M_PI * (degrees) / 180.0)))
#define kTranslateWithMake(view, tx, ty) (view.transform = CGAffineTransformMakeTranslation(tx, ty))
//                              /* string */
/************************************************************************************/
#define kStringFormat(FORMAT, ...) ([NSString stringWithFormat:FORMAT, ##__VA_ARGS__])
#define kConcat(firstStr, ...) [NSString JoinedWithSubStrings:firstStr,__VA_ARGS__,nil]
#define toStringNSInteger(VALUE) [NSString stringWithFormat:@"%ld",VALUE]
#define toStringCGFloat(VALUE) [NSString stringWithFormat:@"%f",VALUE]
#define toStringObject(VALUE) [NSString stringWithFormat:@"%@",VALUE]
#define toStringInt(VALUE) [NSString stringWithFormat:@"%d",VALUE]
#define toStringLongLong(VALUE) [NSString stringWithFormat:@"%lld",VALUE]
#define toStringCGRect(VALUE) NSStringFromCGRect(VALUE)
#define toStringCGSize(VALUE) NSStringFromCGSize(VALUE)
#define toStringCGPoint(VALUE) NSStringFromCGSize(VALUE)
#define toStringClass(VALUE) NSStringFromClass(VALUE)

//                              /* 存储路径 */
/************************************************************************************/
// parameter1: 搜索的目录
// parameter2: 搜索的范围
// parameter3: 是否展开路径(在iOS当中识别) 如果是NO [ "~/Documents" ] , 如果是YES [ "/xxxx/xxxx/xxxx/Documents" ]
//
// NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)

// 保存应用程序运行时生成的需要持久化的数据, iTunes同步设备时会备份该目录. 例如, 游戏应用可将游戏存档保存在该目录
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
// 保存应用运行时生成的需要持久化的数据, iTunes同步设备时不会备份该目录, 一般存储体积较大, 不需要备份的非重要数据
#define kCachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define kLibrary [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]
#define kHome NSHomeDirectory()
#define kTemporary NSTemporaryDirectory()
#define kDocumentPathWithFileName(FILENAME) ([[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:FILENAME])
#define kCachePathWithFileName(FILENAME) ([[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:FILENAME])
#define kLibraryWithFileName(FILENAME) ([[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:FILENAME])
#define kTemporaryWithFileName(FILENAME) ([NSTemporaryDirectory() stringByAppendingPathComponent:FILENAME])

//                              /* file */
/************************************************************************************/
#define kFileManager ([NSFileManager defaultManager])

//                              /* empty */
/************************************************************************************/

//                              /* SN */
/************************************************************************************/
#define sn SN

//                              /* alert */
/************************************************************************************/
#define kAlert(title,msg) ([[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show])


//                              /* image */
/************************************************************************************/
#define kImageURL(imageUrl) [NSFormatString(imageUrl) rangeOfString:@"http"].length>0?[NSURL URLWithString:[NSString stringWithFormat:@"%@",imageUrl]]:([NSURL URLWithString:[NSString stringWithFormat:@"http://%@%@%@",@"www.geeboo.com/librarys/",@"system/getRes.go?id=",imageUrl]])
// #define kImageWithName(name) [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
#define kImageWithBundle(bundleName, imageName) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@/%@",bundleName, imageName] ofType:nil]]

//                              /* #block */
/************************************************************************************/
/**
 *  强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 *  调用方式: `@weakify_self`实现弱引用转换，`@strongify_self`实现强引用转换
 *
 *  示例：
 *  @weakify_self
 *  [obj block:^{
 *  @strongify_self
 *      self.property = something;
 *  }];
 */
#ifndef  weakify_self
#if __has_feature(objc_arc)
#define weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;
#else
#define weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;
#endif
#endif

#ifndef  strongify_self
#if __has_feature(objc_arc)
#define strongify_self try{} @finally{} __typeof__(weakSelf) self = weakSelf;
#else
#define strongify_self try{} @finally{} __typeof__(blockSelf) self = blockSelf;
#endif
#endif

/**
 *  强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 *  调用方式: `@weakify(object)`实现弱引用转换，`@strongify(object)`实现强引用转换
 *
 *  示例：
 *  @weakify(object)
 *  [obj block:^{
 *      @strongify(object)
 *      strong_object = something;
 *  }];
 */
#ifndef  weakify
#if __has_feature(objc_arc)
#define weakify(object)  autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object)  autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#endif

#ifndef  strongify
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = block##_##object;
#endif
#endif
//                              /* #归档 | 不要忘记遵守协议 <NSCoding> */
/************************************************************************************/
#define kEncode                                                   \
-(void)encodeWithCoder : (NSCoder *)aCoder {                    \
unsigned int count;                                           \
Ivar *       ivar = class_copyIvarList([self class], &count); \
for (int i = 0; i < count; i++) {                             \
Ivar        iv      = ivar[i];                              \
const char *name    = ivar_getName(iv);                     \
NSString *  strName = [NSString stringWithUTF8String:name]; \
id          value   = [self valueForKey:strName];           \
[aCoder encodeObject:value forKey:strName];                 \
}                                                             \
free(ivar);                                                   \
}

#define kDecode                                                        \
-(instancetype)initWithCoder : (NSCoder *)aDecoder {                 \
self = [super init];                                               \
if (self != nil) {                                                 \
unsigned int count = 0;                                          \
Ivar *       ivar  = class_copyIvarList([self class], &count);   \
for (int i = 0; i < count; i++) {                                \
Ivar        var     = ivar[i];                                 \
const char *keyName = ivar_getName(var);                       \
NSString *  key     = [NSString stringWithUTF8String:keyName]; \
id          value   = [aDecoder decodeObjectForKey:key];       \
[self setValue:value forKey:key];                              \
}                                                                \
free(ivar);                                                      \
}                                                                  \
return self;                                                       \
}


//                              /* #masonry */
/************************************************************************************/
// #define kMasKey(VIEW) ;
#define kMasKey(VIEW) do { VIEW.mas_key = [NSString stringWithFormat:@"%@ -> %s", [NSString stringWithFormat:@"%@:%d", [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent], __LINE__], #VIEW]; }while(0);

//                              /* #toast */
/************************************************************************************/
// #define kToast(containerView, content) { \
// //   MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:containerView animated:YES]; \
// //   hud.mode       = MBProgressHUDModeText;\
// //   hud.label.text = content;\
// //   hud.label.font = kPingFangSCRegular(14);\
// //   hud.label.numberOfLines   = 0;\
// //   hud.offset     = CGPointMake(0.f, MBProgressMaxOffset);\
// //   [hud hideAnimated:YES afterDelay:3.f];\
// // }

#define kToast(containerView, content) { \
NSString *text          = content;\
UIFont   *font          = kPingFangSCRegular(14);\
CGFloat singLineHeight  = [@"single" stringHeightWithMaxWidth:containerView.bounds.size.width - 46.5 font:font];\
CGFloat h               = [text stringHeightWithMaxWidth:containerView.bounds.size.width - 46.5 font:font];\
MBProgressHUD *hud      = [MBProgressHUD showHUDAddedTo:containerView animated:YES];\
hud.mode                = MBProgressHUDModeText;\
hud.label.text          = text;\
hud.label.font          = font;\
if (h > singLineHeight) {\
hud.label.textAlignment = NSTextAlignmentLeft;\
} else {\
hud.label.textAlignment = NSTextAlignmentCenter;\
}\
hud.label.numberOfLines = 0;\
hud.offset              = CGPointMake(0.f, MBProgressMaxOffset);\
[hud hideAnimated:YES afterDelay:3.f];\
}

//                              /* #obj */
/************************************************************************************/
#define keyPath(objc, keyPath) @(((void)objc.keyPath,#keyPath))

//                              /* #block */
/************************************************************************************/
/**
 *  强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 *  调用方式: `@weakify_self`实现弱引用转换，`@strongify_self`实现强引用转换
 *
 *  示例：
 *  @weakify_self
 *  [obj block:^{
 *  @strongify_self
 *      self.property = something;
 *  }];
 */
#ifndef  weakify_self
#if __has_feature(objc_arc)
#define weakify_self autoreleasepool{} __weak __typeof__(self) weakSelf = self;
#else
#define weakify_self autoreleasepool{} __block __typeof__(self) blockSelf = self;
#endif
#endif

#ifndef  strongify_self
#if __has_feature(objc_arc)
#define strongify_self try{} @finally{} __typeof__(weakSelf) self = weakSelf;
#else
#define strongify_self try{} @finally{} __typeof__(blockSelf) self = blockSelf;
#endif
#endif

/**
 *  强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 *  调用方式: `@weakify(object)`实现弱引用转换，`@strongify(object)`实现强引用转换
 *
 *  示例：
 *  @weakify(object)
 *  [obj block:^{
 *      @strongify(object)
 *      strong_object = something;
 *  }];
 */
#ifndef  weakify
#if __has_feature(objc_arc)
#define weakify(object)  autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define weakify(object)  autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#endif

#ifndef  strongify
#if __has_feature(objc_arc)
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = weak##_##object;
#else
#define strongify(object) try{} @finally{} __typeof__(object) strong##_##object = block##_##object;
#endif
#endif


#endif /* SNMacro_h */
