//
//  T071SectionViewController.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.

#import "T071SectionViewController.h"
#import "T071TopModel.h"
#import "SNUserModel.h"
#import "T071UserCell.h"

@interface T071SectionViewController ()

@property (strong, nonatomic) T071TopModel *object;

@end

@implementation T071SectionViewController

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

  // SNUserModel *model = self.object.dataList[index];

  return CGSizeMake(self.collectionContext.containerSize.width, 10 + 20 * 7 + 10 * 7);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  // T071UserCell *cell = [self.collectionContext dequeueReusableCellOfClass:T071UserCell.class forSectionController:self atIndex:index];
  T071UserCell *cell = [self.collectionContext dequeueReusableCellWithNibName:@"T071UserCell" bundle:nil forSectionController:self atIndex:index];
  SNUserModel *model = self.object.dataList[index];
  cell.model = model;

  // cell.contentView.backgroundColor = sn.randomColor;

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


@end
