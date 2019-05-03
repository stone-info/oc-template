//
//  SNSwipeTableView.m
//  objc_template
//
//  Created by stone on 2019/5/1.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNSwipeTableView.h"
#import "SNSwipeCollectionViewCell.h"

@interface SNSwipeTableView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UICollectionView             *contentView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) UITableView                  *currentItemView;
/**
 *  自定义显示在swipeView顶端的headerView，可以通过setter方法动态设置
 *  如果想要支持拖动swipeHeaderView，滚动当前页面的currentItemView，需要自定义的header继承自'STHeaderView'，或者以'STHeaderView'的实例作为父视图
 */
@property (nonatomic, strong) UIView                     *swipeHeaderView;

/**
 *  自定义显示在swipeView顶端的headerBar，可以通过setter方法动态设置
 */
@property (nonatomic, weak) UIView *swipeHeaderBar;

/**
 *  swipeView顶端headerView顶部的留白inset，这个属性可以设置顶部导航栏的inset，默认是 64
 */
@property (nonatomic, assign) CGFloat                    swipeHeaderTopInset;
@property (nonatomic, assign) CGFloat                    headerInset;
@property (nonatomic, assign) CGFloat                    barInset;
@property (strong, nonatomic) NSMutableArray<NSString *> *dataList;
@end

@implementation SNSwipeTableView {
  dispatch_once_t _onceToken;
}

- (UIView *)swipeHeaderView {
  if (_swipeHeaderView == nil) {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 200)];
    _swipeHeaderView = view;
    view.backgroundColor = UIColor.orangeColor;
    kBorder(view);
  }
  return _swipeHeaderView;
}

- (UICollectionViewFlowLayout *)layout {

  if (_layout == nil) {
    _layout = [UICollectionViewFlowLayout new];
    _layout.scrollDirection         = UICollectionViewScrollDirectionHorizontal;
    _layout.minimumLineSpacing      = 0;
    _layout.minimumInteritemSpacing = 0;
    _layout.sectionInset            = UIEdgeInsetsZero;

    NSLogSize(self.bounds.size);

    _layout.itemSize = self.bounds.size;
  }
  return _layout;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self initData];
  }
  return self;
}

- (void)initData {

  self.dataList = [NSMutableArray array];

  for (NSUInteger i = 0; i < 22; ++i) {
    [self.dataList addObject:kStringFormat(@"%lu", i)];
  }
}

- (void)dealloc {
  WLog(@"■■■■■■\t%@ is dead ☠☠☠\t■■■■■■", [self class]);
}

- (void)layoutSubviews {
  [super layoutSubviews];
  WLog(@"%s", __func__);

  dispatch_once(&_onceToken, ^{
    [self commonInit];
  });

}

