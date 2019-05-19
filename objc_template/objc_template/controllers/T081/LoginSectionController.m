//
//  LoginSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-19.
//  Copyright © 2019 stone. All rights reserved.

#import "LoginSectionController.h"

@interface LoginSectionController () <IGListWorkingRangeDelegate>

@property (strong, nonatomic) id object;

@end

@implementation LoginSectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset                = UIEdgeInsetsMake(0, 0, 0, 0);
    self.workingRangeDelegate = self;
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
  UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:UICollectionViewCell.class forSectionController:self atIndex:index];
  // T071UserCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"T071UserCell" bundle:nil forSectionController:self atIndex:index];
  cell.contentView.backgroundColor = sn.randomColor;
  return cell;
}

- (void)didUpdateToObject:(id)object {
  // 官方推荐 , 追踪错误宏
  // NSParameterAssert([object isKindOfClass:[LabelsItem class]]);
  self.object = object;
}

- (void)didSelectItemAtIndex:(NSInteger)index {
  // NSLog(@"%s", __func__);
}


#pragma mark - <IGListWorkingRangeDelegate>

- (void)listAdapter:(IGListAdapter *)listAdapter sectionControllerWillEnterWorkingRange:(IGListSectionController *)sectionController {

}

- (void)listAdapter:(IGListAdapter *)listAdapter sectionControllerDidExitWorkingRange:(IGListSectionController *)sectionController {

}

@end
