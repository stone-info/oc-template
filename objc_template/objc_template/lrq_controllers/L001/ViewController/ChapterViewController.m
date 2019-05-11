//
// Created by Maskkkk on 2019-05-06.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "ChapterViewController.h"
#import <IGListKit/IGListKit.h>
#import "ChapterSectionController.h"
#import "ChapterBindingSectionController.h"

@interface ChapterViewController () <IGListAdapterDataSource>
@property (nonatomic, strong) UICollectionView             *collectionView;
@property (nonatomic, strong) IGListAdapter                *adapter;
@property (nonatomic, strong) NSArray <ChapterViewModel *> *chapterData;
@end

@implementation ChapterViewController {}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = [UIColor orangeColor];

  self.chapterData = @[
    [[ChapterViewModel alloc] initWithNo:1 name:@"风月无情"],
    [[ChapterViewModel alloc] initWithNo:2 name:@"故人之子"],
    [[ChapterViewModel alloc] initWithNo:3 name:@"求师终南"],
    [[ChapterViewModel alloc] initWithNo:4 name:@"全真门下"],
  ];
  [self setupUI];

  [self adapter];
  if (@available(iOS 11.0, *)) {
    // 取消自动调整内边距
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  } else {
    self.collectionView.viewController.automaticallyAdjustsScrollViewInsets = NO;
  }

}

- (void)setupUI {
  [self.view addSubview:self.collectionView];
  MASAttachKeys(self.collectionView);
  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0));
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
    IGListAdapterUpdater *updater = [IGListAdapterUpdater new];
    _adapter = [[IGListAdapter alloc] initWithUpdater:updater viewController:self];
    _adapter.collectionView = self.collectionView;
    _adapter.dataSource     = self;
  }
  return _adapter;
}

#pragma mark - <IGListAdapterDataSource>

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {
  return self.chapterData;
}

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {
  return [ChapterSectionController new];
}

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  self.chapterData = @[
    [[ChapterViewModel alloc] initWithNo:1 name:@"风月无情"],
    [[ChapterViewModel alloc] initWithNo:2 name:@"故人之子"],
    [[ChapterViewModel alloc] initWithNo:3 name:@"求师终南"],
    [[ChapterViewModel alloc] initWithNo:4 name:@"全真门下22"],
    [[ChapterViewModel alloc] initWithNo:5 name:@"活死人墓"],
    [[ChapterViewModel alloc] initWithNo:6 name:@"玉女心经"],
    [[ChapterViewModel alloc] initWithNo:7 name:@"重阳遗篇"],
    [[ChapterViewModel alloc] initWithNo:8 name:@"白衣少女"],
    [[ChapterViewModel alloc] initWithNo:9 name:@"白衣少女"],
    [[ChapterViewModel alloc] initWithNo:10 name:@"白衣少女"],
  ];
  [self.adapter performUpdatesAnimated:YES completion:nil];
}

- (void)injected {
  self.chapterData = @[
    [[ChapterViewModel alloc] initWithNo:1 name:@"风月无情"],
    [[ChapterViewModel alloc] initWithNo:2 name:@"故人之子"],
    [[ChapterViewModel alloc] initWithNo:3 name:@"求师终南"],
    [[ChapterViewModel alloc] initWithNo:4 name:@"全真门下"],
    [[ChapterViewModel alloc] initWithNo:5 name:@"活死人墓"],
    [[ChapterViewModel alloc] initWithNo:6 name:@"玉女心经"],
    [[ChapterViewModel alloc] initWithNo:7 name:@"重阳遗篇"],
    [[ChapterViewModel alloc] initWithNo:8 name:@"白衣少女"],
    [[ChapterViewModel alloc] initWithNo:9 name:@"白衣少女"],
    [[ChapterViewModel alloc] initWithNo:10 name:@"白衣少女"],
  ];
  [self.adapter performUpdatesAnimated:YES completion:nil];
  NSLog(@"hello world2");
}

@end
