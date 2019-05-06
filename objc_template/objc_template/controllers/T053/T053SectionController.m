//
//  T053SectionController.m
//  objc_template
//
//  Created by stone on 2019-05-05.
//  Copyright © 2019 stone. All rights reserved.

#import "T053SectionController.h"
#import "LabelCell.h"
#import "T053ColorDiffModel.h"

@interface T053SectionController ()

@property (strong, nonatomic) T053ColorDiffModel *object;

@end

@implementation T053SectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
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
  LabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:LabelCell.class forSectionController:self atIndex:index];
  cell.contentView.backgroundColor = self.object.color;
  cell.label.text                  = kStringFormat(@"%li", self.object.index);
  cell.label.textColor             = UIColor.whiteColor;
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

@end


// [IGListSingleSectionController.alloc
//
//     initWithCellClass:LabelCell.class
//
//     configureBlock:^(T053ColorDiffModel *item, LabelCell *cell) {
//       cell.contentView.backgroundColor = item.color;
//       cell.label.text                  = kStringFormat(@"%li", item.index);
//
//     }
//     sizeBlock:^CGSize(id item, id <IGListCollectionContext> collectionContext) {
//       if (collectionContext) {
//         // 横向滚动的时候用
//         // return CGSizeMake(collectionContext.containerSize.width, collectionContext.containerSize.height);
//
//         return CGSizeMake(collectionContext.containerSize.width, 55);
//
//       } else {
//         return CGSizeZero;
//       }
//     }];