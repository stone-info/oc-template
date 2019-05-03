//
//  EmbeddedSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.

#import "EmbeddedSectionController.h"
#import "CenterLabelCell.h"

@interface EmbeddedSectionController ()

@property (strong, nonatomic) NSNumber *object;

@end

@implementation EmbeddedSectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset = UIEdgeInsetsMake(0, 0, 0, 10);
  }
  return self;
}

- (NSInteger)numberOfItems {

  return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {

  CGFloat height = self.collectionContext.containerSize.height;

  return CGSizeMake(height, height);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  CenterLabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:CenterLabelCell.class forSectionController:self atIndex:index];

  cell.label.text = kStringFormat(@"%li", self.object.integerValue + 1);

  cell.contentView.backgroundColor = [UIColor colorWithRed:237 / 255.0 green:73 / 255.0 blue:86 / 255.0 alpha:1.0];

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

@end



