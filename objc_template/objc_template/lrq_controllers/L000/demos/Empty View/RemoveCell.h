//
//  RemoveCell.h
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol RemoveCellDelegate;

@interface RemoveCell : UICollectionViewCell

@property (nonatomic, weak, nullable) id <RemoveCellDelegate> delegate;

@property (weak, nonatomic) UILabel *label;

@end

NS_ASSUME_NONNULL_END

@protocol RemoveCellDelegate <NSObject>

@required
- (void)removeCellDidTapButton:(RemoveCell *)cell;

@end