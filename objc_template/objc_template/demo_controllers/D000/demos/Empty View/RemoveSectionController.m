//
//  RemoveSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.

#import "RemoveSectionController.h"
#import "RemoveCell.h"

@protocol RemoveSectionControllerDelegate;

@interface RemoveSectionController () <RemoveCellDelegate>

@property (strong, nonatomic) NSNumber *object;

@end

@implementation RemoveSectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset = UIEdgeInsetsMake(0, 0, 10, 0);
  }
  return self;
}

- (NSInteger)numberOfItems {

  return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
  return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  RemoveCell *cell = [self.collectionContext dequeueReusableCellOfClass:RemoveCell.class forSectionController:self atIndex:index];

  cell.label.text = kStringFormat(@"Cell: %li", self.object.integerValue + 1);

  cell.delegate = self;

  return cell;
}

- (void)didUpdateToObject:(id)object {
  self.object = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
  // NSLog(@"%s", __func__);
}

- (void)didDeselectItemAtIndex:(NSInteger)index {
  // NSLog(@"%s", __func__);
}

- (void)didHighlightItemAtIndex:(NSInteger)index {
  // NSLog(@"%s", __func__);
}

- (void)didUnhighlightItemAtIndex:(NSInteger)index {
  // NSLog(@"%s", __func__);
}

- (BOOL)canMoveItemAtIndex:(NSInteger)index {
  return NO;
}

- (void)moveObjectFromIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex {
  // NSLog(@"%s", __func__);
}

- (void)removeCellDidTapButton:(RemoveCell *)cell {
  if ([self.delegate respondsToSelector:@selector(removeSectionControllerWantsRemoved:)]) {
    [self.delegate removeSectionControllerWantsRemoved:self];
  }
}


@end





