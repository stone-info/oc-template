//
//  T073SectionController.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.

#import "T073SectionController.h"
#import "T073TopModel.h"
#import "T072UserCell.h"
#import "UserHeaderView.h"
#import "UserFooterView.h"

@interface T073SectionController () <IGListSupplementaryViewSource>

@property (strong, nonatomic) T073TopModel *object;

@end

@implementation T073SectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset                   = UIEdgeInsetsMake(0, 0, 0, 0);
    self.supplementaryViewSource = self;
  }
  return self;
}

- (NSInteger)numberOfItems {

  return self.object.dataList.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
  return CGSizeMake(self.collectionContext.containerSize.width, 10 + 20 * 7 + 10 * 7);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  T072UserCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"T072UserCell" bundle:nil forSectionController:self atIndex:index];
  return cell;
}

- (void)didUpdateToObject:(id)object {
  self.object = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
  NSLog(@"%s", __func__);
}

#pragma mark - <IGListSupplementaryViewSource>

- (NSArray<NSString *> *)supportedElementKinds {
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

  view.nameLabel.text   = @"hello name label";
  view.handleLabel.text = @"hello handle label";
  return view;
}

- (__kindof UICollectionReusableView *)userFooterViewAtIndex:(NSInteger)index {
  UserFooterView *view = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter forSectionController:self nibName:@"UserFooterView" bundle:nil atIndex:index];
  view.commentsCountLabel.text = @"hello comment label";

  return view;
}


@end

