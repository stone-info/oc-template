//
//  T082TestCell.h
//  objc_template
//
//  Created by stone on 2019-05-20.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class T082TestViewModel;

NS_ASSUME_NONNULL_BEGIN

@interface T082TextFieldTestCell : UICollectionViewCell
@property (weak, nonatomic) UILabel     *label;
@property (weak, nonatomic) UITextField *field;
@end

NS_ASSUME_NONNULL_END