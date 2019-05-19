//
//  LoginSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-19.
//  Copyright © 2019 stone. All rights reserved.

#import "LoginSectionController.h"
#import "LoginCell.h"

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
  return CGSizeMake(self.collectionContext.containerSize.width, 160);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  LoginCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"LoginCell" bundle:nil forSectionController:self atIndex:index];
  // cell.contentView.backgroundColor = sn.randomColor;
  kBorder(cell.contentView);
  return cell;
}

- (void)didUpdateToObject:(id)object {
  NSLog(@"obj class = %@", SN.getClassName(object));
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

#pragma mark - <测试>

@end
