//
//  IncrementAnnouncer.m
//  objc_template
//
//  Created by stone on 2019/5/4.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IncrementAnnouncer.h"

@interface IncrementAnnouncer ()

@property (strong, nonatomic) NSNumber                        *value;
@property (strong, nonatomic) NSHashTable <IncrementListener> *map;
@end

@implementation IncrementAnnouncer

- (instancetype)init {
  self = [super init];
  if (self) {
    self.value = @0;
    self.map   = (NSHashTable <IncrementListener> *) [NSHashTable weakObjectsHashTable];
  }
  return self;
}

- (void)addListener:(id <IncrementListener>)listener {
  [self.map addObject:listener];
}

- (void)increment {
  self.value = @(self.value.integerValue + 1);
  NSArray *array = self.map.allObjects;
  for (id <IncrementListener> listener in array) {
    [listener didIncrement:self value:self.value];
  }
}

@end