- (void)commonInit {
  // collection view
  UICollectionView *contentView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
  self.contentView                           = contentView;
  contentView.autoresizingMask               = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  contentView.backgroundColor                = [UIColor clearColor];
  // contentView.backgroundColor = [UIColor orangeColor];
  contentView.showsHorizontalScrollIndicator = NO;
  contentView.pagingEnabled                  = YES;
  contentView.scrollsToTop                   = NO;
  contentView.delegate                       = self;
  contentView.dataSource                     = self;
  [contentView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
  [contentView registerClass:SNSwipeCollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(SNSwipeCollectionViewCell.class)];
  // disable cell prefetching after iOS10.
  if ([contentView respondsToSelector:@selector(setPrefetchingEnabled:)]) { contentView.prefetchingEnabled = NO; }
  // 添加一个空白视图，抵消iOS7后导航栏对scrollview的insets影响 - (void)automaticallyAdjustsScrollViewInsets:
  UIScrollView *autoAdjustInsetsView = [UIScrollView new];
  autoAdjustInsetsView.scrollsToTop = NO;

  [self addSubview:autoAdjustInsetsView];
  [self addSubview:contentView];

  kMasKey(contentView);
  [contentView mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.insets(UIEdgeInsetsZero); }];

  // self.contentOffsetQuene  = [NSMutableDictionary dictionaryWithCapacity:0];
  // self.contentSizeQuene    = [NSMutableDictionary dictionaryWithCapacity:0];
  // self.contentMinSizeQuene = [NSMutableDictionary dictionaryWithCapacity:0];
  // _swipeHeaderTopInset        = iPhoneX ? 88 : 64;
  // _headerInset                = 0;
  // _barInset                   = 0;
  // _currentItemIndex           = 0;
  // _switchPageWithoutAnimation = YES;
  // _cunrrentItemIndexpath      = [NSIndexPath indexPathForItem:0 inSection:0];

  NSLog(@"self.swipeHeaderView = %@", self.swipeHeaderView);
  [self addSubview:self.swipeHeaderView];

  self.swipeHeaderTopInset = kStatusBarHeight + kNavigationBarHeight;
  self.headerInset         = self.swipeHeaderView.bounds.size.height;

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

  return self.dataList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

  // UICollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];
  SNSwipeCollectionViewCell *collectionViewCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(SNSwipeCollectionViewCell.class) forIndexPath:indexPath];
  collectionViewCell.contentView.backgroundColor = indexPath.item % 2 == 0 ? HexRGBA(@"#F2CDA7", 1.0) : HexRGBA(@"#EA9950", 1.0);
  collectionViewCell.headerView                  = self.swipeHeaderView;

  collectionViewCell.title = self.dataList[indexPath.item];

  NSLog(@"collectionViewCell.title = %@", collectionViewCell.title);

  UITableView *tableView = collectionViewCell.tableView;

  tableView.contentInset = UIEdgeInsetsMake(self.headerInset, 0, 0, 0);
  // self.currentItemView   = tableView;
  // CGFloat headerOffsetY = -(self.headerInset + self.swipeHeaderTopInset + self.barInset);
  // NSLog(@"tableView = %@", tableView);

  // tableView.contentOffset = CGPointMake(0, -self.headerInset);

  return collectionViewCell;
}

// 监听滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  // NSLog(@"%s", __func__);
}

// 即将拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  // NSLog(@"%s", __func__);
  [[NSNotificationCenter defaultCenter] postNotificationName:@"table-view-send" object:nil userInfo:@{@"sender": self}];

}

// 即将停止拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
  // NSLog(@"%s", __func__);
}

// 已经停止拖拽(可能没有加速度)
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

  // decelerate 判断是否有惯性
  // NSLog(@"%s,%d", __func__, decelerate);
  if (decelerate) {
    // NSLog(@"用户已经停止拖拽, 没有停止滚动(有惯性,去scrollViewDidEndDecelerating判断是否滚动结束)");
  } else {
    // NSLog(@"用户已经停止拖拽, 停止滚动(没有惯性)");
    [self callWhenTheScrollEnds:scrollView];
  }
}

// custom method
- (void)callWhenTheScrollEnds:(UIScrollView *)scrollView {
  NSUInteger index = (NSUInteger) (scrollView.contentOffset.x / kScreenWidth);
  // NSLog(@"轮到 index = %lu 的view发送网络请求", index);

  // UICollectionView *collectionView = (UICollectionView *) scrollView;
  // NSLog(@"collectionView = %@", collectionView);
  // SNSwipeCollectionViewCell *collectionViewCell = (SNSwipeCollectionViewCell *) [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
  // NSLog(@"collectionViewCell = %@", collectionViewCell);
  // collectionViewCell.title = kStringFormat(@"%lu", index);
  // UITableView *tableView = collectionViewCell.tableView;
  //
  // self.currentItemView = tableView;
  //
  // CGRect rect       = [tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
  // // cell 0 的位置
  // CGRect cell0React = [tableView convertRect:rect toView:collectionView];
  // // NSLogRect(convertRect);
  //
  // // headerView 的位置
  // CGRect frame = self.swipeHeaderView.frame;
  // if (cell0React.origin.y > CGRectGetMaxY(frame)) {
  //   CGPoint point = tableView.contentOffset;
  //   point.y = CGRectGetMaxY(frame);
  //   [tableView setContentOffset:point];
  // }
  //
  // [tableView reloadData];
}

// 减速完毕(没有加速度就不调用, 所以看情况判断是否停止滚动)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  // NSLog(@"%s", __func__);
  [self callWhenTheScrollEnds:scrollView];
}


@end
