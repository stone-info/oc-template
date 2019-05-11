//
//  NestedAdapterViewController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//
#import "NestedAdapterViewController.h"
#import "LabelSectionController.h"
#import "HorizontalSectionController.h"
#import <IGListKit/IGListKit.h>

@interface NestedAdapterViewController () <IGListAdapterDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) IGListAdapter    *adapter;
@property (strong, nonatomic) NSArray          *data;

@end

@implementation NestedAdapterViewController

- (NSArray *)data {

  if (_data == nil) {
    _data = @[
      @"Ridiculus Elit Tellus Purus Aenean",
      @"Condimentum Sollicitudin Adipiscing",
      @14,
      @"Ligula Ipsum Tristique Parturient Euismod",
      @"Purus Dapibus Vulputate",
      @6,
      @"Tellus Nibh Ipsum Inceptos",
      @2
    ];
  }
  return _data;
}

- (UICollectionView *)collectionView {

  if (_collectionView == nil) {
    UICollectionViewFlowLayout *flowLayout = UICollectionViewFlowLayout.new;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = UIColor.whiteColor;
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

  return self.data;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  if ([object isKindOfClass:NSNumber.class]) {
    return HorizontalSectionController.new;
  } else {
    return LabelSectionController.new;
  }
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  UILabel *label = UILabel.new;
  label.text = @"没有数据...";
  return label;
}

@end
