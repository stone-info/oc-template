//
//  SNRegex.h
//  objective_c_template
//
//  Created by stone on 2019/3/27.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNGroup : NSObject
@property (copy, nonatomic) NSString *match;
@property (assign, nonatomic) NSRange  range;

- (NSString *)description;
@end

@interface SNMatch : NSObject

@property (copy, nonatomic) NSString                  *match;
@property (assign, nonatomic) NSRange                   range;
@property (strong, nonatomic) NSMutableArray<SNGroup *> *group;

- (NSString *)description;

@end

@interface SNRegex : NSObject
+ (NSMutableArray<SNMatch *> *)findAllWithPattern:(NSString *)pattern string:(NSString *)string options:(NSRegularExpressionOptions)options;

+ (SNMatch *)searchWithPattern:(NSString *)pattern string:(NSString *)string options:(NSRegularExpressionOptions)options;

+ (BOOL)testWithPattern:(NSString *)pattern string:(NSString *)string options:(NSRegularExpressionOptions)options;

// 完全匹配
+ (BOOL)fullMatchWithPattern:(NSString *)pattern string:(NSString *)string;

+ (NSString *)replaceWithPattern:(NSString *)pattern from:(NSString *)from to:(NSString *)to options:(NSRegularExpressionOptions)options;
@end

NS_ASSUME_NONNULL_END
