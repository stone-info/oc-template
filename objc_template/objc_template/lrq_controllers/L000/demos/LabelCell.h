//
//  LabelCell.h
//  IGListKitTest
//
//  Created by stone on 2019/5/2.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IGListKit/IGListKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LabelCell : UICollectionViewCell

@property (strong, nonatomic) UILabel *label;
+ (CGFloat)textHeightWithText:(NSString *)text width:(CGFloat)width;
+ (CGFloat)singleLineHeight;
@end

NS_ASSUME_NONNULL_END
