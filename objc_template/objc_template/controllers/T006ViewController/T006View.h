//
//  T006View.h
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface T006View : UIView
@property(nonatomic, copy) void (^bigButtonClickedBlock)(UIButton*);
@property(nonatomic, copy) void (^smallButtonClickedBlock)(UIButton*);
@end

NS_ASSUME_NONNULL_END
