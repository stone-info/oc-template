//
//  DetailLabelCell.h
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailLabelCell : UICollectionViewCell
@property (weak, nonatomic) UILabel *titleLabel;
@property (weak, nonatomic) UILabel *detailLabel;
@end

NS_ASSUME_NONNULL_END