//
//  T075ViewController.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.
//
#import "T075ViewController.h"
#import "T075TopModel.h"
#import "T075SectionController.h"
#import <IGListKit/IGListKit.h>

@interface T075ViewController () <IGListAdapterDataSource>
@property (strong, nonatomic) UICollectionView               *collectionView;
@property (strong, nonatomic) IGListAdapter                  *adapter;
@property (strong, nonatomic) NSMutableArray<T075TopModel *> *data;
@property (strong, nonatomic) UILabel                        *emptyLabel;
@end

@implementation T075ViewController

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

- (NSMutableArray<T075TopModel *> *)data {

  if (_data == nil) {
    _data = @[
      [T075TopModel modelWithIdentifier:@"0" dataList:@[]]
    ].mutableCopy;

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

  // BOOL i = [@[
  //   @"江户川柯南",
  //   @"工藤新一",
  //   @"毛利兰",
  //   @"毛利小五郎",
  //   @"阿笠博士",
  //   @"灰原哀",
  //   @"吉田步美",
  //   @"步美的母亲",
  //   @"圆谷光彦",
  //   @"小岛元太",
  //   @"铃木园子",
  //   @"服部平次",
  //   @"远山和叶",
  //   @"世良真纯",
  //   @"冲矢昴",
  //   @"安室透",
  //   @"工藤优作",
  //   @"工藤有希子",
  //   @"怪盗基德"
  // ] isEqualToArray:@[
  //   @"江户川柯南",
  //   @"工藤新一",
  //   @"毛利兰",
  //   @"毛利小五郎",
  //   @"阿笠博士",
  //   @"灰原哀",
  //   @"吉田步美",
  //   @"步美的母亲",
  //   @"圆谷光彦",
  //   @"小岛元太",
  //   @"铃木园子",
  //   @"服部平次",
  //   @"远山和叶",
  //   @"世良真纯",
  //   @"冲矢昴",
  //   @"安室透",
  //   @"工藤优作",
  //   @"工藤有希子",
  //   @"怪盗基德"
  // ].mutableCopy];
  //
  // NSLog(@"i = %@", i ? @"true" : @"false");

  T075TopModel *model = self.data[0].copy;

  model.dataList = @[
    @"江户川柯南",
    @"工藤新一",
    @"毛利兰",
    @"毛利小五郎",
    @"阿笠博士",
    @"灰原哀",
    @"吉田步美",
    @"步美的母亲",
    @"圆谷光彦",
    @"小岛元太",
    @"铃木园子",
    @"服部平次",
    @"远山和叶",
    @"世良真纯",
    @"冲矢昴",
    @"安室透",
    @"工藤优作",
    @"工藤有希子",
    @"怪盗基德"
  ];



  self.data[0] = model;

  [self.adapter performUpdatesAnimated:YES completion:nil];

}

#pragma mark - <IGListAdapterDataSource>

// 返回遵守IGListDiffable协议的 对象数组, @(1) number类型和 字符串 好像默认遵守了该协议, 待研究
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {

  return self.data;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  return T075SectionController.new;
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  // return self.emptyLabel;
  return nil;
}

@end

