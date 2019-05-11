//
//  MixedDataViewController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//
#import "MixedDataViewController.h"
#import "GridSectionController.h"
#import "GridItem.h"
#import "User.h"
#import "ExpandableSectionController.h"
#import "UserSectionController.h"
#import <IGListKit/IGListKit.h>
#import <Foundation/Foundation.h>

@interface MixedDataViewController () <IGListAdapterDataSource, IGListAdapterMoveDelegate>
@property (strong, nonatomic) UICollectionView        *collectionView;
@property (strong, nonatomic) IGListAdapter           *adapter;
@property (strong, nonatomic) NSArray                 *data;
@property (strong, nonatomic) NSArray<NSDictionary *> *segments;
@property (strong, nonatomic) Class                   selectedClass;
@end

@implementation MixedDataViewController

- (NSArray<NSDictionary *> *)segments {

  /** _segments lazy load */

  if (_segments == nil) {
    _segments = @[
      @{@"All": NSNull.class},
      @{@"Colors": GridItem.class},
      @{@"Text": NSString.class},
      @{@"Users": User.class},
    ];
  }
  return _segments;
}

- (NSArray *)data {

  if (_data == nil) {
    _data = @[
      @"Maecenas faucibus mollis interdum. Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit.",
      [[GridItem alloc] initWithColor:[UIColor colorWithRed:237 / 255.0 green:73 / 255.0 blue:86 / 255.0 alpha:1.0] itemCount:6],
      [[User alloc] initWithPk:@(2) name:@"Ryan Olson" handle:@"ryanolsonk"],
      @"Praesent commodo cursus magna, vel scelerisque nisl consectetur et.",
      [[User alloc] initWithPk:@(4) name:@"Oliver Rickard" handle:@"ocrickard"],
      [[GridItem alloc] initWithColor:[UIColor colorWithRed:56 / 255.0 green:151 / 255.0 blue:240 / 255.0 alpha:1.0] itemCount:5],
      @"Nullam quis risus eget urna mollis ornare vel eu leo. Praesent commodo cursus magna, vel scelerisque nisl consectetur et.",
      [[User alloc] initWithPk:@(3) name:@"Jesse Squires" handle:@"jesse_squires"],
      [[GridItem alloc] initWithColor:[UIColor colorWithRed:112 / 255.0 green:192 / 255.0 blue:80 / 255.0 alpha:1.0] itemCount:3],
      @"Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.",
      [[GridItem alloc] initWithColor:[UIColor colorWithRed:163 / 255.0 green:42 / 255.0 blue:186 / 255.0 alpha:1.0] itemCount:7],
      [[User alloc] initWithPk:@(1) name:@"Ryan Nystrom" handle:@"_ryannystrom"],
    ];
  }
  return _data;
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

  self.selectedClass = NSNull.class;

  UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:[self.segments map:^NSString *(NSDictionary *obj,NSUInteger idx) {
    return obj.allKeys[0];
  }]];
  control.selectedSegmentIndex = 0;
  [control addTarget:self action:@selector(onControl:) forControlEvents:UIControlEventValueChanged];
  self.navigationItem.titleView = control;
  if (@available(iOS 9.0, *)) {
    UILongPressGestureRecognizer *longPressGestureRecognizer = [UILongPressGestureRecognizer.alloc initWithTarget:self action:@selector(handleLongGesture:)];
    [self.collectionView addGestureRecognizer:longPressGestureRecognizer];
  }

  printf("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■\n");

  self.view.backgroundColor = UIColor.whiteColor;
  // make layout
  [self.view addSubview:self.collectionView];

  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0));
  }];
  self.adapter.collectionView = self.collectionView;
  self.adapter.dataSource     = self;

  if (@available(iOS 9.0, *)) {
    self.adapter.moveDelegate = self;
  }
}


- (void)handleLongGesture:(UILongPressGestureRecognizer *)sender {
  NSLog(@"%s", __func__);
  // UIGestureRecognizerStatePossible,   // the recognizer has not yet recognized its gesture, but may be evaluating touch events. this is the default state
  //
  // UIGestureRecognizerStateBegan,      // the recognizer has received touches recognized as the gesture. the action method will be called at the next turn of the run loop
  // UIGestureRecognizerStateChanged,    // the recognizer has received touches recognized as a change to the gesture. the action method will be called at the next turn of the run loop
  // UIGestureRecognizerStateEnded,      // the recognizer has received touches recognized as the end of the gesture. the action method will be called at the next turn of the run loop and the recognizer will be reset to UIGestureRecognizerStatePossible
  // UIGestureRecognizerStateCancelled,  // the recognizer has received touches resulting in the cancellation of the gesture. the action method will be called at the next turn of the run loop. the recognizer will be reset to UIGestureRecognizerStatePossible
  //
  // UIGestureRecognizerStateFailed,     // the recognizer has received a touch sequence that can not be recognized as the gesture. the action method will not be called and the recognizer will be reset to UIGestureRecognizerStatePossible
  //
  // // Discrete Gestures – gesture recognizers that recognize a discrete event but do not report changes (for example, a tap) do not transition through the Began and Changed states and can not fail or be cancelled
  // UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded // the recognizer has received touches recognized as the gesture. the action method will be called at the next turn of the run loop and the recognizer will be reset to UIGestureRecognizerStatePossible

  switch (sender.state) {
    case UIGestureRecognizerStateBegan: {
      CGPoint     touchLocation      = [sender locationInView:self.collectionView];
      NSIndexPath *selectedIndexPath = [self.collectionView indexPathForItemAtPoint:touchLocation];
      [self.collectionView beginInteractiveMovementForItemAtIndexPath:selectedIndexPath];
      break;
    }
    case UIGestureRecognizerStateChanged: {
      UIView  *view = sender.view;
      CGPoint point = [sender locationInView:view];
      [self.collectionView updateInteractiveMovementTargetPosition:point];
      break;
    }
    case UIGestureRecognizerStateEnded: {
      [self.collectionView endInteractiveMovement];
      break;
    }
    default:
      [self.collectionView cancelInteractiveMovement];
      break;
  }

}

- (void)onControl:(UISegmentedControl *)sender {

  NSDictionary *dictionary = self.segments[sender.selectedSegmentIndex];
  self.selectedClass = dictionary.allValues[0];

  [self.adapter performUpdatesAnimated:YES completion:nil];

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

  if (self.selectedClass == NSNull.class) {
    return [self.data map:^id(id obj,NSUInteger idx) { return obj; }];
  }

  return [self.data filter:^BOOL(id obj,NSUInteger idx) {
    return [obj isKindOfClass:self.selectedClass];
  }];
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  if ([object isKindOfClass:[NSString class]]) { return ExpandableSectionController.new; }
  if ([object isKindOfClass:[GridItem class]]) { return [[GridSectionController alloc] initWithReorderable:YES]; }

  return [[UserSectionController alloc] initWithReorderable:YES];
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  UILabel *label = UILabel.new;
  label.text = @"没有数据...";
  return label;
}

#pragma mark - <IGListAdapterMoveDelegate>

- (void)listAdapter:(IGListAdapter *)listAdapter moveObject:(id)object from:(NSArray *)previousObjects to:(NSArray *)objects {
  self.data = objects;
}
@end
