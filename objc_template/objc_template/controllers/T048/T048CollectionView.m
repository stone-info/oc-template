//
//  T048CollectionView.m
//  objc_template
//
//  Created by stone on 2019/5/2.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T048CollectionView.h"

@interface T048CollectionView () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>


@end

@implementation T048CollectionView
+ (instancetype)collectionView {

  // make layout
  UICollectionViewFlowLayout *flowLayout     = UICollectionViewFlowLayout.new;
  // make collection view
  T048CollectionView         *collectionView = [[T048CollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
  [collectionView setupInitLayout:flowLayout];
  // set attribute
  [collectionView setupInit:collectionView];


  // [[NSNotificationCenter defaultCenter] addObserver:collectionView selector:@selector(notificationHandler:) name:@"category-view-send" object:nil];

  return collectionView;
}


- (void)notificationHandler:(NSNotification *)sender {

  NSLog(@"%s", __func__);

  // NSLog(@"sender = %@", sender);
  NSNumber *number = sender.userInfo[@"index"];

  NSInteger index = number.integerValue;

  NSIndexPath * indexPath = [NSIndexPath indexPathForRow:index inSection:0];
  [self selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];

}

- (void)dealloc {
  @try {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"category-view-send" object:nil];
  }
  @catch (NSException *exception) {
    NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
  }
}

/** 初始化 layout */
- (void)setupInitLayout:(UICollectionViewFlowLayout *)flowLayout {
  // 滚动方向
  flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

  CGFloat lineSpacing = 0;
  CGFloat itemSpacing = 0;

  // flowLayout.itemSize = self.bounds.size;

  if (flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
    // 设置最小行间距, 最小的时候是此数据,表示可以比这个大或者0
    flowLayout.minimumLineSpacing      = itemSpacing;
    // 设置最小的item间距,, 最小的时候是此数据,表示可以比这个大或者0
    flowLayout.minimumInteritemSpacing = lineSpacing;
  } else {
    // 设置最小行间距, 最小的时候是此数据,表示可以比这个大或者0
    flowLayout.minimumLineSpacing      = lineSpacing;
    // 设置最小的item间距,, 最小的时候是此数据,表示可以比这个大或者0
    flowLayout.minimumInteritemSpacing = itemSpacing;
  }

  // section 内边距(这个好用啊!! tableView section间距只能用sectionView撑大,这个竟然可以两者兼并)
  flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

/** 初始化 collectionView */
- (void)setupInit:(UICollectionView *)collectionView {
  collectionView.backgroundColor                = [UIColor grayColor];
  collectionView.showsHorizontalScrollIndicator = NO;
  collectionView.pagingEnabled                  = YES;
  // MARK: - 设置代理
  {
    collectionView.dataSource = self;
    collectionView.delegate   = self;
  }
  // MARK: - 注册
  {
    /**
     * cell xib 注册 & class 注册
     */
    {
      registerForCollectionCellFromClass(collectionView, UICollectionViewCell.class);
    }
  }
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

  // 使用 包含 forIndexPath 的方法, 必须得注册 不管是 tableView, 还是collectionView
  UICollectionViewCell *collectionViewCell = dequeueForCollectionCell(collectionView, UICollectionViewCell.class, indexPath);

  collectionViewCell.contentView.backgroundColor = indexPath.row % 2 == 0 ? HexRGBA(@"#F2CDA7", 1.0) : HexRGBA(@"#EA9950", 1.0);

  return collectionViewCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

  return collectionView.bounds.size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  CGFloat   offsetX = scrollView.contentOffset.x;
  NSInteger index   = (NSInteger) (offsetX / scrollView.bounds.size.width + 0.5);
  [[NSNotificationCenter defaultCenter] postNotificationName:@"collection-view-send" object:nil userInfo:@{@"index": @(index)}];
}


@end
