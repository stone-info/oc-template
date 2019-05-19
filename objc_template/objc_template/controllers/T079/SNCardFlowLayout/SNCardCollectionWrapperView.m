//
//  SNCardCollectionWrapperView.m
//  XLCardSwitchDemo
//
//  Created by Apple on 2017/1/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "SNCardCollectionWrapperView.h"
#import "SNCardFlowLayout.h"
#import "SNCardCell.h"

@interface SNCardCollectionWrapperView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (assign, nonatomic) CGFloat dragStartX;
@property (assign, nonatomic) CGFloat dragEndX;
@end

@implementation SNCardCollectionWrapperView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    [self buildUI];
  }
  return self;
}

- (void)buildUI {
  [self addCollectionView];
}

- (void)addCollectionView {
  //避免UINavigation对UIScrollView产生的便宜问题
  [self addSubview:[UIView new]];
  SNCardFlowLayout *flowLayout = [[SNCardFlowLayout alloc] init];
  _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
  kBorder(_collectionView);
  _collectionView.showsHorizontalScrollIndicator = false;
  _collectionView.backgroundColor                = [UIColor clearColor];
  [_collectionView registerClass:[SNCardCell class] forCellWithReuseIdentifier:@"SNCardCell"];
  _collectionView.userInteractionEnabled = true;
  _collectionView.delegate               = self;
  _collectionView.dataSource             = self;
  [self addSubview:_collectionView];
}

#pragma mark -
#pragma mark Setter

- (void)setItems:(NSArray<SNCardItemMoel *> *)items {
  _items = items;
  [_collectionView reloadData];
}

#pragma mark -
#pragma mark CollectionDelegate

//配置cell居中
- (void)fixCellToCenter {
  //最小滚动距离
  float dragMiniDistance = self.bounds.size.width / 20.0f;
  if (_dragStartX - _dragEndX >= dragMiniDistance) {
    _selectedIndex -= 1;//向右
  } else if (_dragEndX - _dragStartX >= dragMiniDistance) {
    _selectedIndex += 1;//向左
  }
  NSInteger maxIndex = [_collectionView numberOfItemsInSection:0] - 1;
  _selectedIndex = _selectedIndex <= 0 ? 0 : _selectedIndex;
  _selectedIndex = _selectedIndex >= maxIndex ? maxIndex : _selectedIndex;
  [self scrollToCenter];
}

//滚动到中间
- (void)scrollToCenter {

  [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];

  [self performDelegateMethod];
}

#pragma mark -
#pragma mark CollectionDelegate

//在不使用分页滚动的情况下需要手动计算当前选中位置 -> _selectedIndex
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  if (_pagingEnabled) { return; }
  if (!_collectionView.visibleCells.count) { return; }
  if (!scrollView.isDragging) { return; }
  CGRect currentRect = _collectionView.bounds;
  currentRect.origin.x = _collectionView.contentOffset.x;
  for (SNCardCell *card in _collectionView.visibleCells) {
    if (CGRectContainsRect(currentRect, card.frame)) {
      NSInteger index = [_collectionView indexPathForCell:card].row;
      if (index != _selectedIndex) {
        _selectedIndex = index;
      }
    }
  }
}

//手指拖动开始
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  _dragStartX = scrollView.contentOffset.x;
}

//手指拖动停止
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  if (!_pagingEnabled) { return; }
  _dragEndX = scrollView.contentOffset.x;
  dispatch_async(dispatch_get_main_queue(), ^{
    [self fixCellToCenter];
  });
}

//点击方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  _selectedIndex = indexPath.row;
  [self scrollToCenter];
}

#pragma mark -
#pragma mark CollectionDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return _items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *cellId = @"SNCardCell";
  SNCardCell      *card   = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
  card.model = _items[indexPath.row];
  return card;
}

#pragma mark -
#pragma mark 功能方法

- (void)setSelectedIndex:(NSInteger)selectedIndex {
  [self switchToIndex:selectedIndex animated:false];
}

- (void)switchToIndex:(NSInteger)index animated:(BOOL)animated {
  _selectedIndex = index;
  [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
  [self performDelegateMethod];
}

- (void)performDelegateMethod {
  if ([_delegate respondsToSelector:@selector(SNCardDidSelectedAt:)]) {
    [_delegate SNCardDidSelectedAt:_selectedIndex];
  }
}


@end
