//
//  GridItem.m
//  objc_template
//
//  Created by stone on 2019/5/3.
//  Copyright © 2019 stone. All rights reserved.
//

#import "GridItem.h"
#import <IGListKit/IGListDiffable.h>

@interface GridItem () <IGListDiffable>


@end

@implementation GridItem

- (instancetype)initWithColor:(UIColor *)color itemCount:(NSInteger)itemCount {
  self = [super init];
  if (self) {
    self.color     = color;
    self.itemCount = itemCount;
    self.items     = [self computeItems];
  }
  return self;
}

- (NSArray<NSString *> *)computeItems {

  NSMutableArray *arrM = [NSMutableArray array];

  for (NSInteger i = 1; i <= self.itemCount; ++i) {
    [arrM addObject:kStringFormat(@"%li", i)];
  }

  // NSLog(@"%s", __func__);

  // NSLog(@"arrM = %@", arrM);

  return arrM.copy;
}

- (nonnull id <NSObject>)diffIdentifier {
  return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  return self == other ? YES : [self isEqual:other];
}


@end

