//
//  L000ViewController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//
#import "L000ViewController.h"
#import "DemoSectionController.h"
#import "LoadMoreViewController.h"
#import "SearchViewController.h"
#import "MixedDataViewController.h"
#import "NestedAdapterViewController.h"
#import "EmptyViewController.h"
#import "SingleSectionViewController.h"
#import "StoryboardViewController.h"
#import "SingleSectionStoryboardViewController.h"
#import "WorkingRangeViewController.h"
#import "DiffTableViewController.h"
#import "SupplementaryViewController.h"
#import "SelfSizingCellsViewController.h"
#import "DisplayViewController.h"
#import "StackedViewController.h"
#import "ObjcDemoViewController.h"
#import "ObjcGeneratedModelDemoViewController.h"
#import "CalendarViewController.h"
#import "AnnouncingDepsViewController.h"
#import "ReorderableViewController.h"
#import "ReorderableStackedViewController.h"
#import <IGListKit/IGListKit.h>

@interface L000ViewController () <IGListAdapterDataSource>
@property (strong, nonatomic) UICollectionView    *collectionView;
@property (strong, nonatomic) IGListAdapter       *adapter;
@property (strong, nonatomic) NSArray<DemoItem *> *demos;
@end

@implementation L000ViewController

- (NSArray<DemoItem *> *)demos {

  if (_demos == nil) {
    _demos = @[
      [DemoItem.alloc initWithName:@"Tail Loading" controllerClass:LoadMoreViewController.class],
      [DemoItem.alloc initWithName:@"Search Autocomplete" controllerClass:SearchViewController.class],
      [DemoItem.alloc initWithName:@"Mixed Data" controllerClass:MixedDataViewController.class],
      [DemoItem.alloc initWithName:@"Nested Adapter" controllerClass:NestedAdapterViewController.class],
      [DemoItem.alloc initWithName:@"Empty View" controllerClass:EmptyViewController.class],
      [DemoItem.alloc initWithName:@"Single Section Controller" controllerClass:SingleSectionViewController.class],
      [DemoItem.alloc initWithName:@"Storyboard" controllerClass:StoryboardViewController.class controllerIdentifier:@"demo"],
      [DemoItem.alloc initWithName:@"Single Section Storyboard" controllerClass:SingleSectionStoryboardViewController.class controllerIdentifier:@"singleSectionDemo"],
      [DemoItem.alloc initWithName:@"Working Range" controllerClass:WorkingRangeViewController.class],
      [DemoItem.alloc initWithName:@"Diff Algorithm" controllerClass:DiffTableViewController.class],
      [DemoItem.alloc initWithName:@"Supplementary Views" controllerClass:SupplementaryViewController.class],
      [DemoItem.alloc initWithName:@"Self-sizing cells" controllerClass:SelfSizingCellsViewController.class],
      [DemoItem.alloc initWithName:@"Display delegate" controllerClass:DisplayViewController.class],
      [DemoItem.alloc initWithName:@"Stacked Section Controllers" controllerClass:StackedViewController.class],
      [DemoItem.alloc initWithName:@"Objc Demo" controllerClass:ObjcDemoViewController.class],
      [DemoItem.alloc initWithName:@"Objc Generated Model Demo" controllerClass:ObjcGeneratedModelDemoViewController.class],
      [DemoItem.alloc initWithName:@"Calendar (auto diffing)" controllerClass:CalendarViewController.class],
      [DemoItem.alloc initWithName:@"Dependency Injection" controllerClass:AnnouncingDepsViewController.class],
      [DemoItem.alloc initWithName:@"Reorder Cells" controllerClass:ReorderableViewController.class],
      [DemoItem.alloc initWithName:@"Reorder Stacked Section Controllers" controllerClass:ReorderableStackedViewController.class],
    ];
  }
  return _demos;
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
  }
  return _adapter;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  // make layout
  [self.view addSubview:self.collectionView];

  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0));
  }];
  self.adapter.collectionView = self.collectionView;
  self.adapter.dataSource     = self;

  if (@available(iOS 11.0, *)) {
    // 取消自动调整内边距
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  } else {
    self.automaticallyAdjustsScrollViewInsets = NO;
  }
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

  return self.demos;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  return DemoSectionController.new;
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  UILabel *label = UILabel.new;
  label.text = @"没有数据...";
  return label;
}

@end


