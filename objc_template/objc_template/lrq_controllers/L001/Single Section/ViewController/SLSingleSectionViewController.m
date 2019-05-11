//
// Created by Maskkkk on 2019-05-06.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <IGListKit/IGListAdapter.h>
#import <IGListKit/IGListSingleSectionController.h>
#import <IGListKit/IGListAdapterUpdater.h>
#import "SLSingleSectionViewController.h"
#import "SingleSectionCollectionCell.h"

@interface SLSingleSectionViewController () <IGListAdapterDataSource, IGListSingleSectionControllerDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) IGListAdapter    *adapter;
@property (nonatomic, strong) NSArray          *data;
@end

@implementation SLSingleSectionViewController {}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor whiteColor];
  [self setupUI];
  self.adapter.collectionView = self.collectionView;
}

- (void)setupUI {
  [self.view addSubview:self.collectionView];
  MASAttachKeys(self.collectionView);
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.top.right.mas_equalTo(self.view);
    make.bottom.mas_equalTo(self.view).mas_offset(-50);
  }];
}

- (UICollectionView *)collectionView {
  /** _collectionView lazy load */
  if (_collectionView == nil) {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
  }
  return _collectionView;
}

- (IGListAdapter *)adapter {

  /** _adapter lazy load */

  if (_adapter == nil) {
    _adapter = [[IGListAdapter alloc] initWithUpdater:IGListAdapterUpdater.new viewController:self];
    _adapter.dataSource = self;
  }
  return _adapter;
}

- (NSArray *)data {

  /** _data lazy load */
  if (_data == nil) {
    NSMutableArray *arrM = [NSMutableArray array];
    for (NSInteger i     = 0; i < 20; ++i) {
      [arrM addObject:@(i)];
    }
    _data = arrM.copy;
  }
  return _data;
}


#pragma mark - <IGListAdapterDataSource>
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
  NSLog(@"self.data = %@", self.data);
  return self.data;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
  IGListSingleSectionController *sectionController = [[IGListSingleSectionController alloc] initWithCellClass:SingleSectionCollectionCell.class configureBlock:^(NSNumber *item, __kindof SingleSectionCollectionCell *cell) {
    cell.chapterLabel.text = kStringFormat(@"Cell: %li", item.integerValue);
  } sizeBlock:^CGSize(id item, id <IGListCollectionContext> collectionContext) {
    return CGSizeMake(kScreenWidth, 44);
  }];
  sectionController.selectionDelegate = self;
  return sectionController;
}

- (void)didSelectSectionController:(IGListSingleSectionController *)sectionController
        withObject:(id)object {
  NSInteger section = [self.adapter sectionForSectionController:sectionController];
  NSString *title   = kStringFormat(@"Section %li is selected!", section);
  NSString *msg     = kStringFormat(@"cell's content is %@", object);
  kAlert(title, msg);
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return nil;
}
@end