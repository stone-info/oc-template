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

@protocol ActionCellOCDelegate;

@interface ActionCellOC : UICollectionViewCell <IGListBindable>
@property (nonatomic, weak, nullable) id <ActionCellOCDelegate> delegate;
@end

@protocol ActionCellOCDelegate <NSObject>
@required
- (void)didTapHeart:(ActionCellOC *)cell;
@end

NS_ASSUME_NONNULL_END