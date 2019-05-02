//
//  SNSwipeCollectionViewCell.m
//  objc_template
//
//  Created by stone on 2019/5/1.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNSwipeCollectionViewCell.h"
#import "SNSwipeTableView.h"

@interface SNSwipeCollectionViewCell () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic, readwrite) UITableView *tableView;
@property (nonatomic, weak) id <NSObject>          notifyObserver;
@end

@implementation SNSwipeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    UITableView *tableView = UITableView.new;
    self.tableView = tableView;
    [self.contentView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.insets(UIEdgeInsetsZero); }];
    [self addBorder:tableView];

    tableView.delegate   = self;
    tableView.dataSource = self;

    // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // tableView.separatorColor = [UIColor greenColor];
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:NSStringFromClass(UITableViewCell.class)];

    self.notifyObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"table-view-send" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {

      NSLog(@"note = %@", note);

      UITableView *o = note.userInfo[@"sender"];

      if (o == self.tableView) { return; }

      UITableView *tableViewB = self.tableView;

      CGRect rect       = [tableViewB rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
      // cell 0 的位置
      CGRect cell0React = [tableViewB convertRect:rect toView:self.contentView];
      // NSLogRect(convertRect);

      // headerView 的位置
      CGRect frameB = self.headerView.frame;
      if (cell0React.origin.y > CGRectGetMaxY(frameB)) {
        CGPoint point = tableViewB.contentOffset;
        point.y = CGRectGetMaxY(frameB);
        [tableViewB setContentOffset:point];
      }

      // CGPoint point = tableViewB.contentOffset;
      // point.y = CGRectGetMaxY(frameB);
      // [tableViewB setContentOffset:point];

      //
      // // [tableViewB reloadData];
    }];
  }

  return self;
}

- (void)setTitle:(NSString *)title {
  _title = [title mutableCopy];

  [self.tableView reloadData];
}

- (void)dealloc {
  @try {
    [[NSNotificationCenter defaultCenter] removeObserver:self.notifyObserver name:@"table-view-send" object:nil];
  }
  @catch (NSException *exception) {
    NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
  }
}

- (void)addBorder:(__kindof UIView *)view {
  view.layer.borderWidth   = 1.0;
  view.layer.borderColor   = UIColor.grayColor.CGColor;
  view.layer.cornerRadius  = 4.0;
  view.layer.masksToBounds = YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 22;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(UITableViewCell.class)];

  cell.textLabel.text = kStringFormat(@"%@ - %ld", self.title, indexPath.row);

  return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 60;
}

// - (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//   return @"hello world";
// }

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  // NSLog(@"scrollView.contentOffset.y = %lf", scrollView.contentOffset.y);

  // CGFloat headerViewHeight = self.headerView.height;
  //
  // CGFloat y = scrollView.contentOffset.y + headerViewHeight;
  //
  // CGRect frame = self.headerView.frame;
  //
  // frame.origin.y = -y;
  //
  // self.headerView.frame = frame;
  // - (CGRect)rectForRowAtIndexPath:(NSIndexPath *)indexPath;

  UITableView *tableView = (UITableView *) scrollView;
  CGRect      rect       = [tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

  // cell 0 的位置
  CGRect cell0React = [tableView convertRect:rect toView:self.contentView];
  // NSLogRect(convertRect);

  // headerView 的位置
  CGRect frame = self.headerView.frame;

  if (cell0React.origin.y >= CGRectGetMaxY(frame)) {
    frame.origin.y        = cell0React.origin.y - frame.size.height;
    self.headerView.frame = frame;
  } else {
    if (CGRectGetMaxY(frame) <= 0) {

    } else {
      frame.origin.y        = cell0React.origin.y - frame.size.height;
      self.headerView.frame = frame;
    }
  }



  // printf("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■\n");
  // frame.origin.y = cell0React.origin.y - frame.size.height;
  // self.headerView.frame = frame;

}

// 即将拖拽
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  NSLog(@"%s", __func__);

  NSLog(@"self.title = %@", self.title);
}

// 即将停止拖拽
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
  NSLog(@"%s", __func__);
}

// 已经停止拖拽(可能没有加速度)
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

  // decelerate 判断是否有惯性
  // NSLog(@"%s,%d", __func__, decelerate);
  if (decelerate) {
    NSLog(@"用户已经停止拖拽, 没有停止滚动(有惯性,去scrollViewDidEndDecelerating判断是否滚动结束)");
  } else {
    NSLog(@"用户已经停止拖拽, 停止滚动(没有惯性)");
    [self callWhenTheScrollEnds:scrollView];
  }
}

// custom method
- (void)callWhenTheScrollEnds:(UIScrollView *)scrollView {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"table-view-send" object:nil userInfo:@{@"sender": self.tableView}];
}

// 减速完毕(没有加速度就不调用, 所以看情况判断是否停止滚动)
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  NSLog(@"%s", __func__);
  [self callWhenTheScrollEnds:scrollView];
}
@end
