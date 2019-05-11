//
//  AnnouncingDepsViewController.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//
#import "AnnouncingDepsViewController.h"
#import "IncrementAnnouncer.h"
#import "ListeningSectionController.h"
#import <IGListKit/IGListKit.h>

@interface AnnouncingDepsViewController () <IGListAdapterDataSource>
@property (strong, nonatomic) UICollectionView    *collectionView;
@property (strong, nonatomic) IGListAdapter       *adapter;
@property (strong, nonatomic) NSArray<NSNumber *> *data;
@property (strong, nonatomic) UILabel             *emptyLabel;
@property (strong, nonatomic) IncrementAnnouncer  *announcer;
@end

@implementation AnnouncingDepsViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.announcer = IncrementAnnouncer.new;
  }
  return self;
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

- (NSArray<NSNumber *> *)data {

  /** _data lazy load */

  if (_data == nil) {
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSInteger i     = 0; i < 20; ++i) { [arrM addObject:@(i)]; }
    _data = arrM.copy;
  }
  return _data;
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
    _adapter = [[IGListAdapter alloc] initWithUpdater:IGListAdapterUpdater.new viewController:self workingRangeSize:1];
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

  // disable prefetching so cells are configured as they come on screen
  // 禁用预取，以便在屏幕上显示单元格
  if (@available(iOS 10.0, *)) {
    self.collectionView.prefetchingEnabled = NO;
  }

  self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAdd:)];

}

- (void)onAdd:(UIBarButtonItem *)sender {

  [self.announcer increment];

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

  return self.data;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  return [ListeningSectionController.alloc initWithAnnouncer:self.announcer];
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return self.emptyLabel;
}

@end
