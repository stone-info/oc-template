//
//  UserSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.

#import "UserSectionController.h"
#import "User.h"
#import "DetailLabelCell.h"

@interface UserSectionController ()

@property (strong, nonatomic) User *user;

@property (assign, nonatomic, getter=isReorderable) BOOL reorderable;

@end

@implementation UserSectionController

- (instancetype)initWithReorderable:(BOOL)reorderable {
  self = [super init];
  if (self) {
    self.reorderable = reorderable;
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
  DetailLabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:DetailLabelCell.class forSectionController:self atIndex:index];

  cell.titleLabel.text  = self.user.name;
  cell.detailLabel.text = kStringFormat(@"@%@", self.user.handle);
  return cell;
}

- (void)didUpdateToObject:(id)object {
  self.user = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
  NSLog(@"%s", __func__);
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



