//
//  T072SectionController.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.

#import "T072SectionController.h"
#import "T072UserCell.h"
#import "T072TopModel.h"
#import "T072UserModel.h"
#import "UserHeaderView.h"
#import "UserFooterView.h"

@interface T072SectionController () <IGListBindingSectionControllerDataSource, IGListBindingSectionControllerSelectionDelegate, IGListSupplementaryViewSource>

@end

@implementation T072SectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.dataSource              = self;
    self.selectionDelegate       = self;
    self.supplementaryViewSource = self;
  }
  return self;
}

#pragma mark - <IGListBindingSectionControllerDataSource>

- (NSArray<id <IGListDiffable>> *)sectionController:(IGListBindingSectionController *)sectionController viewModelsForObject:(T072TopModel *)object {
  return object.dataList;
}

- (UICollectionViewCell <IGListBindable> *)sectionController:(IGListBindingSectionController *)sectionController cellForViewModel:(id)viewModel atIndex:(NSInteger)index {

  NSLog(@"self.viewModels = %@", self.viewModels);

  T072UserCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"T072UserCell" bundle:nil forSectionController:self atIndex:index];

  return cell;
}

- (CGSize)sectionController:(IGListBindingSectionController *)sectionController sizeForViewModel:(id)viewModel atIndex:(NSInteger)index {
  return CGSizeMake(self.collectionContext.containerSize.width, 10 + 20 * 7 + 10 * 7);
}

#pragma mark - <IGListBindingSectionControllerSelectionDelegate>

- (void)sectionController:(IGListBindingSectionController *)sectionController didSelectItemAtIndex:(NSInteger)index viewModel:(id)viewModel {
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

  view.nameLabel.text   = @"hello name label 111";
  view.handleLabel.text = @"hello handle label 111";
  return view;
}

- (__kindof UICollectionReusableView *)userFooterViewAtIndex:(NSInteger)index {
  UserFooterView *view = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter forSectionController:self nibName:@"UserFooterView" bundle:nil atIndex:index];
  view.commentsCountLabel.text = @"hello comment label 111";

  return view;
}


@end
