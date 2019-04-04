//
//  ShoppingCell.h
//  005_UITableView
//
//  Created by stone on 2018/7/27.
//  Copyright © 2018年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShoppingCellDelegate <NSObject>
@optional
- (void)sn_reloadData;
@end

@class ShoppingModel;

@interface ShoppingCell : UITableViewCell

@property(nonatomic, strong) ShoppingModel *model;

@property(nonatomic, copy) void (^reloadData)(void);

/** delegate */
@property(nonatomic, weak) id <ShoppingCellDelegate> delegate;

@end
