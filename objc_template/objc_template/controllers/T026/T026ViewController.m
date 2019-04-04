//
//  T026ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T026ViewController.h"
#import "ShoppingCell.h"
#import "ShoppingModel.h"

@interface T026ViewController () <UITableViewDelegate, UITableViewDataSource, ShoppingCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) NSMutableArray<ShoppingModel *> *modelList;
@property (weak, nonatomic) NSTimer *timer;

@property (weak, nonatomic) IBOutlet UILabel *allPriceLabel;

@end

@implementation T026ViewController

- (IBAction)buyButtonClicked:(UIButton *)sender {
  NSLog(@"%s", __func__);
}

- (IBAction)cleanShoppingCarButtonClicked:(UIButton *)sender {
  NSLog(@"%s", __func__);

  [self.modelList setValue:@0 forKey:@"count"];

  [self.tableView reloadData];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  self.tableView.delegate   = self;
  self.tableView.dataSource = self;

  [self setupInit:self.tableView];

  // tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
  // tableView.separatorColor = [UIColor greenColor];

  // 模拟网络请求
  {
    [self.timer invalidate];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(dosomething:) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
  }

  // 使用"extern" 来连接全局变量即可, 链接这句 深表赞同...
  // extern NSString * hello;
  // NSLog(@"hello = %@", hello);

}

- (void)dosomething:(NSTimer *)timer {
  // timer.userInfo
  self.modelList = [ShoppingModel mj_objectArrayWithFilename:@"wine.plist"];

  [self.timer invalidate];
  self.timer = nil;
  [self.tableView reloadData];

}

/** 初始化 tableView */
- (void)setupInit:(UITableView *)tableView {
  self.tableView.fd_debugLogEnabled = YES;

  // MARK: - 注册
  {
    /**
     * cell xib 注册 & class 注册
     */
    registerForCellFromNib(tableView, ShoppingCell);

    // registerForCellFromeClass(tableView, DiffHeightCell);
  }
  // MARK: - 设置高度
  {
    // tableView.rowHeight           = 100;
    tableView.estimatedRowHeight = 100;
    tableView.rowHeight          = UITableViewAutomaticDimension;
  }
}

#pragma mark - <UITableViewDataSource>

/** 组数 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

/** 行数 */
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
  return self.modelList.count;
}
// MARK: - cell
/** cell */
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  ShoppingCell *cell = DequeueForCell(tableView, ShoppingCell);

  cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? HexRGBA(0xF2CDA7, 1.0) : HexRGBA(0xEA9950, 1.0);
  cell.selectionStyle              = tableView.isEditing ? UITableViewCellSelectionStyleDefault : UITableViewCellSelectionStyleNone;

  [self configureCell:cell atIndexPath:indexPath];

  // @weakify(tableView)
  // [cell setReloadData:^{
  //   @strongify(tableView)
  //   [strong_tableView reloadRowsAtIndexPaths:@[indexPath]
  //   withRowAnimation:UITableViewRowAnimationNone];
  // }];

  @weakify_self
  [cell setReloadData:^{
    @strongify_self
    __block NSInteger allPrice = 0;
    [self.modelList enumerateObjectsUsingBlock:^(ShoppingModel *obj, NSUInteger idx, BOOL *stop) { allPrice += obj.count * [obj.money intValue]; }];
    self.allPriceLabel.text = [NSString stringWithFormat:@"¥%li", allPrice];
  }];

  // cell.delegate = self;

  return cell;
}

// - (void)sn_reloadData{
//   [self.tableView reloadData];
// }

- (void)configureCell:(ShoppingCell *)cell
          atIndexPath:(NSIndexPath *)indexPath {
  cell.fd_enforceFrameLayout = NO;  // Enable to use "-sizeThatFits:"
  cell.model                 = self.modelList[indexPath.row];
}

// cell 高度计算
- (CGFloat)   tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return [self returnCellHeight:tableView indexPath:indexPath];
}

- (CGFloat)returnCellHeight:(UITableView *)tableView
                  indexPath:(NSIndexPath *)indexPath {
  return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([ShoppingCell class])
                    cacheByIndexPath:indexPath
                    configuration:^(ShoppingCell *cell) {
                      // configurations
                      [self configureCell:cell atIndexPath:indexPath];
                    }];
}

@end
