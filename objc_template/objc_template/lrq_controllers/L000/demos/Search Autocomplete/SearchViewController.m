//
//  SearchViewController.m
//  objc_template
//
//  Created by stone on 2019-05-02.
//  Copyright © 2019 stone. All rights reserved.
//
#import "SearchViewController.h"
#import "LabelSectionController.h"
#import "SearchSectionController.h"
#import <IGListKit/IGListKit.h>

@interface SearchViewController () <IGListAdapterDataSource, SearchSectionControllerDelegate>
@property (strong, nonatomic) UICollectionView    *collectionView;
@property (strong, nonatomic) IGListAdapter       *adapter;
@property (strong, nonatomic) NSArray<NSString *> *words;
@property (copy, nonatomic) NSString              *filterString;
@property (strong, nonatomic) NSNumber            *searchToken;

@end

@implementation SearchViewController
- (UICollectionView *)collectionView {

  if (_collectionView == nil) {
    UICollectionViewFlowLayout *flowLayout = UICollectionViewFlowLayout.new;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = UIColor.whiteColor;
  }
  return _collectionView;
}

- (void)initData {
  self.words        = @[
    @"江户川柯南",
    @"工藤新一",
    @"毛利兰",
    @"毛利小五郎",
    @"阿笠博士",
    @"灰原哀",
    @"吉田步美",
    @"步美的母亲",
    @"圆谷光彦",
    @"小岛元太",
    @"铃木园子",
    @"服部平次",
    @"远山和叶",
    @"世良真纯",
    @"冲矢昴",
    @"安室透",
    @"工藤优作",
    @"工藤有希子",
    @"怪盗基德"
  ];
  self.filterString = @"";
  self.searchToken  = @(42);

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
  self.view.backgroundColor = UIColor.whiteColor;

  NSString *string = @"HELLO WORLD".lowercaseString;

  NSLog(@"string = %@", string);

  [self initData];

  // make layout
  [self.view addSubview:self.collectionView];

  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0));
  }];
  self.adapter.collectionView = self.collectionView;
  self.adapter.dataSource     = self;
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


  NSMutableArray *arrM = [NSMutableArray array];
  [arrM addObject:self.searchToken];

  if ([self.filterString isEqualToString:@""]) {

    NSArray *array = [self.words map:^NSString *(NSString *obj,NSUInteger idx) { return obj; }];

    [arrM addObjectsFromArray:array];

    return arrM;

  } else {

    NSArray *array = [self.words filter:^BOOL(NSString *obj,NSUInteger idx) {
      return [obj.lowercaseString containsString:self.filterString.lowercaseString];
    }];

    NSArray *map = [array map:^NSString *(NSString *obj,NSUInteger idx) {
      return obj;
    }];

    [arrM addObjectsFromArray:map];

    return arrM;
  }
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  if ([object isKindOfClass:[NSNumber class]] && [self.searchToken isEqualToNumber:object]) {

    SearchSectionController *sectionController = SearchSectionController.new;

    sectionController.delegate = self;

    return sectionController;
  } else {
    return LabelSectionController.new;
  }

  return IGListSectionController.new;
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  UILabel *label = UILabel.new;
  label.text          = @"没有数据...";
  label.textAlignment = NSTextAlignmentCenter;
  return label;
  // return nil;
}

- (void)sectionController:(SearchSectionController *)sectionController didChangeText:(NSString *)text {
  self.filterString = text;
  [self.adapter performUpdatesAnimated:YES completion:nil];
}

@end