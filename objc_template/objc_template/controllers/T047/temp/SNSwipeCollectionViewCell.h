//
//  SNSwipeCollectionViewCell.h
//  objc_template
//
//  Created by stone on 2019/5/1.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNSwipeCollectionViewCell : UICollectionViewCell
@property (copy, nonatomic) NSString              *title;
@property (weak, nonatomic, readonly) UITableView *tableView;
@property (weak, nonatomic) UIView                *headerView;
@property (nonatomic, copy) void (^callback)(void);

@end

NS_ASSUME_NONNULL_END
