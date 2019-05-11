//
//  ReorderableSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.

#import "ReorderableSectionController.h"
#import "LabelCell.h"

@interface ReorderableSectionController ()

@property (strong, nonatomic) id object;

@end

@implementation ReorderableSectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
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
  LabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:LabelCell.class forSectionController:self atIndex:index];
  cell.label.text = _object;
  return cell;
}

- (void)didUpdateToObject:(id)object {
  self.object = kStringFormat(@"%@", object);
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
  return YES;
}

- (void)moveObjectFromIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex {
  // NSLog(@"%s", __func__);
}

@end
