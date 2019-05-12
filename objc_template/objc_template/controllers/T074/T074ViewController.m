//
//  T074ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T074ViewController.h"
#import <IGListKit/IGListKit.h>
#import "DiffTableViewCell.h"
#import "T074Person.h"

@interface T074ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) NSArray<T074Person *> *oldPeople;
@property (strong, nonatomic) NSArray<T074Person *> *newPeople;
@property (strong, nonatomic) NSArray<T074Person *> *people;
@property (assign, nonatomic) BOOL                  usingOldPeople;
/** tableView */
@property (nonatomic, weak) UITableView             *tableView;
@end

@implementation T074ViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.usingOldPeople = YES;
  }
  return self;
}

- (NSArray<T074Person *> *)oldPeople {

  if (_oldPeople == nil) {
    _oldPeople = @[
      [T074Person.alloc initWithPk:@0 name:@"铃木园子"],
      [T074Person.alloc initWithPk:@1 name:@"江户川柯南"],
      [T074Person.alloc initWithPk:@2 name:@"工藤新一"],
      [T074Person.alloc initWithPk:@3 name:@"毛利兰"],
      [T074Person.alloc initWithPk:@4 name:@"毛利小五郎"],
      [T074Person.alloc initWithPk:@5 name:@"阿笠博士"],
      [T074Person.alloc initWithPk:@6 name:@"灰原哀"],
      [T074Person.alloc initWithPk:@7 name:@"吉田步美"],
      [T074Person.alloc initWithPk:@8 name:@"圆谷光彦"],
      [T074Person.alloc initWithPk:@9 name:@"小岛元太"],

    ];
  }
  return _oldPeople;
}

- (NSArray<T074Person *> *)newPeople {

  if (_newPeople == nil) {
    _newPeople = @[

      [T074Person.alloc initWithPk:@1 name:@"江户川柯南"],
      [T074Person.alloc initWithPk:@0 name:@"铃木园子"],
      [T074Person.alloc initWithPk:@2 name:@"工藤新一"],
      [T074Person.alloc initWithPk:@3 name:@"毛利兰"],
      [T074Person.alloc initWithPk:@4 name:@"毛利小五郎"],
      [T074Person.alloc initWithPk:@5 name:@"阿笠博士"],
      [T074Person.alloc initWithPk:@6 name:@"灰原哀"],
      [T074Person.alloc initWithPk:@7 name:@"吉田步美"],
      [T074Person.alloc initWithPk:@8 name:@"圆谷光彦"],
      [T074Person.alloc initWithPk:@9 name:@"小岛元太"],

      // [T074Person.alloc initWithPk:@2 name:@"江户川柯南"],
      // [T074Person.alloc initWithPk:@0 name:@"工藤新一"],
      // [T074Person.alloc initWithPk:@5 name:@"毛利兰"],
      // [T074Person.alloc initWithPk:@1 name:@"毛利小五郎"],
      // [T074Person.alloc initWithPk:@3 name:@"阿笠博士"],
      // [T074Person.alloc initWithPk:@8 name:@"灰原哀"],
      // [T074Person.alloc initWithPk:@7 name:@"吉田步美"],
      // [T074Person.alloc initWithPk:@4 name:@"圆谷光彦"],
      // [T074Person.alloc initWithPk:@9 name:@"小岛元太"],
      // [T074Person.alloc initWithPk:@6 name:@"铃木园子"],
    ];
  }
  return _newPeople;
}

- (NSArray<T074Person *> *)people {

  if (_people == nil) {
    _people = self.oldPeople;
  }
  return _people;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor              = UIColor.whiteColor;
  self.navigationItem.rightBarButtonItem = [UIBarButtonItem.alloc initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(onDiff:)];

  if (@available(iOS 11.0, *)) {
    // 取消自动调整内边距
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  } else {
    self.automaticallyAdjustsScrollViewInsets = NO;
  }
  // add tableView
  {
    UITableViewStyle tableViewStyle = UITableViewStylePlain;
    //-------------------------------------------------------------------------------------
    UITableView      *tableView     = [[UITableView alloc] initWithFrame:CGRectZero style:tableViewStyle];
    self.tableView                  = tableView;
    [self.view addSubview:tableView];

    tableView.dataSource = self;
    tableView.delegate   = self;

    kMasKey(tableView);
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0));
    }];
  }

  [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(DiffTableViewCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(DiffTableViewCell.class)];

}

- (void)onDiff:(UIBarButtonItem *)sender {

  NSArray<T074Person *> *from = self.people;

  NSArray<T074Person *> *to = self.usingOldPeople ? self.newPeople : self.oldPeople;

  self.usingOldPeople = !self.usingOldPeople;

  self.people = to;

  IGListIndexPathResult *result = [IGListDiffPaths(0, 0, from, to, IGListDiffEquality) resultForBatchUpdates];

  [self.tableView beginUpdates];

  [self.tableView deleteRowsAtIndexPaths:result.deletes withRowAnimation:UITableViewRowAnimationFade];
  [self.tableView insertRowsAtIndexPaths:result.inserts withRowAnimation:UITableViewRowAnimationFade];

  [result.moves forEach:^(IGListMoveIndexPath *obj, NSUInteger idx) {

    NSLog(@"obj.from = %@", obj.from);
    NSLog(@"obj.to = %@", obj.to);

    [self.tableView moveRowAtIndexPath:obj.from toIndexPath:obj.to];
  }];

  [self.tableView endUpdates];

}

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.people.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

  DiffTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(DiffTableViewCell.class) forIndexPath:indexPath];

  T074Person *oc   = self.people[indexPath.row];
  NSString   *name = oc.name;
  NSInteger  pk    = [[oc valueForKey:@"pk"] integerValue];
  cell.nameLabel.text = name;
  cell.pkLabel.text   = kStringFormat(@"%li", pk);
  return cell;
}

@end

    