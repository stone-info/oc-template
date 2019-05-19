//
//  SNUserCell.h
//  objc_template
//
//  Created by stone on 2019-05-19.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IGListKit/IGListBindable.h>

NS_ASSUME_NONNULL_BEGIN

// https://www.jianshu.com/p/d49e08cf36fe
@interface SNUserCell : UICollectionViewCell <IGListBindable>
@property (class, nonatomic, assign, readonly) NSInteger userCount;
@property (class, nonatomic, copy) NSUUID                *identifier;
@property (class, nonatomic, assign, readonly) CGFloat cellHeight;

+ (void)resetIdentifier;
@end

NS_ASSUME_NONNULL_END
