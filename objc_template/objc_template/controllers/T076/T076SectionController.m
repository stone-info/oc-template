//
//  T076SectionController.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.

#import "T076SectionController.h"
#import "T076TopModel.h"

//================================================================================================
#import "T076DataModel.h"
#import <IGListKit/IGListBindable.h>

@interface T076Cell : UICollectionViewCell <IGListBindable>
@property (weak, nonatomic) UILabel *nameLabel;
@property (weak, nonatomic) UILabel *ageLabel;
@end

@implementation T076Cell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    UILabel *nameLabel = makeLabel(YES);
    UILabel *ageLabel  = makeLabel(YES);
    _nameLabel         = nameLabel;
    _ageLabel          = ageLabel;

    [self.contentView addSubview:nameLabel];
    [self.contentView addSubview:ageLabel];

    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.offset(10);
      make.left.offset(10);
      make.right.offset(-10);
      make.height.mas_greaterThanOrEqualTo(50);
    }];

    [ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(nameLabel.mas_bottom).offset(10);
      make.left.offset(10);
      make.right.offset(-10);
      make.height.mas_greaterThanOrEqualTo(50);
    }];
  }
  return self;
}

- (void)bindViewModel:(T076DataModel *)viewModel {
  _nameLabel.text = viewModel.name;
  _ageLabel.text  = kStringFormat(@"%li", viewModel.age);
}

@end
//================================================================================================

@interface T076SectionController () <IGListBindingSectionControllerDataSource, IGListBindingSectionControllerSelectionDelegate>

@end

@implementation T076SectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset             = UIEdgeInsetsMake(0, 0, 0, 0);
    self.dataSource        = self;
    self.selectionDelegate = self;
    // self.supplementaryViewSource = self;
  }
  return self;
}

#pragma mark - <IGListBindingSectionControllerDataSource>

- (NSArray<id <IGListDiffable>> *)sectionController:(IGListBindingSectionController *)sectionController viewModelsForObject:(T076TopModel *)object {

  return object.dataList;
}

- (UICollectionViewCell <IGListBindable> *)sectionController:(IGListBindingSectionController *)sectionController cellForViewModel:(id)viewModel atIndex:(NSInteger)index {
  __kindof UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:T076Cell.class forSectionController:self atIndex:index];
  cell.contentView.backgroundColor = sn.randomColor;
  return cell;
}

- (CGSize)sectionController:(IGListBindingSectionController *)sectionController sizeForViewModel:(id)viewModel atIndex:(NSInteger)index {

  NSLog(@"self.object = %@", self.object);
  NSLog(@"self.viewModels = %@", self.viewModels);

  return CGSizeMake(self.collectionContext.containerSize.width, 10 + 50 + 10 + 50 + 10);
}

#pragma mark - <IGListBindingSectionControllerSelectionDelegate>

- (void)sectionController:(IGListBindingSectionController *)sectionController didSelectItemAtIndex:(NSInteger)index viewModel:(id)viewModel {
  NSLog(@"%s", __func__);
}

// - (void)sectionController:(IGListBindingSectionController *)sectionController didDeselectItemAtIndex:(NSInteger)index viewModel:(id)viewModel {
//
// }
//
// - (void)sectionController:(IGListBindingSectionController *)sectionController didHighlightItemAtIndex:(NSInteger)index viewModel:(id)viewModel {
//
// }
//
// - (void)sectionController:(IGListBindingSectionController *)sectionController didUnhighlightItemAtIndex:(NSInteger)index viewModel:(id)viewModel {
//
// }
//
// - (NSArray<NSString *> *)supportedElementKinds {
//   return @[UICollectionElementKindSectionHeader, UICollectionElementKindSectionFooter];
// }
//
// - (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
//
//   if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
//
//     return [self userHeaderViewAtIndex:index];
//   }
//
//   if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
//
//     return [self userFooterViewAtIndex:index];
//   }
//
//   return nil;
// }
//
// - (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
//   return CGSizeMake(self.collectionContext.containerSize.width, 40);
// }
//
// - (__kindof UICollectionReusableView *)userHeaderViewAtIndex:(NSInteger)index {
//
//   UserHeaderView *view = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader forSectionController:self nibName:@"UserHeaderView" bundle:nil atIndex:index];
//
//   view.nameLabel.text   = @"hello name label";
//   view.handleLabel.text = @"hello handle label";
//   return view;
// }
//
// - (__kindof UICollectionReusableView *)userFooterViewAtIndex:(NSInteger)index {
//   UserFooterView *view = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter forSectionController:self nibName:@"UserFooterView" bundle:nil atIndex:index];
//   view.commentsCountLabel.text = @"hello comment label";
//
//   return view;
// }

@end

