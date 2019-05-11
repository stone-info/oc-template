//
//  D000ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "D001ViewController.h"
#import "DemoSectionController.h"
#import "RACSignalViewController.h"
#import "RACSubjectViewController.h"
#import "RACTupleViewController.h"
#import "RACSchedulerViewController.h"

#import <IGListKit/IGListKit.h>

@interface D001ViewController () <IGListAdapterDataSource>
@property (strong, nonatomic) UICollectionView    *collectionView;
@property (strong, nonatomic) IGListAdapter       *adapter;
@property (strong, nonatomic) NSArray<DemoItem *> *demos;
@end

@implementation D001ViewController

- (NSArray<DemoItem *> *)demos {

  if (_demos != nil) { return _demos; }

  _demos = @[
    [DemoItem.alloc initWithName:@"RACSignal" controllerClass:RACSignalViewController.class],
    [DemoItem.alloc initWithName:@"RACSubject" controllerClass:RACSubjectViewController.class],
    [DemoItem.alloc initWithName:@"RACTuple & RACSequence" controllerClass:RACTupleViewController.class],
    [DemoItem.alloc initWithName:@"RACScheduler" controllerClass:RACSchedulerViewController.class],
  ];

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



