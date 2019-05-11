//
//  DisplaySectionController.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.

#import "DisplaySectionController.h"
#import "LabelCell.h"

@interface DisplaySectionController () <IGListDisplayDelegate>

@property (strong, nonatomic) id object;

@end

@implementation DisplaySectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.displayDelegate = self;
    self.inset           = UIEdgeInsetsMake(0, 0, 30, 0);
  }
  return self;
}

- (NSInteger)numberOfItems {

  return 4;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
  return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  LabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:LabelCell.class forSectionController:self atIndex:index];
  cell.label.text = kStringFormat(@"Section %li, cell %li", self.section, index);
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

- (void)listAdapter:(IGListAdapter *)listAdapter willDisplaySectionController:(IGListSectionController *)sectionController {
  NSLog(@"Will display section %li", self.section);
}

- (void)listAdapter:(IGListAdapter *)listAdapter didEndDisplayingSectionController:(IGListSectionController *)sectionController {
  NSLog(@"Did end displaying section %li", self.section);
}

- (void)listAdapter:(IGListAdapter *)listAdapter willDisplaySectionController:(IGListSectionController *)sectionController cell:(UICollectionViewCell *)cell atIndex:(NSInteger)index {
  NSLog(@"Did will display cell %li in section %li", index, self.section);
}

- (void)listAdapter:(IGListAdapter *)listAdapter didEndDisplayingSectionController:(IGListSectionController *)sectionController cell:(UICollectionViewCell *)cell atIndex:(NSInteger)index {
  NSLog(@"Did end displaying cell %li in section %li", index, self.section);
}


@end
