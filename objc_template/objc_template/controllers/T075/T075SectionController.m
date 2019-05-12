//
//  T075SectionController.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.

#import "T075SectionController.h"
#import "T075TopModel.h"

@interface T075SectionController ()

@property (strong, nonatomic) T075TopModel *object;

@end

@implementation T075SectionController

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
  NSLog(@"%s", __func__);
}

@end
