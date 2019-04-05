//
//  T024ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T024ViewController.h"
#import "SNTableView.h"

@interface T024ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) SNTableView *tableView;
// @property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation T024ViewController

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];
  if (@available(iOS 11.0, *)) {
    //Account for possible notch
    UIEdgeInsets safeArea = [[UIApplication sharedApplication] keyWindow].safeAreaInsets;
    NSLog(@"%f", safeArea.bottom);
  }
}

- (void)viewDidLoad {
  [super viewDidLoad];


  // Do any additional setup after loading the view from its nib.
  SNTableView *tableView = [SNTableView makeTableViewWithOptions:@{
    @"style"                : @(UITableViewStyleGrouped),
    // @"frame"                : sn.valueWithCGRect(CGRectMake(0, kStatusNavigationBarHeight, kScreenWidth, kSafeAreaContainerViewHeight)),

    /** 数据源 */
    @"delegate"             : self,
    @"dataSource"           : self,

    /** 注册 class */
    @"registerCellFromClass": UITableViewCell.class,
    // @"registerHeaderFromClass"     : UITableViewHeaderFooterView.class,
    // @"registerFooterFromClass"     : UITableViewHeaderFooterView.class,

    /** 注册 xib */
    // @"registerCellFromNib"         : UITableViewCell.class,
    // @"registerHeaderFromNib"       : UITableViewHeaderFooterView.class,
    // @"registerFooterFromNib"       : UITableViewHeaderFooterView.class,

    /** 上下view */
    // @"tableFooterView"             : UIView.new, // if (tableView.style == UITableViewStylePlain) { tableView.tableFooterView = UIView.new; }
    // @"tableHeaderView"             : UIView.new,

    /** 分割线 */
    // @"separatorStyle"              : @(UITableViewCellSeparatorStyleNone),
    // @"separatorInset"              : sn.valueWithUIEdgeInsets(UIEdgeInsetsZero),
    // @"separatorColor"              : HexRGBA(@"#CCCCCC", 1.0),
    // @"showsVerticalScrollIndicator": @(NO),

    /** section header height */
    @"sectionHeaderHeight"  : @(0.001),
    // @"sectionHeaderHeight"         : @(100),
    // @"sectionHeaderHeight"         : @(UITableViewAutomaticDimension),
    // @"estimatedSectionHeaderHeight": @(100),

    /** section footer height */
    @"sectionFooterHeight"  : @(0.001),
    // @"sectionFooterHeight"         : @(100),
    // @"sectionFooterHeight"         : @(UITableViewAutomaticDimension),
    // @"estimatedSectionFooterHeight": @(100),

    /** cell height */
    @"rowHeight"            : @(100),
    // @"estimatedRowHeight"   : @(100),
    // @"rowHeight"            : @(UITableViewAutomaticDimension),
  }];

  self.tableView = tableView;
  [self.view addSubview:tableView];

  [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.insets(UIEdgeInsetsZero);
    // make.center.mas_equalTo(self.view);

    /** full */
    // make.top.mas_equalTo(self.view.mas_top).offset(0);
    // make.left.mas_equalTo(self.view.mas_left).offset(0);
    // make.right.mas_equalTo(self.view.mas_right).offset(0);
    // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

    /** width & height */
    // make.width.mas_equalTo(100);
    // make.height.mas_equalTo(100);
    // make.size.mas_equalTo(100);
  }];

}

- (void)dealloc {
  NSLog(@"■■■■■■%@ is dead ☠☠☠️■■■■■■", [self class]);
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>

/** section header height */
- (CGFloat)    tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {

  if ([tableView valueForKey:@"options"][@"sectionHeaderHeight"]) {
    return [[tableView valueForKey:@"options"][@"sectionHeaderHeight"] floatValue];
  } else {
    return 0.001;
  }
}

/** section footer height */
- (CGFloat)    tableView:(UITableView *)tableView
heightForFooterInSection:(NSInteger)section {

  if ([tableView valueForKey:@"options"][@"sectionFooterHeight"]) {
    return [[tableView valueForKey:@"options"][@"sectionFooterHeight"] floatValue];
  } else {
    return 0.001;
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

/** 自定义 cell */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewCell *cell = sn.dequeueForCell(tableView, UITableViewCell.class);
  cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? HexRGBA(@"#F2CDA7", 1.0) : HexRGBA(@"#EA9950", 1.0);
  cell.selectionStyle              = tableView.isEditing ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;

  return cell;
}

/** 选中一行 */
- (void)      tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

/** 取消 选中 */
- (void)        tableView:(UITableView *)tableView
didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
  NSLog(@"%s", __func__);
}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView
                           editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {

  UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
    NSLog(@"action = %@", action);
  }];
  UITableViewRowAction *addAction    = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"添加" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
    NSLog(@"action = %@", action);
  }];

  return @[deleteAction, addAction];
}


@end
