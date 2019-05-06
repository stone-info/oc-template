//
//  PostSectionControllerOC.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.

#import "PostSectionControllerOC.h"
#import "ImageViewModel.h"
#import "UserViewModel.h"
#import "CommentOC.h"
#import "ActionCellOC.h"
#import "UserViewModel.h"
#import "PostOC.h"
#import "ActionViewModel.h"
#import "SNLib.h"

@interface PostSectionControllerOC () <IGListBindingSectionControllerDataSource, ActionCellOCDelegate>

// @property (strong, nonatomic) NSNumber *localLikes;
@property (assign, nonatomic) NSInteger localLikes;

@end

@implementation PostSectionControllerOC

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset      = UIEdgeInsetsMake(0, 0, 0, 0);
    self.dataSource = self;
    self.localLikes = -1;
  }
  return self;
}

- (NSArray<id <IGListDiffable>> *)sectionController:(IGListBindingSectionController *)sectionController viewModelsForObject:(PostOC *)object {

  NSLog(@"%s", __func__);
  // NSLog(@"object.likes = %li", object.likes);
  // NSLog(@"self.localLikes = %li", self.localLikes);

  NSArray *result = @[
    [UserViewModel.alloc initWithUsername:object.username timestamp:object.timestamp],
    [ImageViewModel.alloc initWithUrl:object.imageURL],
    // [ActionViewModel.alloc initWithLikes:(self.localLikes ? self.localLikes : object.likes)]
    // [ActionViewModel.alloc initWithLikes:self.localLikes == -1 ? object.likes : self.localLikes]
    // [ActionViewModel.alloc initWithLikes:(NSInteger) (arc4random_uniform(255) + 300)]
    [ActionViewModel.alloc initWithLikes:self.localLikes == -1 ? object.likes : self.localLikes]
  ];

  return [result arrayByAddingObjectsFromArray:object.comments];
}

- (UICollectionViewCell <IGListBindable> *)sectionController:(IGListBindingSectionController *)sectionController cellForViewModel:(id)viewModel atIndex:(NSInteger)index {

  NSString *identifier = @"action";
  if ([viewModel isKindOfClass:[ImageViewModel class]]) { identifier = @"image"; }
  if ([viewModel isKindOfClass:[CommentOC class]]) { identifier = @"comment"; }
  if ([viewModel isKindOfClass:[UserViewModel class]]) { identifier = @"user"; }

  UICollectionViewCell *cell = [self.collectionContext dequeueReusableCellFromStoryboardWithIdentifier:identifier forSectionController:self atIndex:index];

  BOOL flag = [cell isKindOfClass:[ActionCellOC class]];
  if (flag) {
    ActionCellOC *actionCell = (ActionCellOC *) cell;
    actionCell.delegate = self;
    cell = actionCell;
  }

  return cell;
}

- (CGSize)sectionController:(IGListBindingSectionController *)sectionController sizeForViewModel:(id)viewModel atIndex:(NSInteger)index {
  CGFloat width  = self.collectionContext.containerSize.width;
  CGFloat height = 55; // user 高度 , action 高度
  if ([viewModel isKindOfClass:[ImageViewModel class]]) { height = 250; }
  if ([viewModel isKindOfClass:[CommentOC class]]) { height = 35; };
  return CGSizeMake(width, height);
}

- (void)didTapHeart:(ActionCellOC *)cell {

  PostOC *post = (PostOC *) self.object;

  WLog(@"post = %li", post.likes);

  // self.localLikes = @((self.localLikes ? self.localLikes : (post.likes ? post.likes : @0)).integerValue + 1);
  self.localLikes = (self.localLikes == -1 ? post.likes : self.localLikes) + 1;

  // NSLog(@"self.localLikes = %li", self.localLikes);
  [self updateAnimated:YES completion:nil];
}


@end
