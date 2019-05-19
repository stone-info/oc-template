//
//  T080ViewController.m
//  objc_template
//
//  Created by stone on 2019-05-18.
//  Copyright © 2019 stone. All rights reserved.
//
#import "T080ViewControllerBackup.h"
#import "T80PostTopModel.h"
#import "T80Comment.h"
#import "T80PostSectionController.h"
#import <IGListKit/IGListKit.h>

@interface T080ViewControllerBackup () <IGListAdapterDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) IGListAdapter           *adapter;
@property (strong, nonatomic) NSMutableArray          *data;
@end

@implementation T080ViewControllerBackup

- (NSMutableArray *)data {

  if (_data == nil) {
    _data = [NSMutableArray array];

    [_data addObject:[T80PostTopModel.alloc
      initWithUsername:@"@janedoe"
      timestamp:@"15min"
      imageURL:[NSURL URLWithString:@"https://placekitten.com/g/375/250"]
      likes:384
      comments:@[
        [T80Comment.alloc initWithUsername:@"ryan" text:@"this is beautiful!"],
        [T80Comment.alloc initWithUsername:@"jsq" text:@"😱"],
        [T80Comment.alloc initWithUsername:@"caitlin" text:@"#blessed"],
      ]]];

    [_data addObject:[T80PostTopModel.alloc
      initWithUsername:@"@stone"
      timestamp:@"25min"
      imageURL:[NSURL URLWithString:@"https://placekitten.com/g/375/250"]
      likes:984
      comments:@[
        [T80Comment.alloc initWithUsername:@"ryan" text:@"this is beautiful!"],
        [T80Comment.alloc initWithUsername:@"jsq" text:@"😱"],
        [T80Comment.alloc initWithUsername:@"caitlin" text:@"#blessed"],
      ]]];
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
  self.view.backgroundColor = UIColor.whiteColor;
  // make layout
  [self.view addSubview:self.collectionView];

  //  在 iOS 10 中, 引入了一种新的细胞预取 API.在 Instagam, 启用此功能会显著降低滚动性能。
  if ([self.collectionView respondsToSelector:@selector(setPrefetchingEnabled:)]) { [self.collectionView setPrefetchingEnabled:NO]; }
  if ([self.collectionView respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) { [self.collectionView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever]; }
  if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) { [self setAutomaticallyAdjustsScrollViewInsets:NO]; }

  self.adapter.collectionView = self.collectionView;
}

#pragma mark - <IGListAdapterDataSource>

- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter { return self.data; }

- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object { return T80PostSectionController.new; }

- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter { return nil; }

@end
