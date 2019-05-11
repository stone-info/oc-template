//
//  PrefixedLabelSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.

#import "PrefixedLabelSectionController.h"
#import "LabelsItem.h"
#import "LabelCell.h"
#import "UserHeaderView.h"

@interface PrefixedLabelSectionController () <IGListSupplementaryViewSource>

@property (strong, nonatomic) LabelsItem *object;


@end

@implementation PrefixedLabelSectionController

- (instancetype)initWithPrefix:(NSString *)prefix group:(NSNumber *)group {
  self = [super init];
  if (self) {
    self.prefix                  = prefix;
    self.group                   = group;
    self.minimumInteritemSpacing = 1;
    self.minimumLineSpacing      = 1;
    self.supplementaryViewSource = self;
  }
  return self;
}

- (NSInteger)numberOfItems {

  return _group.integerValue == 1 ? _object.labels1.count : _object.labels2.count;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
  return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  LabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:LabelCell.class forSectionController:self atIndex:index];

  if (_object) {
    if (_group.integerValue == 1) {
      cell.label.text = kStringFormat(@"%@ %@", _prefix, _object.labels1[index]);
    } else {
      cell.label.text = kStringFormat(@"%@ %@", _prefix, _object.labels2[index]);
    }
  } else {
    cell.label.text = kStringFormat(@"%@ [X]", _prefix);
  }

  cell.backgroundColor = _object.color;

  return cell;
}

- (void)didUpdateToObject:(id)object {
  NSParameterAssert([object isKindOfClass:[LabelsItem class]]);
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
  return YES;
}

- (void)moveObjectFromIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex {
  // NSLog(@"%s", __func__);

  if (_group.integerValue == 1) {
    NSString *string = _object.labels1[sourceIndex];

    NSMutableArray *arrM = _object.labels1.mutableCopy;

    [arrM removeObjectAtIndex:sourceIndex];

    [arrM insertObject:string atIndex:destinationIndex];

    _object.labels1 = arrM.copy;

  } else {
    NSString *string = _object.labels2[sourceIndex];

    NSMutableArray *arrM = _object.labels2.mutableCopy;

    [arrM removeObjectAtIndex:sourceIndex];

    [arrM insertObject:string atIndex:destinationIndex];

    _object.labels2 = arrM.copy;
  }
}

#pragma mark - <IGListSupplementaryViewSource>

- (NSArray<NSString *> *)supportedElementKinds {
  return @[UICollectionElementKindSectionHeader];
}

- (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind atIndex:(NSInteger)index {

  UserHeaderView *view = [self.collectionContext dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader forSectionController:self nibName:@"UserHeaderView" bundle:nil atIndex:index];

  view.nameLabel.text   = @"Sections of Letters & Numbers";
  view.handleLabel.text = @"";

  return view;
}

- (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind atIndex:(NSInteger)index {
  CGSize result = CGSizeMake(self.collectionContext.containerSize.width, 40);

  return result;
}


@end
