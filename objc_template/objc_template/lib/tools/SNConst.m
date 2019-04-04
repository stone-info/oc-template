//
//  SNConst.m
//  007_ActualCombatTechnology
//
//  Created by stone on 2018/8/11.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "SNConst.h"

/*当前机型是否iPhoneX或iPhoneXs*/
#define iPhoneX                                                      \
  ([UIScreen instancesRespondToSelector:@selector(currentMode)]      \
       ? CGSizeEqualToSize(CGSizeMake(1125, 2436),                   \
                           [[UIScreen mainScreen] currentMode].size) \
       : NO)
/*当前机型是否iPhoneXR*/
#define iPhoneXR                                                     \
  ([UIScreen instancesRespondToSelector:@selector(currentMode)]      \
       ? CGSizeEqualToSize(CGSizeMake(828, 1792),                    \
                           [[UIScreen mainScreen] currentMode].size) \
       : NO)
/*当前机型是否iPhoneXsMax*/
#define iPhoneXsMax                                                  \
  ([UIScreen instancesRespondToSelector:@selector(currentMode)]      \
       ? CGSizeEqualToSize(CGSizeMake(1242, 2688),                   \
                           [[UIScreen mainScreen] currentMode].size) \
       : NO)
/*当前机型是否iPhoneX系列*/
#define iPhoneXSeries (iPhoneX || iPhoneXR || iPhoneXsMax)

CGFloat kStatusBarHeight           = 0;
CGFloat kStatusNavigationBarHeight = 0;
CGFloat kCurrentSystemVersionFloat = 0;
CGFloat kSafeAreaBottomHeight            = 0;
CGFloat kSafeAreaContainerViewHeight            = 0;

const CGFloat kNavigationBarHeight = 44;
const CGFloat kTabBarHeight        = 49;


const CGFloat SNhHeaderHeight          = 0;
const CGFloat SNhFooterHeight          = 0;
const CGFloat SNhFastAnimationDuration = 0;
const CGFloat SNhSlowAnimationDuration = 0;

NSString *const SNhKeyPathContentOffset = @"contentOffset";
NSString *const SNhKeyPathContentInset  = @"contentInset";
NSString *const SNhKeyPathContentSize   = @"contentSize";
NSString *const SNhKeyPathPanState      = @"state";

UIImage *kImageWithName(NSString *name) {
  return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@implementation SNConst

+ (void)initialize {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    kStatusBarHeight           = UIApplication.sharedApplication.statusBarFrame.size.height;
    kCurrentSystemVersionFloat = [[[UIDevice currentDevice] systemVersion] floatValue];

    kStatusNavigationBarHeight = kStatusBarHeight + kNavigationBarHeight;

    if (iPhoneXSeries) { kSafeAreaBottomHeight = 34.f; } else { kSafeAreaBottomHeight = 0.f; }

    kSafeAreaContainerViewHeight = kScreenHeight - kStatusBarHeight - kNavigationBarHeight - kSafeAreaBottomHeight;

    //    if (@available(iOS 11.0, *)) {
    //      UIEdgeInsets safeArea =
    //          [[UIApplication sharedApplication] keyWindow].safeAreaInsets;
    //      //  NSLog(@"%f",safeArea.bottom);
    //      kSafeAreaBottomHeight = safeArea.bottom;
    //    } else {
    //      if (KIsiPhoneX) {
    //        kSafeAreaBottomHeight = 34.0;
    //      } else {
    //        kSafeAreaBottomHeight = 0.0;
    //      }
    //    }
  });
}
@end
