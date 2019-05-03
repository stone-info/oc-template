//
//  StoryboardViewController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//
#import "StoryboardViewController.h"
#import "PersonOC.h"
#import "StoryboardLabelSectionController.h"
#import <IGListKit/IGListKit.h>

@interface StoryboardViewController () <IGListAdapterDataSource, StoryboardLabelSectionControllerDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView    *collectionView;
@property (strong, nonatomic) IGListAdapter       *adapter;
@property (strong, nonatomic) NSArray<PersonOC *> *people;
@property (strong, nonatomic) UILabel             *emptyLabel;

@end

@implementation StoryboardViewController

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

- (NSArray<PersonOC *> *)people {

  if (_people == nil) {

    NSArray *arr = @[
      @"Littlefinger",
      @"Tommen Baratheon",
      @"Roose Bolton",
      @"Brienne of Tarth",
      @"Bronn",
      @"Gilly",
      @"Theon Greyjoy",
      @"Jaqen H'ghar",
      @"Cersei Lannister",
      @"Jaime Lannister",
      @"Tyrion Lannister",
      @"Melisandre",
      @"Missandei",
      @"Jorah Mormont",
      @"Khal Moro",
      @"Daario Naharis",
      @"Jon Snow",
      @"Arya Stark",
      @"Bran Stark",
      @"Sansa Stark",
      @"Daenerys Targaryen",
      @"Samwell Tarly",
      @"Tormund",
      @"Margaery Tyrell",
      @"Varys",
      @"Renly Baratheon",
      @"Joffrey Baratheon",
      @"Stannis Baratheon",
      @"Hodor",
      @"Tywin Lannister",
      @"The Hound",
      @"Ramsay Bolton"
    ];

    NSMutableArray *arrM = [NSMutableArray array];

    for (NSUInteger i = 0; i < arr.count; ++i) {
      NSString *name = arr[i];
      PersonOC *oc   = [PersonOC.alloc initWithPk:@(i + 1) name:name];
      [arrM addObject:oc];
    }

    _people = arrM.copy;
  }
  return _people;
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

  return self.people;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  StoryboardLabelSectionController *sectionController = StoryboardLabelSectionController.new;
  sectionController.delegate = self;
  return sectionController;
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return self.emptyLabel;
}

- (void)removeSectionControllerWantsRemoved:(StoryboardLabelSectionController *)sectionController {

  NSInteger section = [self.adapter sectionForSectionController:sectionController];

  NSArray *array = [self.people filter:^BOOL(id obj, NSUInteger idx) { return section != idx; }];

  self.people = array;

  [self.adapter performUpdatesAnimated:YES completion:nil];

}


@end
