//
//  EmbeddedCollectionViewCell.h
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EmbeddedCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UICollectionView *collectionView;
@end

NS_ASSUME_NONNULL_END