//
//  HorizontalSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.

#import "HorizontalSectionController.h"
#import "EmbeddedCollectionViewCell.h"
#import "EmbeddedSectionController.h"

@interface HorizontalSectionController () <IGListAdapterDataSource>

@property (strong, nonatomic) NSNumber *number;

@property (strong, nonatomic) IGListAdapter *adapter;

@end

@implementation HorizontalSectionController

- (IGListAdapter *)adapter {

  if (_adapter == nil) {
    _adapter = [[IGListAdapter alloc] initWithUpdater:IGListAdapterUpdater.new viewController:self.viewController];
    _adapter.dataSource = self;
  }
  return _adapter;
}

- (NSInteger)numberOfItems {

  return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
  return CGSizeMake(self.collectionContext.containerSize.width, 100);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  EmbeddedCollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:EmbeddedCollectionViewCell.class forSectionController:self atIndex:index];
  self.adapter.collectionView = cell.collectionView;
  return cell;
}

- (void)didUpdateToObject:(id)object {
  self.number = object;
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
  NSLog(@"%s", __func__);
}

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {

  if (self.number) {

    NSMutableArray *arrM = [NSMutableArray array];

    for (NSInteger i = 0; i < self.number.integerValue; ++i) {
      [arrM addObject:@(i)];
    }

    return arrM.copy;

  } else {
    return @[];
  }

}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
  return EmbeddedSectionController.new;
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return nil;
}

@end