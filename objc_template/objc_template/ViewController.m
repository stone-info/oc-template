//
//  ViewController.m
//  objective_c_template
//
//  Created by stone on 2019/3/27.
//  Copyright © 2019 stone. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
/** tableView */
@property (nonatomic, weak) UITableView                                       *tableView;
@property (strong, nonatomic) NSArray<NSDictionary<NSString *, NSString *> *> *dataList;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.

  self.view.backgroundColor = UIColor.whiteColor;

  // 获取info字典
  NSString * bundlePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
  NSArray * dataList    = [NSArray arrayWithContentsOfFile:bundlePath];

  dataList = (NSMutableArray *) [[dataList reverseObjectEnumerator] allObjects];
  // NSLog(@"dataList = %@", dataList);
  self.dataList = dataList;

  // note:=== table view build === 2019-03-27 ====================================/
  if (@available(iOS 11.0, *)) {
    // 取消自动调整内边距
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  } else {
    self.automaticallyAdjustsScrollViewInsets = NO;
  }
  // add tableView
  {
    /** y坐标 */
    // CGFloat y = 0;
    /** 高度 tableView */
    // CGFloat height = self.view.bounds.size.height - y;
    /** 样式 tableView */
    UITableViewStyle tableViewStyle = UITableViewStyleGrouped;
    //-------------------------------------------------------------------------------------
    // CGRect       frame     = CGRectMake(0, y, self.view.bounds.size.width, height);
    UITableView      *tableView     = [[UITableView alloc] initWithFrame:CGRectZero style:tableViewStyle];
    self.tableView                  = tableView;
    [self setupInit:tableView];
    [self.view addSubview:tableView];
    [self addObserver];
    [self addRequest];

    kMasKey(tableView);
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight+kTabBarHeight, 0));
    }];
  }

  // auto push
  if (kAutoPush) {
      NSDictionary<NSString *, NSString *> *dictionary = self.dataList.firstObject;

      UIViewController *viewController;
      if (dictionary[@"xib"] && [dictionary[@"xib"] boolValue] == YES) {
        /** 根据xib 获取 viewController */
        viewController = [(UIViewController *) [NSClassFromString(dictionary[@"controllerName"]) alloc] initWithNibName:dictionary[@"controllerName"] bundle:nil];
      } else if (dictionary[@"storyboard"] && [dictionary[@"storyboard"] boolValue] == YES) {
        /** 根据storyboard 获取 viewController */
        viewController = [[UIStoryboard storyboardWithName:dictionary[@"controllerName"] bundle:nil] instantiateViewControllerWithIdentifier:dictionary[@"controllerName"]];
      } else {
        viewController = [(UIViewController *) [NSClassFromString(dictionary[@"controllerName"]) alloc] init];
      }
      if (viewController.view.backgroundColor) {
        // 有颜色
      } else {
        viewController.view.backgroundColor = UIColor.whiteColor;
      }

      // NSLog(@"viewController = %@", viewController);

      viewController.title = kStringFormat(@"%03ld-%@", self.dataList.count - 1, dictionary[@"title"]);
      [self.navigationController pushViewController:viewController animated:YES];
  }
}

#pragma mark - <addRequest>

- (void)addRequest {
  // addRequest
}

#pragma mark - <addObserver>

