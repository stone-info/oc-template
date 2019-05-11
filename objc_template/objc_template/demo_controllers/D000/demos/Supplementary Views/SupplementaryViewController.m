//
//  SupplementaryViewController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//
#import "SupplementaryViewController.h"
#import "FeedItem.h"
#import "User.h"
#import "FeedItemSectionController.h"
#import <IGListKit/IGListKit.h>

@interface SupplementaryViewController () <IGListAdapterDataSource>
@property (strong, nonatomic) UICollectionView    *collectionView;
@property (strong, nonatomic) IGListAdapter       *adapter;
@property (strong, nonatomic) UILabel             *emptyLabel;
@property (strong, nonatomic) NSArray<FeedItem *> *feedItems;
@end

@implementation SupplementaryViewController

- (NSArray<FeedItem *> *)feedItems {

  if (_feedItems == nil) {
    _feedItems = @[
      [FeedItem.alloc initWithPk:@1 user:[User.alloc initWithPk:@100 name:@"Jesse" handle:@"jesse_squires"] comments:@[@"You rock!", @"Hmm you sure about that?"]],
      [FeedItem.alloc initWithPk:@2 user:[User.alloc initWithPk:@101 name:@"Ryan" handle:@"_ryannystrom"] comments:@[@"lgtm", @"lol", @"Let's try it!"]],
      [FeedItem.alloc initWithPk:@3 user:[User.alloc initWithPk:@102 name:@"Ann" handle:@"abaum"] comments:@[@"Good luck!"]],
      [FeedItem.alloc initWithPk:@4 user:[User.alloc initWithPk:@103 name:@"Phil" handle:@"phil"] comments:@[@"yoooooooo", @"What's the eta?"]]
    ];
  }
  return _feedItems;
}

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


- (UICollectionView *)collectionView {

  if (_collectionView == nil) {
    UICollectionViewFlowLayout *flowLayout = UICollectionViewFlowLayout.new;
    // flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = UIColor.whiteColor;
    // _collectionView.alwaysBounceVertical   = YES;
    // _collectionView.alwaysBounceHorizontal = YES;
    // _collectionView.pagingEnabled          = YES;
  }
  return _collectionView;
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
  self.view.backgroundColor = UIColor.whiteColor;
  // make layout
  [self.view addSubview:self.collectionView];

  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0));
  }];
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

  return self.feedItems;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  return FeedItemSectionController.new;
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return self.emptyLabel;
}

@end
