//
//  T081ViewController.m
//  objc_template
//
//  Created by stone on 2019-05-19.
//  Copyright © 2019 stone. All rights reserved.
//
#import "T081ViewController.h"
#import "LoginSectionController.h"
#import "T081TestSectionController.h"
#import "T081TopModel.h"
#import "T081RequestViewModel.h"
#import "SNUserModel.h"
#import "T081TopBindModel.h"
#import "T081UserSectionController.h"
#import <IGListKit/IGListKit.h>

@interface T081ViewController () <IGListAdapterDataSource>
@property (strong, nonatomic) UICollectionView     *collectionView;
@property (strong, nonatomic) IGListAdapter        *adapter;
@property (strong, nonatomic) NSMutableArray       *data;
@property (strong, nonatomic) UILabel              *emptyLabel;
@property (strong, nonatomic) T081RequestViewModel *requestViewModel;
@end

@implementation T081ViewController
- (T081RequestViewModel *)requestViewModel {

  /** _requestViewModel lazy load */

  if (_requestViewModel == nil) {
    _requestViewModel = [T081RequestViewModel new];
  }
  return _requestViewModel;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = UIColor.whiteColor;
  // make layout
  [self.view addSubview:self.collectionView];

  //  在 iOS 10 中, 引入了一种新的细胞预取 API.在 Instagam, 启用此功能会显著降低滚动性能。
  if ([self.collectionView respondsToSelector:@selector(setPrefetchingEnabled:)]) { [self.collectionView setPrefetchingEnabled:NO]; }
  if ([self.collectionView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) { [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever]; }
  if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) { [self setAutomaticallyAdjustsScrollViewInsets:NO]; }

  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0));
  }];
  self.adapter.collectionView = self.collectionView;

  [self addRequest];

}

- (void)addRequest {


  // 监听事件, 跳过第一次, 因为默认发送未开始信号
  __block MBProgressHUD *hud;
  [[self.requestViewModel.requestCommand.executing skip:1] subscribeNext:^(NSNumber *x) {
    if ([x boolValue]) {
      hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    } else {
      [hud hideAnimated:YES];
    }
  }];

  [self.requestViewModel.requestCommand.executionSignals.switchToLatest subscribeNext:^(id x) {

    NSLog(@"%@", x);

    NSMutableArray<SNUserModel *> *users = [SNUserModel mj_objectArrayWithKeyValuesArray:x];

    _data = [NSMutableArray array];
    [_data addObject:[T081TopModel.alloc initWithIdentifier:@"login"]]; // 一个模型对应 IGListStackedSectionController 数组里的所有section, 1* 数组个数, 如果是2个, 2* 数组个数
    [_data addObject:[T081TopModel.alloc initWithIdentifier:@"测试"]];
    [_data addObject:[T081TopBindModel.alloc initWithIdentifier:@"users" dataList:users]];

    [self.adapter performUpdatesAnimated:NO completion:nil];

  }];

  [self.requestViewModel.requestCommand.errors subscribeNext:^(NSError *error) {
    NSLog(@"error = %@", error);
  }];

  [self.requestViewModel.requestCommand execute:@"SNUserApi"];

}

#pragma mark - <IGListAdapterDataSource>

// 返回遵守IGListDiffable协议的 对象数组, @(1) number类型和 字符串 好像默认遵守了该协议, 待研究
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {

  return self.data;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  if ([object isKindOfClass:[T081TopModel class]]) {

    T081TopModel *model = (T081TopModel *) object;

    if ([model.identifier isEqualToString:@"测试"]) {
      NSArray *controllers = @[
        LoginSectionController.new,
        T081TestSectionController.new,
      ];

      IGListStackedSectionController *sectionController = [IGListStackedSectionController.alloc initWithSectionControllers:controllers];
      sectionController.inset = UIEdgeInsetsMake(0, 0, 20, 0);
      return sectionController;
    }
  }

  if ([object isKindOfClass:[T081TopBindModel class]]) {
    T081TopBindModel *model = (T081TopBindModel *) object;
    if ([model.identifier isEqualToString:@"users"]) {
      return T081UserSectionController.new;
    }
  }

  return [IGListSingleSectionController.alloc
    initWithCellClass:UICollectionViewCell.class
    configureBlock:^(id item, __kindof UICollectionViewCell *cell) {
      NSInteger section = [listAdapter sectionForObject:item];
      cell.contentView.backgroundColor = sn.randomColor;
    }
    sizeBlock:^CGSize(id item, id <IGListCollectionContext> collectionContext) {
      if (collectionContext) {
        // 横向滚动的时候用
        // return CGSizeMake(collectionContext.containerSize.width, collectionContext.containerSize.height);
        return CGSizeMake(collectionContext.containerSize.width, 55);
      } else {
        return CGSizeZero;
      }
    }];
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return self.emptyLabel;
}

/** lazy load */
- (NSMutableArray *)data {

  if (_data == nil) {
    _data = [NSMutableArray array];
    [_data addObject:[T081TopModel.alloc initWithIdentifier:@"login"]]; // 一个模型对应 IGListStackedSectionController 数组里的所有section, 1* 数组个数, 如果是2个, 2* 数组个数
    [_data addObject:[T081TopModel.alloc initWithIdentifier:@"测试"]];
    [_data addObject:[T081TopBindModel.alloc initWithIdentifier:@"users" dataList:@[]]];
  }
  return _data;
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
    // flowLayout.sectionHeadersPinToVisibleBounds = YES;
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
    _adapter = [[IGListAdapter alloc] initWithUpdater:IGListAdapterUpdater.new viewController:self workingRangeSize:2];
    _adapter.dataSource = self;
  }
  return _adapter;
}

- (void)dealloc {
  NSLog(@"■■■■■■\t%@ is dead ☠☠☠\t■■■■■■", [self class]);
}

@end



