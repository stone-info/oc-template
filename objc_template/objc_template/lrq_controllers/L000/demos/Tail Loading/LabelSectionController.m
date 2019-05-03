//
//  LabelSectionController.m
//  IGListKitTest
//
//  Created by stone on 2019/5/2.
//  Copyright © 2019 stone. All rights reserved.
//

#import "LabelSectionController.h"
#import "LabelCell.h"
#import "DemoModel.h"

@interface LabelSectionController ()

@property (copy, nonatomic) NSString *object;

@end

@implementation LabelSectionController

- (CGSize)sizeForItemAtIndex:(NSInteger)index {

  return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {

  LabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:LabelCell.class forSectionController:self atIndex:index];

  cell.label.text = self.object;

  return cell;
}

- (void)didUpdateToObject:(id)object {

  if ([object isKindOfClass:[DemoModel class]]) {
    self.object = [object title];
  } else {
    self.object = object;
  }
}

@end
