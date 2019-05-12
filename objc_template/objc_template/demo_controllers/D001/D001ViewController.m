//
//  D000ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import "D001ViewController.h"
#import "DemoSectionController.h"
#import "RACSignalViewController.h"
#import "RACSubjectViewController.h"
#import "RACTupleViewController.h"
#import "RACSchedulerViewController.h"
#import "RACNetworkViewController.h"
#import "RACMacroViewController.h"
#import "RACMulticastConnectionViewController.h"
#import "RACCommandViewController.h"
#import "RACBindViewController.h"
#import "RACMapViewController.h"
#import "RACConcatViewController.h"
#import "RACFilterViewController.h"
#import "RACLoginViewController.h"
#import "RACMVVMViewController.h"

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
    [DemoItem.alloc initWithName:@"RAC网络请求 rac_liftSelector" controllerClass:RACNetworkViewController.class],
    [DemoItem.alloc initWithName:@"RACMacro" controllerClass:RACMacroViewController.class],
    [DemoItem.alloc initWithName:@"RACMulticastConnection" controllerClass:RACMulticastConnectionViewController.class],
    [DemoItem.alloc initWithName:@"RACCommand" controllerClass:RACCommandViewController.class],
    [DemoItem.alloc initWithName:@"bind & RACReturnSignal" controllerClass:RACBindViewController.class],
    [DemoItem.alloc initWithName:@"Map & flattenMap" controllerClass:RACMapViewController.class],
    [DemoItem.alloc initWithName:@"concat & then & merge & zipWith" controllerClass:RACConcatViewController.class],
    [DemoItem.alloc initWithName:@"filter & ignore & take & until & skip" controllerClass:RACFilterViewController.class],
    [DemoItem.alloc initWithName:@"login" controllerClass:RACLoginViewController.class],
    [DemoItem.alloc initWithName:@"MVVM" controllerClass:RACMVVMViewController.class],
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



