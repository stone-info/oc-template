//
//  NibCell.h
//  objc_template
//
//  Created by stone on 2019/5/3.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NibCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (nonatomic, copy, class) NSString *nibName;
@end

NS_ASSUME_NONNULL_END
