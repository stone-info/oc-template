//
//  FeedItemSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.

#import "FeedItemSectionController.h"
#import "FeedItem.h"
#import "LabelCell.h"
#import "UserHeaderView.h"
#import "UserFooterView.h"
#import "User.h"

@interface FeedItemSectionController () <IGListSupplementaryViewSource>

@property (strong, nonatomic) FeedItem *feedItem;

@end

@implementation FeedItemSectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset                   = UIEdgeInsetsMake(0, 0, 0, 0);
    self.supplementaryViewSource = self;
  }
  return self;
}

#pragma mark - <IGListSectionController>

- (NSInteger)numberOfItems {

  return self.feedItem.comments.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
  return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  LabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:LabelCell.class forSectionController:self atIndex:index];
  cell.label.text = self.feedItem.comments[index];
  return cell;
}

- (void)didUpdateToObject:(id)object {
  self.feedItem = object;
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

#pragma mark - <IGListSupplementaryViewSource>

- (NSArray<NSString *> *)supportedElementKinds {

  // UIKIT_EXTERN NSString *const UICollectionElementKindSectionHeader NS_AVAILABLE_IOS(6_0);
  // UIKIT_EXTERN NSString *const UICollectionElementKindSectionFooter NS_AVAILABLE_IOS(6_0);

  return @[UICollectionElementKindSectionHeader, UICollectionElementKindSectionFooter];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index {

  if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {

    return [self userHeaderViewAtIndex:index];
  }

  if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {

    return [self userFooterViewAtIndex:index];
  }

  return nil;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
  return CGSizeMake(self.collectionContext.containerSize.width, 40);
}

- (__kindof UICollectionReusableView *)userHeaderViewAtIndex:(NSInteger)index {

  UserHeaderView *view = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader forSectionController:self nibName:@"UserHeaderView" bundle:nil atIndex:index];

  view.nameLabel.text   = self.feedItem.user.name;
  view.handleLabel.text = kStringFormat(@"@%@", self.feedItem.user.handle);
  return view;
}

- (__kindof UICollectionReusableView *)userFooterViewAtIndex:(NSInteger)index {
  UserFooterView *view = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter forSectionController:self nibName:@"UserFooterView" bundle:nil atIndex:index];
  view.commentsCountLabel.text = kStringFormat(@"%lu", self.feedItem.comments.count);

  return view;
}


@end




