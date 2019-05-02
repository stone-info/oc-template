//
//  STListController.m
//  SwipeTableView
//
//  Created by Roy lee on 16/4/2.
//  Copyright © 2016年 Roy lee. All rights reserved.
//

#import "STListController.h"
#import "STViewController.h"

@interface STListController ()

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation STListController

- (void)viewDidLoad {
  [super viewDidLoad];

  UITableView *tableView = (UITableView *) self.view;

  registerForCellFromClass(tableView, UITableViewCell.class);

  self.dataSource = @[
    @{
      @"title": @"SingleOneKindView",
      @"type" : @(STControllerTypeNormal),
    },
    @{
      @"title": @"HybridItemViews",
      @"type" : @(STControllerTypeHybrid),
    },
    @{
      @"title": @"DisabledBarScroll",
      @"type" : @(STControllerTypeDisableBarScroll),
    },
    @{
      @"title": @"HiddenNavigationBar",
      @"type" : @(STControllerTypeHiddenNavBar),
    }
  ];
}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"list_cell" forIndexPath:indexPath];
  UITableViewCell *cell = dequeueForCell(tableView, UITableViewCell.class);

  cell.textLabel.text = _dataSource[indexPath.row][@"title"];
  return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  STViewController *demoVC = STViewController.new;
  demoVC.type  = (STControllerType) [_dataSource[indexPath.row][@"type"] integerValue];
  demoVC.title = _dataSource[indexPath.row][@"title"];
  [self.navigationController pushViewController:demoVC animated:YES];
}

@end
