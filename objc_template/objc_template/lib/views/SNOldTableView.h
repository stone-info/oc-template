//
//  SNOldTableView.h
//  006_UIAdvanced
//
//  Created by stone on 2018/8/7.
//  Copyright © 2018年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNOldTableView : UITableView <UITableViewDelegate, UITableViewDataSource>

- (void)addRequest;

- (void)addObserver;

/** 初始化 tableView */
- (void)setupInit:(UITableView *)tableView;

@end
