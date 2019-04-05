//
//  T016ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T016ViewController.h"
#import "SNTableFooterView.h"

@interface T016ViewController () <UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, weak) UITableView                                       *tableView;
@property (strong, nonatomic) NSArray<NSDictionary<NSString *, NSString *> *> *modelList;
@end

@implementation T016ViewController
- (NSArray<NSDictionary<NSString *, NSString *> *> *)modelList {
  /** _modelList lazy load */

  if (_modelList == nil) {
    _modelList = @[
      @{
        @"title"         : @"scrollView 纵向滚动---xib",
        @"viewController": @"ScrollViewVerticalLayoutWithXibViewController"
      },
      @{
        @"title"         : @"scrollView 横向滚动---xib",
        @"viewController": @"ScrollViewHorizontalLayoutWithXibViewController"
      },
      @{
        @"title"         : @"scrollView 纵向滚动---Masonry",
        @"viewController": @"ScrollViewVerticalLayoutWithMasonryViewController"
      },
      @{
        @"title"         : @"scrollView 横向滚动---Masonry",
        @"viewController":
        @"ScrollViewHorizontalLayoutWithMasonryViewController"
      },
      @{
        @"title"         : @"scrollView 纵向滚动---xib + Masonry",
        @"viewController":
        @"ScrollViewVerticalLayoutWithXibAndMasonryViewController"
      },
      @{
        @"title"         : @"scrollView 横向滚动---xib + Masonry",
        @"viewController":
        @"ScrollViewHorizontalLayoutWithXibAndMasonryViewController"
      },
    ];
  }
  return _modelList;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  if (@available(iOS 11.0, *)) {
    // 取消自动调整内边距
    self.tableView.contentInsetAdjustmentBehavior =
      UIScrollViewContentInsetAdjustmentNever;
  } else {
    self.automaticallyAdjustsScrollViewInsets = NO;
  }
  // add tableView
  {
    /** y坐标 */
    CGFloat          y              = 0;
    /** 高度 tableView */
    CGFloat          height         = self.view.bounds.size.height - y;
    /** 样式 tableView */
    UITableViewStyle tableViewStyle = UITableViewStyleGrouped;
    //-------------------------------------------------------------------------------------
    CGRect           frame          = CGRectMake(0, y, self.view.bounds.size.width, height);
    UITableView      *tableView     =
                       [[UITableView alloc] initWithFrame:frame style:tableViewStyle];
    self.tableView                  = tableView;
    [self setupInit:tableView];
    [self.view addSubview:tableView];
  }

  self.navigationItem.title = @"scrollView demo";
}

- (void)dealloc {
  NSLog(@"■■■■■■\t%@ is dead ☠☠☠\t■■■■■■", [self class]);
}

/** 初始化 tableView */
- (void)setupInit:(UITableView *)tableView {
  // MARK: - 设置代理
  {
    tableView.delegate   = self;
    tableView.dataSource = self;
  }

  // MARK: - 消除底部分割线
  {
    SNTableFooterView *tableFooterView = [SNTableFooterView tableFooterView];
    tableView.tableFooterView = tableFooterView;
    [tableFooterView layoutIfNeeded];
    tableFooterView.frame = CGRectMake(0, 0, self.view.bounds.size.width,
                                       tableFooterView.suggestHeight);
  }

  // MARK: - 分割线设置
  {
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    // tableView.separatorColor = [UIColor greenColor];
  }

  // MARK: - 滚动条是否隐藏
  {
    //   tableView.showsVerticalScrollIndicator = NO;
  }

  // MARK: - 设置tableHeaderView
  {
    //   UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0,
    //   0, 0, 0)];
    //   tableView.tableHeaderView = tableHeaderView;
  }

  // MARK: - 注册
  { /**
     * cell xib 注册 & class 注册
     */
    {// registerForCellFromeNib(tableView,UITableViewCell);
      registerForCellFromClass(tableView, UITableViewCell.class);
    }
    /**
     * headerSection xib 注册 & class 注册
     */
    {
      // registerForHeaderFooterViewFromeNib(tableView,UITableViewHeaderFooterView);
      // registerForHeaderFooterViewFromeClass(tableView,UITableViewHeaderFooterView);
    }
    /**
     * footerSection xib 注册 & class 注册
     */
    {
      // registerForHeaderFooterViewFromeNib(tableView,UITableViewHeaderFooterView);
      // registerForHeaderFooterViewFromeClass(tableView,UITableViewHeaderFooterView);
    }
  }
  // MARK: - 设置高度
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
- (NSInteger)tableView:(UITableView *)tableView
             numberOfRowsInSection:(NSInteger)section {
  return self.modelList.count;
}

/** 自定义section header */
- (UIView *)tableView:(UITableView *)tableView
            viewForHeaderInSection:(NSInteger)section {
  UITableViewHeaderFooterView *headerView =
                                dequeueForHeaderFooterView(tableView, UITableViewHeaderFooterView.class);
  // SNHeaderView * headerView = [SNHeaderView
  // headerViewWithTableView:tableView];
  return headerView;
}

/** section header height */
- (CGFloat)tableView:(UITableView *)tableView
           heightForHeaderInSection:(NSInteger)section {
  return CGFLOAT_MIN;
}

/** section footer height */
- (CGFloat)tableView:(UITableView *)tableView
           heightForFooterInSection:(NSInteger)section {
  return CGFLOAT_MIN;
}

/** 自定义 cell */
- (UITableViewCell *)tableView:(UITableView *)tableView
                     cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = dequeueForCell(tableView, UITableViewCell.class);
  cell.contentView.backgroundColor =
    indexPath.row % 2 == 0 ? HexRGBA(@"#F2CDA7", 1.0) : HexRGBA(@"#EA9950", 1.0);
  cell.selectionStyle = tableView.isEditing
    ? UITableViewCellSelectionStyleDefault
    : UITableViewCellSelectionStyleNone;
  cell.textLabel.text = self.modelList[(NSUInteger) indexPath.row][@"title"];
  cell.textLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
  return cell;
}

// sn_note:========= 点击cell ============================ stone 🐳 ===========/

/** 选中一行 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSDictionary<NSString *, NSString *> *obj        = self.modelList[(NSUInteger) indexPath.row];
  __kindof UIViewController            *controller = (__kindof UIViewController *) ([[NSClassFromString(obj[@"viewController"]) alloc] init]);
  controller.navigationItem.title = obj[@"title"];
  [self.navigationController pushViewController:controller animated:YES];
}

@end
