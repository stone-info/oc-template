//
//  T081UserSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-19.
//  Copyright © 2019 stone. All rights reserved.
//


#import "T081UserSectionController.h"
#import "T081TopBindModel.h"
#import "SNUserCell.h"
//================================================================================================
#import <IGListKit/IGListBindable.h>

@interface T081UserSectionControllerIGListBindingCell : UICollectionViewCell <IGListBindable>

@end

@implementation T081UserSectionControllerIGListBindingCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

  }
  return self;
}

- (void)bindViewModel:(id)viewModel {

}

@end
//================================================================================================

@interface T081UserSectionController () <IGListBindingSectionControllerDataSource, IGListBindingSectionControllerSelectionDelegate, IGListWorkingRangeDelegate>

@end

@implementation T081UserSectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset                = UIEdgeInsetsMake(0, 20, 0, 20);
    self.dataSource           = self;
    self.selectionDelegate    = self;
    self.workingRangeDelegate = self;
    // self.supplementaryViewSource = self;
  }
  return self;
}

#pragma mark - <IGListBindingSectionControllerDataSource>

- (NSArray<id <IGListDiffable>> *)sectionController:(IGListBindingSectionController *)sectionController viewModelsForObject:(T081TopBindModel *)object {

  return [object dataList];
}

- (UICollectionViewCell <IGListBindable> *)sectionController:(IGListBindingSectionController *)sectionController cellForViewModel:(id)viewModel atIndex:(NSInteger)index {
  SNUserCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"SNUserCell" bundle:nil forSectionController:self atIndex:index];
  cell.contentView.backgroundColor = sn.randomColor;
  return cell;
}

- (CGSize)sectionController:(IGListBindingSectionController *)sectionController sizeForViewModel:(id)viewModel atIndex:(NSInteger)index {

  NSUInteger col = 1;
  CGFloat width  = (self.collectionContext.containerSize.width - self.inset.left - self.inset.right - (col - 1) * self.minimumInteritemSpacing) / col;

  // NSUInteger row = (NSUInteger) ceil(self.viewModels.count / col);
  // CGFloat height = (self.collectionContext.containerSize.height - self.inset.top - self.inset.bottom - (row - 1) * self.minimumLineSpacing) / row;

  // SNUserCell.cellHeight
  return CGSizeMake(width, SNUserCell.cellHeight);
}

#pragma mark - <IGListBindingSectionControllerSelectionDelegate>

- (void)sectionController:(IGListBindingSectionController *)sectionController didSelectItemAtIndex:(NSInteger)index viewModel:(id)viewModel {
  NSLog(@"%s", __func__);
}


#pragma mark - <IGListWorkingRangeDelegate>

- (void)listAdapter:(IGListAdapter *)listAdapter sectionControllerWillEnterWorkingRange:(IGListSectionController *)sectionController {

}

- (void)listAdapter:(IGListAdapter *)listAdapter sectionControllerDidExitWorkingRange:(IGListSectionController *)sectionController {

}

@end
