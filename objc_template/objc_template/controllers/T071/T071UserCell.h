//
//  T071UserCell.h
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNUserModel;

NS_ASSUME_NONNULL_BEGIN

@interface T071UserCell : UICollectionViewCell
@property (strong, nonatomic)  SNUserModel *model;
@end

NS_ASSUME_NONNULL_END