- (void)addObserver {
  // addObserver
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

  // MARK: - 滚动条是否隐藏
  {
    //   tableView.showsVerticalScrollIndicator = NO;
  }

  // MARK: - 设置tableHeaderView
  {
    //   UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    //   tableView.tableHeaderView = tableHeaderView;
  }

  // MARK: - 注册
  { /**
     * cell xib 注册 & class 注册
     */
    {// registerForCellFromNib(tableView,UITableViewCell);
      registerForCellFromClass(tableView, UITableViewCell.class);
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.dataList.count;
}

/** 自定义section header */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
  UITableViewHeaderFooterView *headerView = dequeueForHeaderFooterView(tableView, UITableViewHeaderFooterView.class);
  // SNHeaderView * headerView = [SNHeaderView headerViewWithTableView:tableView];
  return headerView;
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

  UITableViewCell *cell = dequeueForCell(tableView, UITableViewCell.class);
  // SNOldTableViewCell * cell = [SNOldTableViewCell cellWithTableView:tableView];

  // cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? HexRGBA(@"#F2CDA7", 1.0) : HexRGBA(@"#EA9950", 1.0);
  cellDifferentColor(cell, indexPath);

  cell.selectionStyle = tableView.isEditing ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;

  NSUInteger i = self.dataList.count - (NSUInteger) indexPath.row - 1;

  cell.textLabel.text = kStringFormat(@"%03ld-%@", i, self.dataList[(NSUInteger) indexPath.row][@"title"]);
  cell.textLabel.font = kPingFangSCRegular(12);
  // 应用场景, 点击能闪烁一下...没用...
  {
    // 关闭选中效果, 一旦关闭系统的选中效果所有失效.
    // // cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // cell.backgroundColor = indexPath.row % 2 == 0 ? HexRGBA(@"#F2CDA7", 1.0) : HexRGBA(@"#EA9950", 1.0);
    // UIView *selectedBackgroundView = [[UIView alloc] init];
    // selectedBackgroundView.backgroundColor = [UIColor blueColor];
    // cell.selectedBackgroundView            = selectedBackgroundView;
  }

  // 应用场景, 没用, 偷懒的时候用一下
  {
    // cell.accessoryView = [[UISwitch alloc] init]; //优先级高于cell.accessoryType, 即两个同时设置只有accessoryView起作用
    // cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
  }

  // 应用场景, 设置cell背景图片的时候
  {
    // UIView *bgView = [[UIView alloc] init];
    // bgView.backgroundColor = [UIColor orangeColor];
    // cell.backgroundView    = bgView;
    // cell.contentView.backgroundColor 优先级高于 cell.backgroundView 优先级高于 backgroundColor
    // cell.backgroundColor = [UIColor orangeColor];
  }

  return cell;
}


// sn_note:========= 点击cell ============================ stone 🐳 ===========/

/** 选中一行 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  NSLog(@"%s", __func__);

  NSDictionary<NSString *, NSString *> *dictionary = self.dataList[(NSUInteger) indexPath.row];

  UIViewController *viewController;

  if (dictionary[@"xib"] && [dictionary[@"xib"] boolValue] == YES) {
    /** 根据xib 获取 viewController */
    viewController = [(UIViewController *) [NSClassFromString(dictionary[@"controllerName"]) alloc] initWithNibName:dictionary[@"controllerName"] bundle:nil];
  } else if (dictionary[@"storyboard"] && [dictionary[@"storyboard"] boolValue] == YES) {
    /** 根据xib 获取 viewController */
    viewController = [[UIStoryboard storyboardWithName:dictionary[@"controllerName"] bundle:nil] instantiateViewControllerWithIdentifier:dictionary[@"controllerName"]];
  } else {
    viewController = [(UIViewController *) [NSClassFromString(dictionary[@"controllerName"]) alloc] init];
  }

  if (viewController.view.backgroundColor) {
    // 有颜色
  } else {
    viewController.view.backgroundColor = UIColor.whiteColor;
  }

  NSLog(@"viewController = %@", viewController);
  viewController.view.backgroundColor = UIColor.whiteColor;

  NSUInteger i = self.dataList.count - (NSUInteger) indexPath.row - 1;

  viewController.title = kStringFormat(@"%03ld-%@", i, dictionary[@"title"]);
  [self.navigationController pushViewController:viewController animated:YES];

  // 点击删除 单行
  // {
  //
  //   [self.modelList removeObjectAtIndex:indexPath.row];
  //   [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]]
  //                         withRowAnimation:UITableViewRowAnimationAutomatic];
  // }
  // 点击删除 多行
  // {
  //   NSMutableArray *discardedItems = [NSMutableArray array];
  //
  //   [self.modelList enumerateObjectsUsingBlock:^(DeleteElementModel *obj, NSUInteger idx, BOOL *stop) {
  //     if (idx == 0 || idx == 1) {
  //       [discardedItems addObject:obj];
  //     }
  //   }];
  //
  //   [self.modelList removeObjectsInArray:discardedItems];
  //
  //   [self.tableView deleteRowsAtIndexPaths:@[
  //     [NSIndexPath indexPathForRow:0 inSection:0],
  //     [NSIndexPath indexPathForRow:1 inSection:0]
  //   ]                     withRowAnimation:UITableViewRowAnimationAutomatic];
  // }

  // [tableView cellForRowAtIndexPath:indexPath];
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/** 取消 选中 */
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

  NSLog(@"%s", __func__);
}

// sn_note:========= 滑动删除 ============================ stone 🐳 ===========/

// /** 可编辑 */
// - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//
//   //第二组可以左滑删除
//   // if (indexPath.section == 1) { return YES; }
//   // 默认所有行 都可编辑
//   return YES;
// }
//
// /** 左滑出现的按钮是删除 or 添加 */
// - (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//   return UITableViewCellEditingStyleDelete;
// }
//
// /** 删除当前行 */
// - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//
//   if (editingStyle == UITableViewCellEditingStyleDelete) {
//     [self.modelList removeObjectAtIndex:indexPath.row];
//     [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//   }
//   if (editingStyle == UITableViewCellEditingStyleInsert) {
//
//   }
// }
// // 修改编辑按钮文字
// - (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//   return @"删除";
// }

// sn_note:========= 滑动删除 方法2: 自定义方法(实现此方法 系统方法失效) ============================ stone 🐳 ===========/

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                             title:@"删除"
                                                             handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                               NSLog(@"action = %@", action);

                                                             }];
  UITableViewRowAction *addAction    = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal
                                                             title:@"添加"
                                                             handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                               NSLog(@"action = %@", action);

                                                             }];

  return @[deleteAction, addAction];
}

// sn_note:========= 索引条 ============================ stone 🐳 ===========/

// 应用场景: plan模式下, 右侧index能点击, 也有置顶效果
// - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//   SNIndexModel *model = self.modelList[section];
//   return model.title;
// }
// /**
//  *  返回索引条的文字
//  */
// - (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//
//   NSMutableArray<NSString *> *titles = [NSMutableArray array];
//   [self.modelList enumerateObjectsUsingBlock:^(SNIndexModel *obj, NSUInteger idx, BOOL *stop) {
//     [titles addObject:obj.title];
//   }];
//   return titles;
//
//   // 抽取self.modelList 这个数组中每一个元素(SNIndexModel对象)的title属性的值,放在一个新的数组中返回
//   // return [self.modelList valueForKeyPath:@"title"];
// }

@end
