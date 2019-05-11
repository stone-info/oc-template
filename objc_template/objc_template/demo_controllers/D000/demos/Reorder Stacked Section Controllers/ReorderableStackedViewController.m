//
//  ReorderableStackedViewController.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//
#import "ReorderableStackedViewController.h"
#import "LabelsItem.h"
#import "PrefixedLabelSectionController.h"
#import <IGListKit/IGListKit.h>

@interface ReorderableStackedViewController () <IGListAdapterDataSource, IGListAdapterMoveDelegate, UIScrollViewDelegate>
@property (strong, nonatomic) UICollectionView      *collectionView;
@property (strong, nonatomic) IGListAdapter         *adapter;
@property (strong, nonatomic) NSArray<LabelsItem *> *data;
@property (strong, nonatomic) UILabel               *emptyLabel;
@end

@implementation ReorderableStackedViewController

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

- (NSArray<LabelsItem *> *)data {

  if (_data == nil) {

    _data = @[
      [LabelsItem.alloc
        initWithColor:[UIColor colorWithRed:56 / 255.0 green:151 / 255.0 blue:240 / 255.0 alpha:1.0]
        labels1:@[@"A", @"B", @"C"]
        labels2:@[@"1", @"2", @"3", @"4", @"6", @"7", @"8", @"8", @"9"]
      ],
      [LabelsItem.alloc
        initWithColor:[UIColor colorWithRed:128 / 255.0 green:240 / 255.0 blue:151 / 255.0 alpha:1.0]
        labels1:@[@"D"]
        labels2:@[
          @"10",
          @"11",
          @"12",
          @"13",
          @"14",
          @"15",
          @"16",
          @"17",
          @"18",
          @"19",
          @"20",
        ]
      ],
    ];
  }
  return _data;
}

- (UICollectionView *)collectionView {

  if (_collectionView == nil) {
    UICollectionViewFlowLayout *flowLayout = UICollectionViewFlowLayout.new;

    // section bar 置顶 , table view 可以扔了
    flowLayout.sectionHeadersPinToVisibleBounds = YES;
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
    _adapter.dataSource         = self;
    _adapter.scrollViewDelegate = self;
  }
  return _adapter;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  if (@available(iOS 9.0, *)) {
    UILongPressGestureRecognizer *longPressGesture = [UILongPressGestureRecognizer.alloc initWithTarget:self action:@selector(handleLongGesture:)];
    [self.collectionView addGestureRecognizer:longPressGesture];
  }

  self.view.backgroundColor = UIColor.whiteColor;
  // make layout
  [self.view addSubview:self.collectionView];

  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0));
  }];
  self.adapter.collectionView = self.collectionView;

  if (@available(iOS 9.0, *)) {
    self.adapter.moveDelegate = self;
  }
}

- (void)handleLongGesture:(UILongPressGestureRecognizer *)sender {

  switch (sender.state) {
    case UIGestureRecognizerStateBegan: {
      CGPoint     touchLocation      = [sender locationInView:_collectionView];
      NSIndexPath *selectedIndexPath = [_collectionView indexPathForItemAtPoint:touchLocation];
      [_collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
      break;
    }
    case UIGestureRecognizerStateChanged: {
      UIView  *view    = sender.view;
      CGPoint position = [sender locationInView:view];
      [_collectionView updateInteractiveMovementTargetPosition:position];
      break;
    }
    case UIGestureRecognizerStateEnded:
      [_collectionView endInteractiveMovement];
    default:
      [_collectionView cancelInteractiveMovement];

      break;
  }
}

#pragma mark - <IGListAdapterDataSource>

// 返回遵守IGListDiffable协议的 对象数组, @(1) number类型和 字符串 好像默认遵守了该协议, 待研究
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {

  return self.data;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  IGListStackedSectionController *sectionController = [IGListStackedSectionController.alloc initWithSectionControllers:@[
    [PrefixedLabelSectionController.alloc initWithPrefix:@"🔤" group:@1],
    [PrefixedLabelSectionController.alloc initWithPrefix:@"🔢" group:@2],
  ]];
  sectionController.inset = UIEdgeInsetsMake(0, 0, 44, 0);
  return sectionController;
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return self.emptyLabel;
}

- (void)listAdapter:(IGListAdapter *)listAdapter moveObject:(id)object from:(NSArray *)previousObjects to:(NSArray *)objects {
  self.data = objects;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
  UICollectionView *collectionView = (UICollectionView  *)scrollView;


}

@end
