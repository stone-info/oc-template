//
// Created by Maskkkk on 2019-05-06.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "ChapterSectionController.h"
#import "ChapterCollectionViewCell.h"

@implementation ChapterViewModel

- (nonnull id <NSObject>)diffIdentifier {
  return @(self.chapterNo);
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)object { 
  if (self == object) return YES;
  ChapterViewModel *chapter = (ChapterViewModel *)object;
  if (self.chapterNo == chapter.chapterNo &&
      [self.chapterName isEqualToString:chapter.chapterName]) {
    return YES;
  }
  return NO;
}

- (instancetype)initWithNo:(NSInteger)no name:(NSString *)name  {
  self = [super init];
  if (self) {
    _chapterName = name;
    _chapterNo = no;
  }
  return self;
}

- (NSString *)description {
  NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
  [description appendFormat:@"self.chapterName=%p", self.chapterName];
  [description appendFormat:@", self.chapterNo=%li", self.chapterNo];
  [description appendString:@">"];
  return description;
}


@end
//<IGListBindingSectionControllerDataSource>
@interface ChapterSectionController ()
@property (nonatomic, strong) ChapterViewModel *object;
@end

@implementation ChapterSectionController {}

- (instancetype)init {
  self = [super init];
  if (self) {
    // self.dataSource = self;
  }
  return self;
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  __kindof ChapterCollectionViewCell *cell = [self.collectionContext dequeueReusableCellOfClass:ChapterCollectionViewCell.class forSectionController:self atIndex:index];
  ChapterViewModel *chapterViewModel = (ChapterViewModel *)self.object;
  [cell.chapterLabel setText:kStringFormat(@"%zd: %@", chapterViewModel.chapterNo, chapterViewModel.chapterName)];
  return cell;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
  return CGSizeMake(kScreenWidth, 44);
}

- (void)didUpdateToObject:(id)object {
  self.object = object;
}

@end
