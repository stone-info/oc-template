//
//  SNTableView.h
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNTableView : UITableView
+ (instancetype)makeTableView;

+ (instancetype)makeTableViewWithOptions:(NSDictionary *)options;

@property (strong, nonatomic) NSDictionary *options;

@end

NS_ASSUME_NONNULL_END
