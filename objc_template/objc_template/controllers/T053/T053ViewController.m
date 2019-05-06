//
//  T053ViewController.m
//  objc_template
//
//  Created by stone on 2019-05-05.
//  Copyright © 2019 stone. All rights reserved.
//
#import "T053ViewController.h"
#import "LabelCell.h"
#import "T053CollectionView.h"
#import "T053ColorDiffModel.h"
#import "T053SectionController.h"
#import "T053SpinnerSectionController.h"
#import <IGListKit/IGListKit.h>
#import <MJRefresh/MJRefreshNormalHeader.h>
#import <MJRefresh/MJRefreshBackNormalFooter.h>

#define MJRandomColor [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

static const CGFloat MJDuration = 2.0;

@interface T053ViewController () <IGListAdapterDataSource, UIScrollViewDelegate>
@property (strong, nonatomic) T053CollectionView            *collectionView;
@property (strong, nonatomic) IGListAdapter                 *adapter;
@property (strong, nonatomic) NSArray<T053ColorDiffModel *> *data;
@property (strong, nonatomic) UILabel                       *emptyLabel;
@property (assign, nonatomic, getter=isLoading) BOOL        loading;
@property (copy, nonatomic) NSString                        *spinToken;
@end

@implementation T053ViewController

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

- (NSString *)spinToken {

  if (_spinToken == nil) {
    _spinToken = @"spinner";
  }
  return _spinToken;
}

- (NSArray<T053ColorDiffModel *> *)data {

  if (_data == nil) {

    NSMutableArray *arrM = [NSMutableArray array];
    for (NSInteger i     = 0; i < 50; ++i) {
      T053ColorDiffModel *model = [T053ColorDiffModel.alloc initWithColor:sn.randomColor index:i];
      [arrM addObject:model];
    }

    _data = arrM.copy;
  }
  return _data;
}

- (T053CollectionView *)collectionView {

  if (_collectionView == nil) {
    UICollectionViewFlowLayout *flowLayout = UICollectionViewFlowLayout.new;
    // flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[T053CollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
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
    _adapter.dataSource         = self;
    _adapter.scrollViewDelegate = self;
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

  __weak __typeof(self) weakSelf = self;

  // 下拉刷新
  self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

    NSMutableArray *arrM = [NSMutableArray array];
    for (NSInteger i     = 0; i < 50; ++i) {
      T053ColorDiffModel *model = [T053ColorDiffModel.alloc initWithColor:sn.randomColor index:i];
      [arrM addObject:model];
    }
    weakSelf.data = arrM;

    // NSLog(@" weakSelf.data = %@", weakSelf.data);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (MJDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [weakSelf.adapter performUpdatesAnimated:YES completion:nil];
      [weakSelf.collectionView.mj_header endRefreshing];
    });
  }];
  [self.collectionView.mj_header beginRefreshing];
}

#pragma mark - <IGListAdapterDataSource>

// 返回遵守IGListDiffable协议的 对象数组, @(1) number类型和 字符串 好像默认遵守了该协议, 待研究
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {

  NSMutableArray<T053ColorDiffModel *> *objects = self.data.mutableCopy;

  if (self.isLoading) {

    T053ColorDiffModel *model = T053ColorDiffModel.new;

    model.title = self.spinToken;

    [objects addObject:model];
  }

  // NSLog(@"self.items = %@", [self.items valueForKey:@"title"]);
  // NSLog(@"objects = %@", [objects valueForKey:@"title"]);

  return objects;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(T053ColorDiffModel *)object {

  if ([object.title isEqualToString:self.spinToken]) {
    return T053SpinnerSectionController.new;
  } else {
    return T053SectionController.new;
  }

}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return self.emptyLabel;
}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

  // 手抬起瞬间的 scrollView的偏移量
  CGPoint point = *targetContentOffset;

  NSLogPoint(point);

  NSLog(@"scrollView.contentSize.height = %lf", scrollView.contentSize.height);
  NSLog(@"scrollView.bounds.size.height = %lf", scrollView.bounds.size.height);
  NSLog(@"point.y = %lf", point.y);

  //
  CGFloat d = point.y + scrollView.bounds.size.height;

  CGFloat distance = scrollView.contentSize.height - d;

  NSLog(@"distance = %lf", distance);

  // 每次不能加载太少 , 不然往回拉 也会触发加载更多...

  if (!self.loading && distance < 100) {
    SLog(@"没进来???");

    self.loading = YES;
    // 会发生什么事情?? 会重新走哪些方法???
    // [self.adapter performUpdatesAnimated:YES completion:nil];
    [self.adapter performUpdatesAnimated:YES completion:^(BOOL finished) {
      // [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height)];
      // [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentSize.height - scrollView.bounds.size.height) animated:YES];
      dispatch_async(dispatch_get_global_queue(0, 0), ^{

        sleep(3);

        dispatch_async(dispatch_get_main_queue(), ^{
          NSLog(@"%s", __func__);

          self.loading = NO;

          // self.data = self.data;
          NSMutableArray *arrM = [NSMutableArray array];
          for (NSInteger i     = self.data.count; i < self.data.count + 10; ++i) {
            T053ColorDiffModel *model = [T053ColorDiffModel.alloc initWithColor:sn.randomColor index:i];
            [arrM addObject:model];
          }
          self.data = [self.data arrayByAddingObjectsFromArray:arrM];

          [self.adapter performUpdatesAnimated:YES completion:nil];
        });
      });
    }];

    // dispatch_async(dispatch_get_global_queue(0, 0), ^{
    //
    //   sleep(2);
    //
    //   dispatch_async(dispatch_get_main_queue(), ^{
    //     self.loading = NO;
    //
    //     NSMutableArray *arrM = [NSMutableArray array];
    //     for (NSInteger i     = self.data.count; i < self.data.count + 5; ++i) {
    //       T053ColorDiffModel *model = [T053ColorDiffModel.alloc initWithColor:sn.randomColor index:i];
    //       [arrM addObject:model];
    //     }
    //     self.data = [self.data arrayByAddingObjectsFromArray:arrM];
    //
    //     [self.adapter performUpdatesAnimated:YES completion:nil];
    //   });
    // });
  }
}

@end
