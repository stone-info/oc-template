//
//  WorkingRangeSectionController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.

#import "WorkingRangeSectionController.h"
#import "LabelCell.h"
#import "ImageCell.h"

@interface WorkingRangeSectionController () <IGListWorkingRangeDelegate>

@property (assign, nonatomic) NSNumber             *height;
@property (strong, nonatomic) UIImage              *downloadedImage;
@property (copy, nonatomic) NSString               *urlString;
@property (strong, nonatomic) NSURLSessionDataTask *task;

@end

@implementation WorkingRangeSectionController

- (NSString *)urlString {

  if (_urlString == nil) {
    CGFloat width = self.collectionContext.containerSize.width;
    _urlString = kStringFormat(@"https://unsplash.it/%f/%li", width, self.height.integerValue);
  }
  return _urlString;
}

- (void)dealloc {
  NSLog(@"■■■■■■\t%@ is dead ☠☠☠\t■■■■■■", [self class]);

  [self.task cancel];
}

- (instancetype)init {
  self = [super init];
  if (self) {
    self.inset                = UIEdgeInsetsMake(0, 0, 0, 0);
    self.workingRangeDelegate = self;
  }
  return self;
}

- (void)listAdapter:(IGListAdapter *)listAdapter sectionControllerWillEnterWorkingRange:(IGListSectionController *)sectionController {

  NSLog(@"Downloading image %@ for section %li", self.urlString, self.section);

  NSURL                *url  = nil;
  NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

    if (error) {
      NSLog(@"error = %@", error);
    } else {
      UIImage *image = [UIImage imageWithData:data];

      dispatch_async(dispatch_get_main_queue(), ^{
        self.downloadedImage = image;
        ImageCell *cell = [self.collectionContext cellForItemAtIndex:1 sectionController:self];
        cell.image = self.downloadedImage;
      });
    }
  }];

  self.task = task;

  [task resume];

}

- (void)listAdapter:(IGListAdapter *)listAdapter sectionControllerDidExitWorkingRange:(IGListSectionController *)sectionController {

}

- (NSInteger)numberOfItems {

  return 2;
}

- (CGSize)sizeForItemAtIndex:(NSInteger)index {
  CGFloat width  = self.collectionContext.containerSize.width;
  CGFloat height = self.collectionContext.containerSize.height;

  if (index == 0) {
    height = 55;
  } else {
    height = self.height.floatValue;
  }

  return CGSizeMake(width, height);
}

- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
  UICollectionViewCell *rCell;
  if (index == 0) {
    LabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:LabelCell.class forSectionController:self atIndex:index];
    cell.label.text = self.urlString;
    rCell = cell;
  } else {
    ImageCell *cell = [self.collectionContext dequeueReusableCellOfClass:ImageCell.class forSectionController:self atIndex:index];
    cell.image = self.downloadedImage;
    rCell = cell;
  }

  return rCell;
}

- (void)didUpdateToObject:(id)object {
  self.height = object;
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
