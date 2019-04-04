//
//  SNRegex.m
//  objective_c_template
//
//  Created by stone on 2019/3/27.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNRegex.h"

@implementation SNGroup
- (NSString *)description {
  return @{@"match": self.match, @"range": NSStringFromRange(self.range)}.description;
}

@end

@implementation SNMatch
- (NSString *)description {
  return @{@"match": self.match, @"range": NSStringFromRange(self.range), @"group": self.group}.description;
}

@end

@implementation SNRegex

+ (NSMutableArray<SNMatch *> *)findAllWithPattern:(NSString *)pattern string:(NSString *)string options:(NSRegularExpressionOptions)options {

  NSString            *s = string;
  NSRegularExpression *regex;
  @try {
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:nil];
  }
  @catch (NSException *exception) {
    NSLog(@"pattern create fail");
    return @[].mutableCopy;
  }

  NSArray<NSTextCheckingResult *> *matche_list = [regex matchesInString:s options:(NSMatchingOptions) kNilOptions range:NSMakeRange(0, s.length)];
  NSMutableArray<SNMatch *>       *result_map  = NSMutableArray.new;
  for (NSTextCheckingResult       *match in matche_list) {
    NSRange  range      = [match rangeAtIndex:0];
    NSString *substring = [s substringWithRange:range];
    SNMatch  *snmatch   = SNMatch.new;
    snmatch.match = substring;
    snmatch.range = range;
    snmatch.group = NSMutableArray.new;
    [result_map addObject:snmatch];

    NSUInteger lastRangeIndex = match.numberOfRanges - 1;

    if (lastRangeIndex >= 1) {

      for (NSUInteger i = 1; i <= lastRangeIndex; ++i) {
        NSRange r_range = [match rangeAtIndex:i];
        if (r_range.length != 0) {
          NSString *matchedString = [s substringWithRange:r_range];
          SNGroup  *group         = SNGroup.new;
          group.match = matchedString;
          group.range = r_range;
          [snmatch.group addObject:group];
        }
      }
    } else {
      continue;
    }
  }
  return result_map;
}

+ (SNMatch *)searchWithPattern:(NSString *)pattern string:(NSString *)string options:(NSRegularExpressionOptions)options {
  NSString            *s = string;
  NSRegularExpression *regex;
  @try {
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:nil];
  }
  @catch (NSException *exception) {
    NSLog(@"pattern create fail");
    return nil;
  }

  NSArray<NSTextCheckingResult *> *matche_list = [regex matchesInString:s options:(NSMatchingOptions) kNilOptions range:NSMakeRange(0, s.length)];

  SNMatch *snmatch = SNMatch.new;

  if (matche_list.count > 0) {
    NSTextCheckingResult *match = matche_list.firstObject;

    NSRange  range      = [match rangeAtIndex:0];
    NSString *substring = [s substringWithRange:range];
    snmatch.match = substring;
    snmatch.range = range;
    snmatch.group = NSMutableArray.new;

    NSUInteger lastRangeIndex = match.numberOfRanges - 1;

    if (lastRangeIndex >= 1) {

      for (NSUInteger i = 1; i <= lastRangeIndex; ++i) {
        NSRange r_range = [match rangeAtIndex:i];
        if (r_range.length != 0) {
          NSString *matchedString = [s substringWithRange:r_range];
          SNGroup  *group         = SNGroup.new;
          group.match = matchedString;
          group.range = r_range;
          [snmatch.group addObject:group];
        }
      }
    }
    return snmatch;
  }
  return nil;
}

+ (BOOL)testWithPattern:(NSString *)pattern string:(NSString *)string options:(NSRegularExpressionOptions)options {
  NSString                        *s           = string;
  NSRegularExpression             *regex;
  @try {
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:nil];
  }
  @catch (NSException *exception) {
    NSLog(@"pattern create fail");
    return NO;
  }
  NSArray<NSTextCheckingResult *> *matchList = [regex matchesInString:s options:(NSMatchingOptions) kNilOptions range:NSMakeRange(0, s.length)];
  return matchList.count > 0 ? YES : NO;
}

+ (BOOL)fullMatchWithPattern:(NSString *)pattern string:(NSString *)string {
  NSString    *regex     = pattern;
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
  return [predicate evaluateWithObject:string];
}

+ (NSString *)replaceWithPattern:(NSString *)pattern from:(NSString *)from to:(NSString *)to options:(NSRegularExpressionOptions)options {

  if (pattern.length == 0) { return nil; }
  if (from.length == 0) { return nil; }
  if (to.length == 0) { return nil; }

  NSRegularExpression *regex;
  @try {
    regex = [NSRegularExpression regularExpressionWithPattern:pattern options:options error:nil];
  }
  @catch (NSException *exception) {
    NSLog(@"pattern create fail");
    return nil;
  }
  return [regex stringByReplacingMatchesInString:from options:NSMatchingReportProgress range:NSMakeRange(0, from.length) withTemplate:to];
}

@end
