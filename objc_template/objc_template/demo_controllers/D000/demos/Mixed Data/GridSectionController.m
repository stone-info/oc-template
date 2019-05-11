//
//  GridSectionController.m
//  objc_template
//
//  Created by stone on 2019/5/3.
//  Copyright © 2019 stone. All rights reserved.
//

#import "GridSectionController.h"
#import "GridItem.h"
#import "CenterLabelCell.h"

@interface GridSectionController ()

@property (strong, nonatomic) GridItem                   *object;
@property (assign, nonatomic, getter=isReorderable) BOOL reorderable;
@end

@implementation GridSectionController

- (instancetype)initWithReorderable:(BOOL)reorderable {
  self = [super init];
  if (self) {
    self.reorderable             = reorderable;
    self.minimumInteritemSpacing = 1;
    self.minimumLineSpacing      = 1;
  }
  return self;
}

- (NSInteger)numberOfItems {

  return self.object.itemCount;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {

  CGFloat width    = self.collectionContext.containerSize.width;
  double  itemSize = floor(width / 4);

  return CGSizeMake(itemSize, itemSize);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  CenterLabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:CenterLabelCell.class forSectionController:self atIndex:index];
  cell.label.text      = self.object.items[index];
  cell.backgroundColor = self.object.color;
  return cell;
}

- (void)didUpdateToObject:(id)object {
  self.object = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
  NSLog(@"%s", __func__);
}

- (void)didDeselectItemAtIndex:(NSInteger)index {
  NSLog(@"%s", __func__);
}

- (void)didHighlightItemAtIndex:(NSInteger)index {
  // NSLog(@"%s", __func__);
}

- (void)didUnhighlightItemAtIndex:(NSInteger)index {
  // NSLog(@"%s", __func__);
}

- (BOOL)canMoveItemAtIndex:(NSInteger)index {
  return self.isReorderable;
}

- (void)moveObjectFromIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex {

  if (!self.object) { return; }

  NSMutableArray *tempArrM = self.object.items.mutableCopy;

  NSString *item = tempArrM[sourceIndex];

  [tempArrM removeObjectAtIndex:sourceIndex];

  [tempArrM insertObject:item atIndex:destinationIndex];

  self.object.items = tempArrM.copy;
}

@end


