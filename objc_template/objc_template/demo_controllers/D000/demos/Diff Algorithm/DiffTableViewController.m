//
//  DiffTableViewController.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//
#import "DiffTableViewController.h"
#import <IGListKit/IGListKit.h>
#import "PersonOC.h"
#import "DiffTableViewCell.h"

@interface DiffTableViewController ()
@property (strong, nonatomic) NSArray<PersonOC *> *oldPeople;
@property (strong, nonatomic) NSArray<PersonOC *> *newPeople;
@property (strong, nonatomic) NSArray<PersonOC *> *people;
@property (assign, nonatomic) BOOL                usingOldPeople;
@end

@implementation DiffTableViewController

- (instancetype)init {
  self = [super init];
  if (self) {
    self.usingOldPeople = YES;
  }
  return self;
}

- (NSArray<PersonOC *> *)oldPeople {

  /** _oldPeople lazy load */

  if (_oldPeople == nil) {
    _oldPeople = @[
      [PersonOC.alloc initWithPk:@1 name:@"Kevin"],
      [PersonOC.alloc initWithPk:@2 name:@"Mike"],
      [PersonOC.alloc initWithPk:@3 name:@"Ann"],
      [PersonOC.alloc initWithPk:@4 name:@"Jane"],
      [PersonOC.alloc initWithPk:@5 name:@"Philip"],
      [PersonOC.alloc initWithPk:@6 name:@"Mona"],
      [PersonOC.alloc initWithPk:@7 name:@"Tami"],
      [PersonOC.alloc initWithPk:@8 name:@"Jesse"],
      [PersonOC.alloc initWithPk:@9 name:@"Jaed"],
    ];
  }
  return _oldPeople;
}

- (NSArray<PersonOC *> *)newPeople {

  /** _newPeople lazy load */

  if (_newPeople == nil) {
    _newPeople = @[
      [PersonOC.alloc initWithPk:@2 name:@"Mike"],
      [PersonOC.alloc initWithPk:@10 name:@"Marne"],
      [PersonOC.alloc initWithPk:@5 name:@"Philip"],
      [PersonOC.alloc initWithPk:@1 name:@"Kevin"],
      [PersonOC.alloc initWithPk:@3 name:@"Ryan"],
      [PersonOC.alloc initWithPk:@8 name:@"Jesse"],
      [PersonOC.alloc initWithPk:@7 name:@"Tami"],
      [PersonOC.alloc initWithPk:@4 name:@"Jane"],
      [PersonOC.alloc initWithPk:@9 name:@"Chen"],
    ];
  }
  return _newPeople;
}

- (NSArray<PersonOC *> *)people {

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

  [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(DiffTableViewCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(DiffTableViewCell.class)];

}

- (void)onDiff:(UIBarButtonItem *)sender {

  NSArray<PersonOC *> *from = self.people;

  NSArray<PersonOC *> *to = self.usingOldPeople ? self.newPeople : self.oldPeople;

  self.usingOldPeople = !self.usingOldPeople;

  self.people = to;

  IGListIndexPathResult *result = [IGListDiffPaths(0, 0, from, to, IGListDiffEquality) resultForBatchUpdates];

  [self.tableView beginUpdates];

  [self.tableView deleteRowsAtIndexPaths:result.deletes withRowAnimation:UITableViewRowAnimationFade];
  [self.tableView insertRowsAtIndexPaths:result.inserts withRowAnimation:UITableViewRowAnimationFade];

  [result.moves forEach:^(IGListMoveIndexPath *obj, NSUInteger idx) {
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

  PersonOC  *oc   = self.people[indexPath.row];
  NSString  *name = oc.name;
  NSInteger pk    = [[oc valueForKey:@"pk"] integerValue];
  cell.nameLabel.text = name;
  cell.pkLabel.text   = kStringFormat(@"%li", pk);
  return cell;
}

@end
