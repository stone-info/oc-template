//
//  T01ViewController.m
//  objc_template
//
//  Created by stone on 2019-05-02.
//  Copyright © 2019 stone. All rights reserved.
//
#import <IGListKit/IGListKit.h>
#import "LoadMoreViewController.h"
#import "SpinnerCell.h"
#import "LabelSectionController.h"
#import <Masonry/Masonry.h>
#import "DemoModel.h"

@interface LoadMoreViewController () <IGListAdapterDataSource, UIScrollViewDelegate>
@property (strong, nonatomic) UICollectionView            *collectionView;
@property (nonatomic, strong) IGListAdapter               *adapter;
@property (strong, nonatomic) NSMutableArray<DemoModel *> *items;
@property (assign, nonatomic) NSInteger                   loading;
@property (copy, nonatomic) NSString                      *spinToken;
@end

@implementation LoadMoreViewController

- (UICollectionView *)collectionView {

  if (_collectionView == nil) {
    UICollectionViewFlowLayout *flowLayout = UICollectionViewFlowLayout.new;
    // flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = UIColor.whiteColor;
    _collectionView.showsVerticalScrollIndicator = NO;
    // _collectionView.pagingEnabled = YES;
  }
  return _collectionView;
}

- (NSString *)spinToken {

  if (_spinToken == nil) {
    _spinToken = @"spinner";
  }
  return _spinToken;
}

- (NSMutableArray<DemoModel *> *)items {

  if (_items == nil) {

    _items = [NSMutableArray array];

    for (NSInteger i = 0; i < 20; ++i) {
      DemoModel *model = DemoModel.new;
      model.title = kStringFormat(@"%li", i);
      [_items addObject:model];
    }
  }
  return _items;
}

- (IGListAdapter *)adapter {
  if (_adapter == nil) {
    _adapter = [[IGListAdapter alloc] initWithUpdater:IGListAdapterUpdater.new viewController:self workingRangeSize:0];
  }
  return _adapter;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  // make layout
  self.view.backgroundColor = UIColor.whiteColor;
  [self.view addSubview:self.collectionView];

  self.adapter.collectionView     = self.collectionView;
  self.adapter.dataSource         = self;
  self.adapter.scrollViewDelegate = self;
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  CGFloat y      = kStatusBarHeight + kNavigationBarHeight;
  CGFloat height = kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kSafeAreaBottomHeight;
  self.collectionView.frame = CGRectMake(0, y, kScreenWidth, height);
}

#pragma mark - <IGListAdapterDataSource>

/**
 要求数据源中的对象显示在列表中。

 @param listAdapter请求此信息的列表适配器。

 @return列表的对象数组。

 */
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {

  NSMutableArray<DemoModel *> *objects = self.items.mutableCopy;

  if (self.loading) {
    DemoModel *model = DemoModel.new;
    model.title = self.spinToken;
    [objects addObject:model];
  }

  // NSLog(@"self.items = %@", [self.items valueForKey:@"title"]);
  // NSLog(@"objects = %@", [objects valueForKey:@"title"]);

  return objects;
}

/**

 询问列表中指定对象的section控制器的数据源。

  @param listAdapter请求此信息的列表适配器。
  @param object列表中的对象。

  @return可以在列表中显示的新节控制器实例。

  @note当询问对象时，应在此处初始化新的控件。 您可以传递任何其他数据
  此时的区段控制器。

  每当创建，更新或重新加载`IGListAdapter`时，都会为所有对象初始化节控制器。
  移动或更新对象时，将重用节控制器。 维护` -  [IGListDiffable diffIdentifier]`
  保证这一点。

 */
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(DemoModel *)object {
  NSLog(@"%s", __func__);
  // NSLog(@"object class = %@", SN.getClassName(object));

  if ([object.title isEqualToString:self.spinToken]) {

    return [[IGListSingleSectionController alloc] initWithCellClass:SpinnerCell.class
                                           configureBlock:^(id item, __kindof UICollectionViewCell *cell) {

                                             BOOL flag = [cell isKindOfClass:[SpinnerCell class]];

                                             if (flag) {
                                               SpinnerCell *spinnerCell = (SpinnerCell *) cell;

                                               NSLog(@"spinnerCell.activityIndicator = %@", spinnerCell.activityIndicator);

                                               [spinnerCell.activityIndicator startAnimating];
                                             }
                                           }
                                           sizeBlock:^CGSize(id item, id <IGListCollectionContext> collectionContext) {
                                             if (collectionContext) {
                                               return CGSizeMake(collectionContext.containerSize.width, 100);
                                             } else {
                                               return CGSizeZero;
                                             }
                                           }];;
  } else {
    return LabelSectionController.new;
  }
}

/**

 要求视图的数据源在列表为空时用作集合视图背景。

  @param listAdapter请求此信息的列表适配器。

  @return用作集合视图背景的视图，如果不需要背景视图，则为“nil”。

  @note每次更新列表适配器时都会调用此方法。 您每次都可以自由返回新视图，
  但出于性能原因，您可能希望保留视图并将其返回此处。 下面只负责
  添加背景视图并保持其可见性。

 */
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  //没有数据时候的view
  return nil;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {

  // CGPoint point = *targetContentOffset;
  //
  // NSLogPoint(point);

  // NSUInteger itemCount = self.items.count;
  //
  // for (NSUInteger i = itemCount; i < itemCount + 5; ++i) {
  //   DemoModel *model = DemoModel.new;
  //   model.title = kStringFormat(@"%li", i);
  //   [self.items addObject:model];
  // }
  // [self.adapter performUpdatesAnimated:YES completion:nil];


  CGPoint point = *targetContentOffset;

  CGFloat distance = scrollView.contentSize.height - (point.y + scrollView.bounds.size.height);

  // for (NSUInteger i = 0; i < self.items.count; ++i) {
  //   DemoModel *model = self.items[i];
  //   NSLog(@"model.title = %@", model.title);
  // }
  // NSLog(@"titles ", [self.items valueForKey:@"title"]);

  if (!self.loading && distance < 200) {

    self.loading = YES;

    // 会发生什么事情?? 会重新走哪些方法???
    [self.adapter performUpdatesAnimated:YES completion:nil];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{

      sleep(2);

      dispatch_async(dispatch_get_main_queue(), ^{
        self.loading = NO;
        NSUInteger itemCount = self.items.count;

        for (NSUInteger i = itemCount; i < itemCount + 20; ++i) {
          DemoModel *model = DemoModel.new;
          model.title = kStringFormat(@"%li", i);
          [self.items addObject:model];
        }
        [self.adapter performUpdatesAnimated:YES completion:nil];
      });
    });



    // self.loading = NO;
    // NSUInteger itemCount = self.items.count;
    //
    // NSMutableArray  *arrM = [NSMutableArray array];
    // for (NSUInteger i     = itemCount; i < itemCount + 5; ++i) {
    //   DemoModel *model = DemoModel.new;
    //   model.title = kStringFormat(@"%li", i);
    //   [arrM addObject:model];
    // }
    //
    // [self.items addObjectsFromArray:arrM];
    //
    // [self.adapter performUpdatesAnimated:YES completion:nil];
  }
}

@end
