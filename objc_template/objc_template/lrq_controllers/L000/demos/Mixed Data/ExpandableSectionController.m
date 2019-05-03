//
//  ExpandableSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.

#import "ExpandableSectionController.h"
#import "LabelCell.h"

@interface ExpandableSectionController ()
@property (assign, nonatomic) BOOL     expanded;
@property (strong, nonatomic) NSString *object;

@end

@implementation ExpandableSectionController

- (NSInteger)numberOfItems {

  return 1;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {

  CGFloat width  = self.collectionContext.containerSize.width;
  CGFloat height = self.expanded ? [LabelCell textHeightWithText:self.object width:width]:LabelCell.singleLineHeight;

  return CGSizeMake(width, height);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  LabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:LabelCell.class forSectionController:self atIndex:index];
  // cell.contentView.backgroundColor = sn.randomColor;

  cell.label.text = self.object;

  return cell;
}

- (void)didUpdateToObject:(id)object {
  self.object = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
  NSLog(@"%s", __func__);
  self.expanded = !self.expanded;

  [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.6 options:kNilOptions animations:^{
    [self.collectionContext invalidateLayoutForSectionController:self completion:nil];
  } completion:nil];
}

- (void)didDeselectItemAtIndex:(NSInteger)index {
  NSLog(@"%s", __func__);
}

- (void)didHighlightItemAtIndex:(NSInteger)index {
  NSLog(@"%s", __func__);
}

- (void)didUnhighlightItemAtIndex:(NSInteger)index {
  NSLog(@"%s", __func__);
}

- (BOOL)canMoveItemAtIndex:(NSInteger)index {
  return NO;
}

- (void)moveObjectFromIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex {
  NSLog(@"%s", __func__);
}

@end



