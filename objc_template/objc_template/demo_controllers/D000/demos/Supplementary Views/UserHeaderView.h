//
//  UserHeaderView.h
//  objc_template
//
//  Created by stone on 2019/5/3.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserHeaderView : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;

@end

NS_ASSUME_NONNULL_END
