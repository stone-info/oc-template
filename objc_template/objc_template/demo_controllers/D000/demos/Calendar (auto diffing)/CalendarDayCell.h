//
//  CalendarDayCell.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IGListKit/IGListBindable.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarDayCell : UICollectionViewCell <IGListBindable>
@property (weak, nonatomic) UILabel *label;
@property (weak, nonatomic) UILabel *dotsLabel;

@end

NS_ASSUME_NONNULL_END