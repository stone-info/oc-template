//
//  SNOldTableView.m
//  006_UIAdvanced
//
//  Created by stone on 2018/8/7.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "SNOldTableView.h"

@interface SNOldTableView ()

@end

@implementation SNOldTableView

- (instancetype)initWithFrame:(CGRect)frame
                        style:(UITableViewStyle)style {
  self = [super initWithFrame:frame
                        style:style];
  if (self) {

    self.delegate   = self;
    self.dataSource = self;
    [self addObserver];
    [self addRequest];
    [self setupInit:self];
  }
  return self;
}

- (void)dealloc {
  NSLog(@"■■■■■■%@ is dead ☠☠☠️■■■■■■", [self class]);
}

#pragma mark - <addRequest>

- (void)addRequest {
  // addRequest
}

#pragma mark - <addObserver>

- (void)addObserver {
  // addObserver
}

/** 初始化 tableView */
- (void)setupInit:(UITableView *)tableView {

  // MARK: - 消除底部分割线
  if (tableView.style == UITableViewStylePlain) {
    tableView.tableFooterView = UIView.new;
  }

  // MARK: - 分割线设置
  {
    // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
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
  {
    /**
     * cell xib 注册 & class 注册
     */
    {
      // registerForCellFromNib(tableView,UITableViewCell);
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

/** 组数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

  return 1;
}

/** 行数 */
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return 22;
}

/** 自定义section header */
- (UIView *) tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
  UITableViewHeaderFooterView *headerView = dequeueForHeaderFooterView(tableView,UITableViewHeaderFooterView.class);
  // SNHeaderView * headerView = [SNHeaderView headerViewWithTableView:tableView];
  return headerView;
}

/** section header height */
- (CGFloat)    tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
  return CGFLOAT_MIN;
}

/** section footer height */
- (CGFloat)    tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {
  return CGFLOAT_MIN;
}

/** 自定义 cell */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewCell *cell = dequeueForCell(tableView,UITableViewCell.class);
  // SNOldTableViewCell * cell = [SNOldTableViewCell cellWithTableView:tableView];

  cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? HexRGBA(@"#F2CDA7", 1.0) : HexRGBA(@"#EA9950", 1.0);
  cell.selectionStyle              = tableView.isEditing ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;

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

//sn_note:========= 点击cell ============================ stone 🐳 ===========/

/** 选中一行 */
- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  NSLog(@"%s", __func__);

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
  [tableView deselectRowAtIndexPath:indexPath
                           animated:YES];
}

/** 取消 选中 */
- (void)        tableView:(UITableView *)tableView
didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {

  NSLog(@"%s", __func__);
}

//sn_note:========= 滑动删除 ============================ stone 🐳 ===========/

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

//sn_note:========= 滑动删除 方法2: 自定义方法(实现此方法 系统方法失效) ============================ stone 🐳 ===========/

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
                           editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

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

  return @[
    deleteAction,
    addAction
  ];
}

//sn_note:========= 索引条 ============================ stone 🐳 ===========/

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
