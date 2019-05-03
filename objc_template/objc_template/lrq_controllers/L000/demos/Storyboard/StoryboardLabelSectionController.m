//
//  StoryboardLabelSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.

#import "StoryboardLabelSectionController.h"
#import "PersonOC.h"
#import "StoryboardCell.h"

@interface StoryboardLabelSectionController ()

@property (strong, nonatomic) PersonOC *object;


@end

@implementation StoryboardLabelSectionController

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
  return CGSizeMake(self.object.name.length * 7, self.object.name.length * 7);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  StoryboardCell *cell = [self.collectionContext dequeueReusableCellFromStoryboardWithIdentifier:@"cell" forSectionController:self atIndex:index];
  cell.textLabel.text = self.object.name;
  return cell;
}

- (void)didUpdateToObject:(id)object {
  self.object = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
  // NSLog(@"%s", __func__);
  if ([self.delegate respondsToSelector:@selector(removeSectionControllerWantsRemoved:)]) {
    [self.delegate removeSectionControllerWantsRemoved:self];
  }
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