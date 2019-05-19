//
//  T078ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import <MJRefresh/MJRefreshNormalHeader.h>
#import <MJRefresh/MJRefreshAutoNormalFooter.h>
#import "T078ViewController.h"
#import "T078RACViewModel.h"
#import "T078Cell.h"

@interface T078ViewController () <UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, weak) UITableView        *tableView;
// viewModel应该由控制器所拥有
@property (nonatomic, strong) T078RACViewModel *viewModel;
@end

@implementation T078ViewController

// 懒加载viewModel对象
- (T078RACViewModel *)viewModel {
  if (!_viewModel) {
    _viewModel = [[T078RACViewModel alloc] init];
  }
  return _viewModel;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  if (@available(iOS 11.0, *)) {
    // 取消自动调整内边距
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  } else {
    self.automaticallyAdjustsScrollViewInsets = NO;
  }
  // add tableView
  {
    UITableViewStyle tableViewStyle = UITableViewStyleGrouped;
    UITableView      *tableView     = [[UITableView alloc] initWithFrame:CGRectZero style:tableViewStyle];
    self.tableView                  = tableView;
    [self setupInit:tableView];
    [self.view addSubview:tableView];

    kMasKey(tableView);
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0));
    }];
  }

  self.tableView.mj_header               = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
  self.tableView.mj_footer               = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
  self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(rightBarButtonItem:)];

  @weakify(self);
  // 上面是获取更多的Command，下面是刷新页面的Command。
  [[self.viewModel.reloadDataCommand.executing skip:1] subscribeNext:^(NSNumber *executing) {
    // NSLog(@"executing = %@", executing);
    @strongify(self);
    if (executing.boolValue) {
      // 正在执行中...
    } else {
      // NSLog(@"结束或未执行");
      [self.tableView.mj_header endRefreshing];
    }
  }];

  NSLog(@"self.viewModel.dataList = %@", self.viewModel.dataList);

  [RACObserve(self.viewModel, dataList) subscribeNext:^(NSArray *array) {
    @strongify(self);
    ILog(@"array = %@", array);
    [self.tableView reloadData];
  }];
}

// 执行加载更多的command和刷新页面的command，实现代码均在viewModel中。
- (void)loadMoreData {
  // [self.viewModel.fetchMoreDataCommand execute:nil];
}

- (void)reloadData {
  NSLog(@"%s", __func__);

  NSLog(@"self.viewModel.reloadDataCommand = %@", self.viewModel.reloadDataCommand);

  [self.viewModel.reloadDataCommand execute:nil];
}

- (void)rightBarButtonItem:(UIBarButtonItem *)sender {
  NSLog(@"%s", __func__);
}

- (void)dealloc {
  NSLog(@"■■■■■■%@ is dead ☠☠☠️■■■■■■", [self class]);
}

/** 初始化 tableView */
- (void)setupInit:(UITableView *)tableView {

  // MARK: - 设置代理
  {
    tableView.delegate   = self;
    tableView.dataSource = self;
  }

  // MARK: - 消除底部分割线
  if (tableView.style == UITableViewStylePlain) {
    tableView.tableFooterView = UIView.new;
  }

  // MARK: - 分割线设置
  {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // tableView.separatorColor = [UIColor greenColor];
  }
  // MARK: - 注册
  {
    /**
     * cell xib 注册 & class 注册
     */
    {
      // registerForCellFromNib(tableView,UITableViewCell);
      registerForCellFromClass(tableView, UITableViewCell.class);
      registerForCellFromClass(tableView, T078Cell.class);
    }
    /**
     * headerSection xib 注册 & class 注册
     */
    {
      // registerForHeaderFooterViewFromNib(tableView,UITableViewHeaderFooterView);
      // registerForHeaderFooterViewFromClass(tableView,UITableViewHeaderFooterView);
    }
    /**
     * footerSection xib 注册 & class 注册
     */
    {
      // registerForHeaderFooterViewFromNib(tableView,UITableViewHeaderFooterView);
      // registerForHeaderFooterViewFromClass(tableView,UITableViewHeaderFooterView);
    }
  }
  //MARK: - 设置高度
  {
    /** header */
    {
      tableView.sectionHeaderHeight = CGFLOAT_MIN;
      // tableView.estimatedSectionHeaderHeight = 100;
      // tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    }
    /** cell */
    {
      // tableView.rowHeight           = 100;
      tableView.estimatedRowHeight = 100;
      tableView.rowHeight          = UITableViewAutomaticDimension;
    }
    /** footer */
    {
      tableView.sectionFooterHeight = CGFLOAT_MIN;
      // tableView.estimatedSectionFooterHeight = 100;
      // tableView.sectionFooterHeight = UITableViewAutomaticDimension;
    }
  }
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>

/** 组数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

  return 1;
}

/** 行数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.viewModel.dataList.count;
}

/** section header height */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
  return CGFLOAT_MIN;
}

/** section footer height */
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
  return CGFLOAT_MIN;
}

/** 自定义 cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  T078Cell *cell = dequeueForCell(tableView, T078Cell.class);
  cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? HexRGBA(@"#F2CDA7", 1.0) : HexRGBA(@"#EA9950", 1.0);
  cell.selectionStyle              = tableView.isEditing ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;
  cell.model = self.viewModel.dataList[indexPath.row];
  return cell;
}

/** 选中一行 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  NSLog(@"%s", __func__);
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewRowAction *deleteAction = [UITableViewRowAction
    rowActionWithStyle:UITableViewRowActionStyleDefault
    title:@"删除"
    handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
      NSLog(@"action = %@", action);

    }];
  UITableViewRowAction *addAction    = [UITableViewRowAction
    rowActionWithStyle:UITableViewRowActionStyleNormal
    title:@"添加"
    handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
      NSLog(@"action = %@", action);

    }];

  return @[
    deleteAction,
    addAction
  ];
}

@end
    