//
//  CalendarViewController.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//
#import "CalendarViewController.h"
#import "MonthSectionController.h"
#import "Month.h"
#import <IGListKit/IGListKit.h>

@interface CalendarViewController () <IGListAdapterDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) IGListAdapter    *adapter;
@property (strong, nonatomic) UILabel          *emptyLabel;
@property (strong, nonatomic) NSArray<Month *> *months;
@end

@implementation CalendarViewController

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
    IGListCollectionViewLayout *layout = [IGListCollectionViewLayout.alloc initWithStickyHeaders:NO topContentInset:0 stretchToEdge:NO];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = UIColor.whiteColor;
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

  NSDate *date = NSDate.new;

  NSInteger currentMonth = [NSCalendar.currentCalendar component:NSCalendarUnitMonth fromDate:date];

  Month *month = [Month.alloc initWithName:NSDateFormatter.new.monthSymbols[currentMonth - 1] days:@30 appointments:@{
    @2 : @[@"Hair"],
    @4 : @[@"Nails"],
    @7 : @[@"Doctor appt", @"Pick up groceries"],
    @12: @[@"Call back the cable company", @"Find a babysitter"],
    @13: @[@"Dinner at The Smith"],
    @17: @[@"Buy running shoes", @"Buy a fitbit", @"Start running"],
    @20: @[@"Call mom"],
    @21: @[@"Contribute to IGListKit"],
    @25: @[@"Interview"],
    @26: @[@"Quit running", @"Buy ice cream"],
  }];

  self.months = @[month];

  // make layout
  [self.view addSubview:self.collectionView];

  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0));
  }];
  self.adapter.collectionView = self.collectionView;

}

#pragma mark - <IGListAdapterDataSource>

// 返回遵守IGListDiffable协议的 对象数组, @(1) number类型和 字符串 好像默认遵守了该协议, 待研究
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {

  NSLog(@"self.months = %@", self.months);

  return self.months;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  NSLog(@"%s", __func__);

  return MonthSectionController.new;
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return self.emptyLabel;
}

@end
