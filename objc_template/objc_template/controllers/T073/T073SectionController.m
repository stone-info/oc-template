//
//  T073SectionController.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.

#import "T073SectionController.h"
#import "T073TopModel.h"
#import "T072UserCell.h"

@interface T073SectionController ()

@property (strong, nonatomic) T073TopModel *object;

@end

@implementation T073SectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
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


@end
