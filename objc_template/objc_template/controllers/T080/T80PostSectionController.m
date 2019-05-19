//
//  T80PostSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-18.
//  Copyright © 2019 stone. All rights reserved.
//


#import "T80PostSectionController.h"
#import "T80PostTopModel.h"
#import "T80Comment.h"
#import "T80ImageViewModel.h"
#import "T80UserViewModel.h"
#import "T80ActionViewModel.h"
#import "T80ActionCell.h"

@interface T80PostSectionController () <IGListBindingSectionControllerDataSource, IGListBindingSectionControllerSelectionDelegate, T80ActionCellDelegate>

@property (assign, nonatomic) NSInteger localLikes;
@property (copy, nonatomic) NSString    *comment;

@end

@implementation T80PostSectionController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset             = UIEdgeInsetsMake(0, 0, 0, 0);
    self.dataSource        = self;
    self.selectionDelegate = self;
    self.localLikes        = -1;
  }
  return self;
}

#pragma mark - <IGListBindingSectionControllerDataSource>

- (NSArray<id <IGListDiffable>> *)sectionController:(IGListBindingSectionController *)sectionController viewModelsForObject:(T80PostTopModel *)object {

  // SLog(@"%s", __func__);

  NSArray *result = @[
    [T80UserViewModel.alloc initWithUsername:object.username timestamp:object.timestamp],
    [T80ImageViewModel.alloc initWithUrl:object.imageURL],
    [T80ActionViewModel.alloc initWithLikes:self.localLikes == -1 ? object.likes : self.localLikes]
  ];

  // object.comments = @[
  //   [T80Comment.alloc initWithUsername:@"ryan" text:sn.randomString],
  //   [T80Comment.alloc initWithUsername:@"jsq" text:sn.randomString],
  //   [T80Comment.alloc initWithUsername:@"caitlin" text:sn.randomString],
  // ];



  return [result arrayByAddingObjectsFromArray:[object.comments map:^id(T80Comment *obj, NSUInteger idx) {
    T80Comment *comment = obj.copy;
    comment.text = sn.randomString;
    return comment;
  }]];
}

- (CGSize)sectionController:(IGListBindingSectionController *)sectionController sizeForViewModel:(id)viewModel atIndex:(NSInteger)index {

  // WLog(@"%s", __func__);

  CGFloat width = self.collectionContext.containerSize.width;

  CGFloat height = 55; // user 高度 , action 高度

  if ([viewModel isKindOfClass:[T80ImageViewModel class]]) { height = 250; }

  if ([viewModel isKindOfClass:[T80Comment class]]) { height = 35; };

  return CGSizeMake(width, height);
}

- (UICollectionViewCell <IGListBindable> *)sectionController:(IGListBindingSectionController *)sectionController cellForViewModel:(id)viewModel atIndex:(NSInteger)index {

  // ILog(@"%s", __func__);

  NSString *identifier = @"action";

  if ([viewModel isKindOfClass:[T80ImageViewModel class]]) { identifier = @"image"; }

  if ([viewModel isKindOfClass:[T80Comment class]]) { identifier = @"comment"; }

  if ([viewModel isKindOfClass:[T80UserViewModel class]]) { identifier = @"user"; }

  UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellFromStoryboardWithIdentifier:identifier forSectionController:self atIndex:index];

  BOOL flag = [cell isKindOfClass:[T80ActionCell class]];

  if (flag) {

    T80ActionCell *actionCell = (T80ActionCell *) cell;

    actionCell.delegate = self;

    cell = actionCell;
  }

  return cell;
}

#pragma mark - <IGListBindingSectionControllerSelectionDelegate>

- (void)sectionController:(IGListBindingSectionController *)sectionController didSelectItemAtIndex:(NSInteger)index viewModel:(id)viewModel {
  ILog(@"%s", __func__);

  if ([viewModel isKindOfClass:[T80ActionViewModel class]]) {

    T80PostTopModel *post = (T80PostTopModel *) self.object;

    T80ActionViewModel *actionViewModel = (T80ActionViewModel *) viewModel;

    self.localLikes = (self.localLikes == -1 ? post.likes : self.localLikes) + 1;

    [self updateAnimated:YES completion:nil];
  }

  self.comment = sn.randomString;
}

- (void)didTapHeart:(T80ActionCell *)cell {

  T80PostTopModel *post = (T80PostTopModel *) self.object;

  self.localLikes = (self.localLikes == -1 ? post.likes : self.localLikes) + 1;

  [self updateAnimated:YES completion:nil];
}


@end
