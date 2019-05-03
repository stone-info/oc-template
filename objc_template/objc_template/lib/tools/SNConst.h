//
//  SNConst.h
//  007_ActualCombatTechnology
//
//  Created by stone on 2018/8/11.
//  Copyright © 2018年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
// UIKIT_EXTERN简单来说：就是将函数修饰为兼容以往C编译方式的、
// 具有extern属性(文件外可见性)、public修饰的方法或变量库外仍可见的属性
// https://www.jianshu.com/p/a6947375c52e

UIKIT_EXTERN CGFloat kStatusBarHeight;
UIKIT_EXTERN CGFloat kCurrentSystemVersionFloat;
UIKIT_EXTERN CGFloat kSafeAreaBottomHeight;
UIKIT_EXTERN CGFloat kSafeAreaContainerViewHeight;
UIKIT_EXTERN CGFloat kStatusNavigationBarHeight;
UIKIT_EXTERN BOOL    kAutoPush;

UIKIT_EXTERN const CGFloat kNavigationBarHeight;
UIKIT_EXTERN const CGFloat kTabBarHeight;

NS_ASSUME_NONNULL_BEGIN

@interface SNConst : NSObject

@end

NS_ASSUME_NONNULL_END
