//
//  T071ViewController.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.
//
#import "T072ViewController.h"
#import "SNUserApi.h"
#import "SNUserModel.h"
#import "T072SectionController.h"
#import "T072TopModel.h"
#import "T072UserModel.h"
#import <IGListKit/IGListKit.h>

@interface T072ViewController () <IGListAdapterDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) IGListAdapter    *adapter;
@property (strong, nonatomic) NSArray          *data;
@property (strong, nonatomic) UILabel          *emptyLabel;
@end

@implementation T072ViewController

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
    _data = @[
      [T072TopModel.alloc initWithTitle:@"users" height:100 dataList:@[]]
    ];
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

  [self addRequest];
}

- (void)addRequest {
  SNUserApi *api = SNUserApi.new;

  [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest *request) {

    NSMutableArray<T072UserModel *> *users = [T072UserModel mj_objectArrayWithKeyValuesArray:request.responseJSONObject];

    self.data = @[
      [T072TopModel.alloc initWithTitle:@"users" height:100 dataList:users]
    ];

    [self.adapter performUpdatesAnimated:YES completion:nil];

  } failure:^(__kindof YTKBaseRequest *request) {
    NSLog(@"request.error = %@", request.error);
  }];
}

#pragma mark - <IGListAdapterDataSource>

// 返回遵守IGListDiffable协议的 对象数组, @(1) number类型和 字符串 好像默认遵守了该协议, 待研究
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {

  return self.data;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  return T072SectionController.new;
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return self.emptyLabel;
}

@end