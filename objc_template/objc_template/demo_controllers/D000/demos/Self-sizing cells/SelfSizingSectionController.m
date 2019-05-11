//
//  SelfSizingSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.

#import "SelfSizingSectionController.h"
#import "SelectionModel.h"
#import "ManuallySelfSizingCell.h"
#import "FullWidthSelfSizingCell.h"
#import "NibSelfSizingCell.h"

@interface SelfSizingSectionController ()

@property (strong, nonatomic) SelectionModel *model;

@end

@implementation SelfSizingSectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset                   = UIEdgeInsetsMake(0, 0, 40, 0);
    self.minimumLineSpacing      = 4;
    self.minimumInteritemSpacing = 4;
  }
  return self;
}

- (NSInteger)numberOfItems {

  return self.model.options.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
  return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {

  NSString *text = self.model.options[index];

  UICollectionViewCell *cell;


  //   SelectionModelTypeNone = 0,
  //   SelectionModelTypeFullWidth,
  //   SelectionModelTypeNib
  switch (self.model.type) {
    case SelectionModelTypeNone: {
      ManuallySelfSizingCell *manualCell = [self.collectionContext dequeueReusableCellOfClass:ManuallySelfSizingCell.class forSectionController:self atIndex:index];
      manualCell.label.text = text;
      cell = manualCell;
      break;
    }
    case SelectionModelTypeFullWidth: {
      FullWidthSelfSizingCell *manualCell = [self.collectionContext dequeueReusableCellOfClass:FullWidthSelfSizingCell.class forSectionController:self atIndex:index];
      manualCell.label.text = text;
      cell = manualCell;
      break;
    }
    case SelectionModelTypeNib: {
      NibSelfSizingCell *nibCell = [self.collectionContext dequeueReusableCellWithNibName:@"NibSelfSizingCell" bundle:nil forSectionController:self atIndex:index];
      nibCell.contentLabel.text = text;
      cell = nibCell;
      break;
    }
  }
  return cell;
}

- (void)didUpdateToObject:(id)object {
  self.model = object;
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
