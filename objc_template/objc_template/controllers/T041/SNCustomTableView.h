//
//  SNCustomTableView.h
//  objc_template
//
//  Created by stone on 2019/4/17.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNCustomTableView : UITableView

@property (nonatomic, copy) void (^cellForRow)(__kindof UITableView *, __kindof UITableViewCell *, NSIndexPath *);

+ (instancetype)makeTableViewWithClasses:(NSArray<NSDictionary<NSString *, Class> *> *)classes;

@end

NS_ASSUME_NONNULL_END
