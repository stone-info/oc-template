//
//  NSArray+ES6.m
//  objc_template
//
//  Created by stone on 2019/5/2.
//  Copyright © 2019 stone. All rights reserved.
//

#import "NSArray+ES6.h"

@implementation NSArray (ES6)

#pragma mark - Map, filter, reduce, flatMap function without class restrictor

- (NSArray *)map:(id (^)(id obj, NSUInteger idx))block {
  NSMutableArray *mutableArray = [NSMutableArray new];
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [mutableArray addObject:block(obj, idx)];
  }];
  return [mutableArray copy];
}

- (NSArray *)filter:(BOOL (^)(id obj, NSUInteger idx))block {
  NSMutableArray *mutableArray = [NSMutableArray new];
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if (block(obj, idx) == YES) {
      [mutableArray addObject:obj];
    }
  }];
  return [mutableArray copy];
}

- (id)reduce:(id)initial block:(id (^)(id obj1, id obj2, NSUInteger idx))block {
  __block id obj = initial;
  [self enumerateObjectsUsingBlock:^(id _obj, NSUInteger idx, BOOL *stop) {
    obj = block(obj, _obj, idx);
  }];
  return obj;
}

- (NSArray *)flatMap:(id (^)(id obj))block {
  NSMutableArray *mutableArray = [NSMutableArray new];
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    id _obj = block(obj);
    if ([_obj isKindOfClass:[NSArray class]]) {
      NSArray *_array = [_obj flatMap:block];
      [mutableArray addObjectsFromArray:_array];
      return;
    }
    [mutableArray addObject:_obj];
  }];
  return [mutableArray copy];
}

- (BOOL)contains:(BOOL (^)(id obj))block {
  __block BOOL contains = NO;
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if (block(obj) == YES) {
      contains = YES;
      *stop = YES;
    }
  }];
  return contains;
}

- (void)forEach:(void (^)(id obj, NSUInteger idx))block {
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    block(obj, idx);
  }];
}
@end

@implementation NSArray (ES6Class)

#pragma mark - Map, filter, reduce, flatMap function with class restrictor

- (NSArray *)map:(id (^)(id obj, NSUInteger idx))block class:(Class)aClass {

  NSMutableArray *mutableArray = [NSMutableArray new];
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if ([obj isKindOfClass:aClass]) {
      [mutableArray addObject:block(obj, idx)];
    }
  }];
  return [mutableArray copy];
}

- (NSArray *)filter:(BOOL (^)(id obj, NSUInteger idx))block class:(Class)aClass {

  NSMutableArray *mutableArray = [NSMutableArray new];
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if ([obj isKindOfClass:aClass] && block(obj, idx) == YES) {
      [mutableArray addObject:obj];
    }
  }];
  return [mutableArray copy];
}

- (id)reduce:(id)initial block:(id (^)(id obj1, id obj2, NSUInteger idx))block class:(Class)aClass {

  __block id obj = initial;
  [self enumerateObjectsUsingBlock:^(id _obj, NSUInteger idx, BOOL *stop) {
    if ([obj isKindOfClass:aClass] && [_obj isKindOfClass:aClass]) {
      obj = block(obj, _obj, idx);
    }
  }];
  return obj;
}

- (NSArray *)flatMap:(id (^)(id obj))block class:(Class)aClass {

  NSMutableArray *mutableArray = [NSMutableArray new];
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    id _obj = block(obj);
    if ([_obj isKindOfClass:[NSArray class]]) {
      NSArray *_array = [_obj flatMap:block class:aClass];
      [mutableArray addObjectsFromArray:_array];
      return;
    }

    if ([_obj isKindOfClass:aClass]) {
      [mutableArray addObject:_obj];
    }
  }];
  return [mutableArray copy];
}

- (BOOL)contains:(BOOL (^)(id obj))block class:(Class)aClass {

  __block BOOL contains = NO;
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if (![obj isKindOfClass:aClass]) { return; }

    if (block(obj) == YES) {
      contains = YES;
      *stop = YES;
    }
  }];
  return contains;
}

- (void)forEach:(void (^)(id obj, NSUInteger idx))block class:(Class)aClass {

  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if (![obj isKindOfClass:aClass]) { return; }
    block(obj, idx);
  }];
}

@end
