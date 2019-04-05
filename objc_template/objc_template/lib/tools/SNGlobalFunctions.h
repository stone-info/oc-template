//
//  SNGlobalFunctions.h
//  objc_template
//
//  Created by stone on 2019/4/6.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNHexColor;

UIKIT_EXTERN UIImage *kImageWithName(NSString *name);

UIKIT_EXTERN CGFloat kDegreesToRadian(CGFloat angle);

//                              /* UITableView */
/************************************************************************************/
UIKIT_EXTERN void registerForCellFromNib(__kindof UITableView *tableView, Class nibClass);

UIKIT_EXTERN void registerForHeaderFooterViewFromNib(__kindof UITableView *tableView, Class nibClass);

UIKIT_EXTERN void registerForCellFromClass(__kindof UITableView *tableView, Class cellClass);

UIKIT_EXTERN void registerForHeaderFooterViewFromClass(__kindof UITableView *tableView, Class headerFooterViewClass);

UIKIT_EXTERN __kindof UITableViewCell *dequeueForCell(__kindof UITableView *tableView, Class cellClass);

UIKIT_EXTERN __kindof UITableViewHeaderFooterView *dequeueForHeaderFooterView(__kindof UITableView *tableView, Class headerFooterViewClass);

UIKIT_EXTERN void cellDifferentColor(__kindof UITableViewCell *cell, NSIndexPath *indexPath);

//                              /* UICollectionView */
/************************************************************************************/

UIKIT_EXTERN void registerForCollectionCellFromNib(__kindof UICollectionView *collectionView, Class nibClass);

UIKIT_EXTERN void registerForCollectionCellFromClass(__kindof UICollectionView *collectionView, Class itemClass);

UIKIT_EXTERN __kindof UICollectionViewCell *dequeueForCollectionCell(__kindof UICollectionView *collectionView, Class itemClass, NSIndexPath *indexPath);


//                              /* Color */
/************************************************************************************/
UIKIT_EXTERN SNHexColor *HexRGBA(NSString *hex, CGFloat alpha);

UIKIT_EXTERN SNHexColor *HexRGB(NSString *hex);

//                              /* font */
/************************************************************************************/
UIKIT_EXTERN UIFont *kPingFangSCRegular(CGFloat size);

UIKIT_EXTERN UIFont *kPingFangSCMedium(CGFloat size);

UIKIT_EXTERN UIFont *kSystemFont(CGFloat size);

UIKIT_EXTERN UIFont *kFont(NSString *fontFamily, CGFloat size);

NS_ASSUME_NONNULL_BEGIN

@interface SNGlobalFunctions : NSObject

@end

NS_ASSUME_NONNULL_END
