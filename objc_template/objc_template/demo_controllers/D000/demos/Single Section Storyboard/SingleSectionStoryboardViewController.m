//
//  SingleSectionStoryboardViewController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//
#import "SingleSectionStoryboardViewController.h"
#import "StoryboardCell.h"
#import <IGListKit/IGListKit.h>

@interface SingleSectionStoryboardViewController () <IGListAdapterDataSource, IGListSingleSectionControllerDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IGListAdapter             *adapter;
@property (strong, nonatomic) NSArray                   *data;
@property (strong, nonatomic) UILabel                   *emptyLabel;
@end

@implementation SingleSectionStoryboardViewController

- (UILabel *)emptyLabel {

  if (_emptyLabel == nil) {
    _emptyLabel = [UILabel new];
    _emptyLabel.numberOfLines   = 0;
    _emptyLabel.textAlignment   = NSTextAlignmentCenter;
    _emptyLabel.text            = @"No more data!";
    _emptyLabel.backgroundColor = UIColor.clearColor;
  }
  return _emptyLabel;
}

- (NSArray *)data {

  if (_data == nil) {
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSInteger i     = 0; i < 20; ++i) {
      [arrM addObject:@(i)];
    }
    _data = arrM.copy;
  }
  return _data;
}

- (IGListAdapter *)adapter {

  if (_adapter == nil) {
    _adapter = [[IGListAdapter alloc] initWithUpdater:IGListAdapterUpdater.new viewController:self];
    _adapter.dataSource = self;
  }
  return _adapter;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor   = UIColor.whiteColor;
  self.adapter.collectionView = self.collectionView;
}

// - (void)viewDidLayoutSubviews {
//   [super viewDidLayoutSubviews];
//
//   CGFloat y      = kStatusBarHeight + kNavigationBarHeight;
//   CGFloat height = kScreenHeight - y - kSafeAreaBottomHeight;
//   self.collectionView.frame = CGRectMake(0, y, kScreenWidth, height);
// }

#pragma mark - <IGListAdapterDataSource>

// 返回遵守IGListDiffable协议的 对象数组, @(1) number类型和 字符串 好像默认遵守了该协议, 待研究
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
  NSLog(@"self.data = %@", self.data);
  return self.data;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  IGListSingleSectionController *sectionController = [IGListSingleSectionController.alloc

    initWithStoryboardCellIdentifier:@"cell"

    configureBlock:^(NSNumber *item, StoryboardCell *cell) {
      cell.textLabel.text = kStringFormat(@"Cell: %li", item.integerValue + 1);
    }
    sizeBlock:^CGSize(id item, id <IGListCollectionContext> collectionContext) {
      return CGSizeMake(collectionContext.containerSize.width, 55);
    }];

  sectionController.selectionDelegate = self;

  return sectionController;
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return self.emptyLabel;
}

- (void)didSelectSectionController:(IGListSingleSectionController *)sectionController withObject:(id)object {

  NSInteger section = [self.adapter sectionForSectionController:sectionController];

  NSString *title = kStringFormat(@"Section %li was selected 🎉", section);
  NSString *msg   = kStringFormat(@"Cell Object: %@", object);

  // NSString *string = @"🎉";
  // range Of Composed Character Sequences For Range 组合字符序列的量程范围
  // NSRange  range   = [string rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 1)];
  // NSString *result = [string substringWithRange:range];

  kAlert(title, msg);

}


@end

