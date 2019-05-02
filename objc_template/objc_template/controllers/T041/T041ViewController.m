//
//  T041ViewController.m
//  objc_template
//
//  Created by Maskkkk on 2019/4/4.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T041ViewController.h"
#import "SNCustomTableView.h"
#import "SNTestOneCell.h"
#import "SNTestTwoCell.h"

@interface T041ViewController ()
@property (weak, nonatomic) SNCustomTableView *tableView;
@end

@implementation T041ViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  SNCustomTableView *tableView = [SNCustomTableView makeTableViewWithClasses:@[
    @{@"class": SNTestOneCell.class},
    @{@"xib": SNTestTwoCell.class},
  ]];

  self.tableView = tableView;

  [self.view addSubview:tableView];

  //
  kMasKey(tableView);
  [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(0);
    make.bottom.offset(-kSafeAreaBottomHeight);
    make.left.right;
  }];

  [tableView setCellForRow:^(__kindof UITableView *tableView, __kindof UITableViewCell *cell, NSIndexPath *path) {

    if ([cell isKindOfClass:[SNTestTwoCell class]]) {
      SNTestTwoCell *twoCell = (SNTestTwoCell *) cell;
      twoCell.mTitleLabel.text = @"hello world";
    }
  }];

}


@end
