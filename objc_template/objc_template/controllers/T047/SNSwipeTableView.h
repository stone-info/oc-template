//
//  SNSwipeTableView.h
//  objc_template
//
//  Created by stone on 2019/5/1.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@protocol SNSwipeTableViewDataSource;
@protocol SNSwipeTableViewDelegate;

@interface SNSwipeTableView : UIView
@property (nonatomic, weak) id<SNSwipeTableViewDelegate>delegate;
@property (nonatomic, weak) id<SNSwipeTableViewDataSource>dataSource;




@end

NS_ASSUME_NONNULL_END

@protocol SNSwipeTableViewDataSource <NSObject>

- (NSInteger)numberOfItemsInSNSwipeTableView:(SNSwipeTableView *)swipeView;
- (UIScrollView *)swipeTableView:(SNSwipeTableView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIScrollView *)view;

@end

@protocol SNSwipeTableViewDelegate <NSObject>

@optional
- (void)swipeTableViewDidScroll:(SNSwipeTableView *)swipeView;
- (void)swipeTableViewCurrentItemIndexDidChange:(SNSwipeTableView *)swipeView;
- (void)swipeTableViewWillBeginDragging:(SNSwipeTableView *)swipeView;
- (void)swipeTableViewDidEndDragging:(SNSwipeTableView *)swipeView willDecelerate:(BOOL)decelerate;
- (void)swipeTableViewWillBeginDecelerating:(SNSwipeTableView *)swipeView;
- (void)swipeTableViewDidEndDecelerating:(SNSwipeTableView *)swipeView;
- (void)swipeTableViewDidEndScrollingAnimation:(SNSwipeTableView *)swipeView;
- (BOOL)swipeTableView:(SNSwipeTableView *)swipeView shouldSelectItemAtIndex:(NSInteger)index;
- (void)swipeTableView:(SNSwipeTableView *)swipeView didSelectItemAtIndex:(NSInteger)index;

/**
 *  ①.在没有设置宏 #define ST_PULLTOREFRESH_HEADER_HEIGHT 的时候，想要通过自定义下拉刷新控件，并改写下拉刷新控件frame的方式支持下拉刷新。下面的两个方法必须实现。
 *  ②.在定义了宏 #define ST_PULLTOREFRESH_HEADER_HEIGHT 的条件下，这两个方法可以灵活的调整每个item的下拉刷新有无，以及刷新控件的高度（RefreshHeader全部显露的高度）
 */
- (BOOL)swipeTableView:(SNSwipeTableView *)swipeTableView shouldPullToRefreshAtIndex:(NSInteger)index; // default is YES if defined ST_PULLTOREFRESH_HEADER_HEIGHT,otherwise is NO.
- (CGFloat)swipeTableView:(SNSwipeTableView *)swipeTableView heightForRefreshHeaderAtIndex:(NSInteger)index; // default is ST_PULLTOREFRESH_HEADER_HEIGHT if defined ST_PULLTOREFRESH_HEADER_HEIGHT,otherwise is CGFLOAT_MAX(not set pull to refesh).

@end


