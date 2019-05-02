//
//  NSArray+PropertiesExtentsion.h
//  003_UIButton
//
//  Created by stone on 2018/7/25.
//  Copyright © 2018年 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (ArrayExtentsion)
+ (NSArray<NSString *> *)getProperties:(Class)cls;
+ (NSArray<NSString *> *)getPropertiesExtension:(NSObject *)obj;


@end

//@interface NSArray<ObjectType> (ES6)
//- (NSMutableArray *)filterWithBlock:(BOOL(^)(ObjectType obj, NSUInteger index))block;
//- (NSMutableArray *)mapWithBlock:(id(^)(ObjectType obj, NSUInteger index))block;
//@end

@interface NSArray (SNGetObjet)
- (id)getObjectWithClassName:(NSString *)className;
@end
