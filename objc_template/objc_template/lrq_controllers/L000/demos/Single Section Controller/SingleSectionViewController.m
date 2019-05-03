//
//  SingleSectionViewController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//
#import "SingleSectionViewController.h"
#import "NibCell.h"
#import <IGListKit/IGListKit.h>

@interface SingleSectionViewController () <IGListAdapterDataSource, IGListSingleSectionControllerDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) IGListAdapter    *adapter;
@property (strong, nonatomic) NSArray          *data;
@property (strong, nonatomic) UILabel          *emptyLabel;
@end

@implementation SingleSectionViewController

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

    for (NSInteger i = 0; i < 20; ++i) {
      [arrM addObject:@(i)];
    }
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

  IGListSingleSectionController *sectionController = [IGListSingleSectionController.alloc
    initWithNibName:NibCell.nibName
    bundle:nil
    configureBlock:^(id item, NibCell *cell) {
      NSNumber *number  = (NSNumber *) item;
      cell.textLabel.text = kStringFormat(@"Cell: %li", number.integerValue + 1);
    }
    sizeBlock:^CGSize(id item, id <IGListCollectionContext> collectionContext) {
      return CGSizeMake(collectionContext.containerSize.width, 44);
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
