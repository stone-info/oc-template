//
//  ActionCell.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IGListKit/IGListBindable.h>

NS_ASSUME_NONNULL_BEGIN

@protocol T80ActionCellDelegate;

@interface T80ActionCell : UICollectionViewCell <IGListBindable>
@property (nonatomic, weak, nullable) id <T80ActionCellDelegate> delegate;
@end

@protocol T80ActionCellDelegate <NSObject>
@required
- (void)didTapHeart:(T80ActionCell *)cell;
@end

NS_ASSUME_NONNULL_END