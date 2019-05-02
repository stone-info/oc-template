//
//  T047ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T047ViewController.h"
#import "SNSwipeTableView.h"

@interface T047ViewController ()

@end

@implementation T047ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  SNSwipeTableView *tableView = SNSwipeTableView.new;
  tableView.backgroundColor = UIColor.lightGrayColor;
  [self.view addSubview:tableView];

  kMasKey(tableView);
  [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0));
  }];
}

@end
    