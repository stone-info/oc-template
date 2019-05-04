//
//  T052ViewController.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//
#import "T052ViewController.h"
#import <IGListKit/IGListKit.h>
#import "PostOC.h"
#import "CommentOC.h"
#import "PostSectionControllerOC.h"

@interface T052ViewController () <IGListAdapterDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IGListAdapter           *adapter;
@property (strong, nonatomic) NSArray                 *data;
@property (strong, nonatomic) UILabel                 *emptyLabel;
@end

@implementation T052ViewController

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

- (NSArray *)data {

  if (_data == nil) {
    _data = @[
      // [PostOC.alloc initWithUsername:@"@janedoe" timestamp:@"15min" imageURL:[NSURL URLWithString:@"https://placekitten.com/g/375/250"] likes:@384 comments:@[
      [PostOC.alloc
        initWithUsername:@"@janedoe"
        timestamp:@"15min"
        imageURL:[NSURL URLWithString:@"https://placekitten.com/g/375/250"]
        likes:384
        comments:@[
          [CommentOC.alloc initWithUsername:@"ryan" text:@"this is beautiful!"],
          [CommentOC.alloc initWithUsername:@"jsq" text:@"😱"],
          [CommentOC.alloc initWithUsername:@"caitlin" text:@"#blessed"],
        ]]
    ];
  }
  return _data;
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
  self.adapter.dataSource     = self;
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

  return self.data;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  return PostSectionControllerOC.new;
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return self.emptyLabel;
}

@end
