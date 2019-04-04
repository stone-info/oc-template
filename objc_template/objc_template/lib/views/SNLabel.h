//
//  SNLabel.h
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNLabel : UILabel

+ (instancetype)makeLabel;

+ (instancetype)makeLabelWithOptions:(NSDictionary *)options;

@property (copy, nonatomic) void (^action)(UITapGestureRecognizer *);

@property (assign, nonatomic) CGFloat      lineHeight;
@property (assign, nonatomic) CGFloat      letterSpacing;
@property (strong, nonatomic) NSMutableDictionary *attributes;
@end

NS_ASSUME_NONNULL_END
