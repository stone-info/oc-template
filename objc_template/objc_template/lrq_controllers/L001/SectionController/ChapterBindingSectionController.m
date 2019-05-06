//
// Created by Maskkkk on 2019-05-06.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "ChapterBindingSectionController.h"
#import "ChapterSectionController.h"
#import "ChapterCollectionViewCell.h"

@interface ChapterBindingSectionController () <IGListBindingSectionControllerDataSource>

@end

@implementation ChapterBindingSectionController {}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.dataSource = self;
  }
  return self;
}

- (UICollectionViewCell <IGListBindable> *)sectionController:(IGListBindingSectionController *)sectionController cellForViewModel:(id)viewModel atIndex:(NSInteger)index {
  __kindof ChapterCollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:ChapterCollectionViewCell.class forSectionController:self atIndex:index];
  // ChapterViewModel *chapterViewModel = (ChapterViewModel *)self.object;
  // [cell.chapterLabel setText:kStringFormat(@"%zd: %@", chapterViewModel.chapterNo, chapterViewModel.chapterName)];
  return cell;
}

- (NSArray<id <IGListDiffable>> *)sectionController:(IGListBindingSectionController *)sectionController viewModelsForObject:(id)object {
  ChapterViewModel *viewModel = object;
  NSLog(@"object = %@", object);
  return @[viewModel];
}

- (CGSize)sectionController:(IGListBindingSectionController *)sectionController sizeForViewModel:(id)viewModel atIndex:(NSInteger)index {
  return CGSizeMake(kScreenWidth, 44);
}

@end