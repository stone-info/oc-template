//
//  NSArray+ES6.h
//  objc_template
//
//  Created by stone on 2019/5/2.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (ES6)
- (NSArray *)map:(id (^)(id obj))block;

- (NSArray *)filter:(BOOL (^)(id obj))block;

- (id)reduce:(id)initial block:(id (^)(id obj1, id obj2))block;

- (NSArray *)flatMap:(id (^)(id obj))block;

- (BOOL)contains:(BOOL (^)(id obj))block;

- (void)forEach:(void (^)(id obj))block;
@end

@interface NSArray (ES6Class)

- (NSArray *)map:(id (^)(id obj))block class:(Class)aClass;

- (NSArray *)filter:(BOOL (^)(id obj))block class:(Class)aClass;

- (id)reduce:(id)initial block:(id (^)(id obj1, id obj2))block class:(Class)aClass;

- (NSArray *)flatMap:(id (^)(id obj))block class:(Class)aClass;

- (BOOL)contains:(BOOL (^)(id obj))block class:(Class)aClass;

- (void)forEach:(void (^)(id obj))block class:(Class)aClass;

@end

NS_ASSUME_NONNULL_END
