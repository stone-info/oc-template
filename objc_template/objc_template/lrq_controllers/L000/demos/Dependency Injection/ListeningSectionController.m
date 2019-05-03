//
//  ListeningSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.

#import "ListeningSectionController.h"
#import "IncrementAnnouncer.h"
#import "LabelCell.h"

@interface ListeningSectionController () <IncrementListener>

@property (strong, nonatomic) NSNumber *value;
@end

@implementation ListeningSectionController

- (void)didIncrement:(IncrementAnnouncer *)announcer value:(NSNumber *)value {

  self.value = value;

  LabelCell *cell = [self.collectionContext cellForItemAtIndex:0 sectionController:self];

  [self configureCell:cell];
}

- (instancetype)initWithAnnouncer:(IncrementAnnouncer *)announcer {
  self = [super init];
  if (self) {

    self.value = @0;

    [announcer addListener:self];

  }
  return self;
}

- (void)configureCell:(LabelCell *)cell {
  cell.label.text = kStringFormat(@"Section: %li, value: %@", self.section, self.value);
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
  return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {

  LabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:LabelCell.class forSectionController:self atIndex:index];

  [self configureCell:cell];

  return cell;
}

@end
