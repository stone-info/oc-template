//
//  NSArray+PropertiesExtentsion.m
//  003_UIButton
//
//  Created by stone on 2018/7/25.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "NSArray+ArrayExtentsion.h"
#import <objc/runtime.h>// 导入运行时文件

@implementation NSArray (ArrayExtentsion)
+ (NSArray<NSString *> *)getProperties:(Class)cls {

  // 获取当前类的所有属性
  unsigned int               count;// 记录属性个数
  objc_property_t            *properties = class_copyPropertyList(cls, &count);
  // 遍历
  NSMutableArray<NSString *> *mArray     = [NSMutableArray array];
  for (int                   i           = 0; i < count; i++) {

    // An opaque type that represents an Objective-C declared property.
    // objc_property_t 属性类型
    objc_property_t property = properties[i];
    // 获取属性的名称 C语言字符串
    const char      *cName   = property_getName(property);
    // 转换为Objective C 字符串
    NSString        *name    = [NSString stringWithCString:cName
                                                  encoding:NSUTF8StringEncoding];
    [mArray addObject:name];
  }

  return mArray.copy;
}

#define NSLogObject(obj, keyString, valueString) NSLog(@"%s.%@ = %@", #obj, keyString,valueString)

+ (NSArray<NSString *> *)getPropertiesExtension:(NSObject *)obj {

  NSMutableArray<NSString *> *mArray = [NSMutableArray array];

  unsigned int count     = 0;
  Ivar         *property = class_copyIvarList([obj class], &count);
  for (int     i         = 0; i < count; i++) {
    Ivar       var   = property[i];
    const char *name = ivar_getName(var);
    const char *type = ivar_getTypeEncoding(var);

    NSString *keyString = [NSString stringWithUTF8String:name];

    id o = [obj valueForKeyPath:keyString];

    keyString = [keyString stringByReplacingOccurrencesOfString:@"_"
                                                     withString:@""];
    NSLogObject(obj, keyString, o);

    [mArray addObject:keyString];

  }

  return mArray.copy;;
}
@end

@implementation NSArray (ES6)

- (NSMutableArray *)filterWithBlock:(BOOL(^)(id obj, NSUInteger index))block {

  NSMutableArray  *arrM = NSMutableArray.new;
  NSUInteger      count = self.count;
  for (NSUInteger index = 0; index < count; ++index) {
    id obj = self[index];

    BOOL flag = block(obj, index);

    if (flag) {
      [arrM addObject:obj];
    }
  }
  return arrM;
}

- (NSMutableArray *)mapWithBlock:(id(^)(id obj, NSUInteger index))block {

  NSMutableArray  *arrM = NSMutableArray.new;
  NSUInteger      count = self.count;
  for (NSUInteger index = 0; index < count; ++index) {
    id obj = self[index];

    id o = block(obj, index);

    if (o == nil) {
      [arrM addObject:[NSNull null]];
    } else {
      [arrM addObject:o];
    }
  }
  return arrM;
}
@end

@implementation NSArray (SNGetObjet)
- (id)getObjectWithClassName:(NSString *)className {

  for (id obj in self) {
    if ([obj isKindOfClass:NSClassFromString(className)]) {
      return obj;
    }
  }
  return nil;
}
@end
