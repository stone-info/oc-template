//
//  T077ViewController.m
//  objc_template
//
//  Created by stone on 2019-05-13.
//  Copyright © 2019 stone. All rights reserved.
//
#import "T077ViewController.h"
#import "T077TopModel.h"
#import <IGListKit/IGListKit.h>
#import "T077DataModel.h"
#import "T077SectionController.h"

@interface T077ViewController () <IGListAdapterDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) IGListAdapter    *adapter;
@property (strong, nonatomic) NSMutableArray   *data;
@property (strong, nonatomic) UILabel          *emptyLabel;
@end

@implementation T077ViewController

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

- (NSMutableArray *)data {

  if (_data == nil) {
    _data = [NSMutableArray array];
    [_data addObject:[T077TopModel modelWithIdentifier:@"0" dataList:@[]]];
    [_data addObject:[T077TopModel modelWithIdentifier:@"1" dataList:@[]]];
    [_data addObject:[T077TopModel modelWithIdentifier:@"2" dataList:@[]]];
    [_data addObject:[T077TopModel modelWithIdentifier:@"3" dataList:@[]]];
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

  //  在 iOS 10 中, 引入了一种新的细胞预取 API.在 Instagam, 启用此功能会显著降低滚动性能。
  if ([self.collectionView respondsToSelector:@selector(setPrefetchingEnabled:)]) { [self.collectionView setPrefetchingEnabled:NO]; }

  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0));
  }];
  self.adapter.collectionView = self.collectionView;

  self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(rightBarButtonItem:)];
}

- (void)rightBarButtonItem:(UIBarButtonItem *)sender {

  T077TopModel *top1 = [self.data[0] copy];
  top1.dataList = @[
    [T077DataModel modelWithIdentifier:@"0"],
    [T077DataModel modelWithIdentifier:@"1"],
    [T077DataModel modelWithIdentifier:@"2"],
    [T077DataModel modelWithIdentifier:@"3"],
  ];
  T077TopModel *top2 = [self.data[1] copy];
  top2.dataList = @[
    [T077DataModel modelWithIdentifier:@"0"],
    [T077DataModel modelWithIdentifier:@"1"],
    [T077DataModel modelWithIdentifier:@"2"],
    [T077DataModel modelWithIdentifier:@"3"],
  ];
  T077TopModel *top3 = [self.data[2] copy];
  top3.dataList = @[
    [T077DataModel modelWithIdentifier:@"0"],
    [T077DataModel modelWithIdentifier:@"1"],
    [T077DataModel modelWithIdentifier:@"2"],
    [T077DataModel modelWithIdentifier:@"3"],
  ];
  // T077TopModel *top4 = [self.data[3] copy];
  // top4.dataList = @[
  //   [T077DataModel modelWithIdentifier:@"0"],
  //   [T077DataModel modelWithIdentifier:@"1"],
  //   [T077DataModel modelWithIdentifier:@"2"],
  //   [T077DataModel modelWithIdentifier:@"3"],
  // ];

  self.data[0] = top1;
  self.data[1] = top2;
  self.data[2] = top3;
  // self.data[3] = top4;

  [self.adapter performUpdatesAnimated:YES completion:nil];

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

  return T077SectionController.new;
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return self.emptyLabel;
}

@end
