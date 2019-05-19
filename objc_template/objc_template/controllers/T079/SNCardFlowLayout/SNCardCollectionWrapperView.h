//
//  SNCardCollectionWrapperView.h
//  XLCardSwitchDemo
//
//  Created by Apple on 2017/1/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNCardItemMoel.h"

@protocol SNCardDelegate <NSObject>

@optional

/**
 滚动代理方法
 */
-(void)SNCardDidSelectedAt:(NSInteger)index;

@end

@interface SNCardCollectionWrapperView : UIView
/**
 当前选中位置
 */
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
/**
 设置数据源
 */
@property (nonatomic, strong) NSArray <SNCardItemMoel *>*items;
/**
 代理
 */
@property (nonatomic, weak) id<SNCardDelegate>delegate;

/**
 是否分页，默认为true
 */
@property (nonatomic, assign) BOOL pagingEnabled;

/**
 手动滚动到某个卡片位置
 */
- (void)switchToIndex:(NSInteger)index animated:(BOOL)animated;



@end
