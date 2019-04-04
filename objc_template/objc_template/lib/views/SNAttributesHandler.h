//
//  SNAttributesHandler.h
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNAttributesHandler : NSObject

+ (void)test:(__kindof UIView *)view;

+ (void)commonAttributes:(__kindof UIView *)view
                     key:(NSString *)key
                     obj:(id)obj;

+ (void)featureAttributeWithScrollView:(__kindof UIScrollView *)view
                                   key:(NSString *)key
                                   obj:(id)obj;

+ (void)featureAttributeWithView:(__kindof UIView *)view
                             key:(NSString *)key
                             obj:(id)obj;

+ (void)featureAttributeWithImageView:(__kindof UIImageView *)view
                                  key:(NSString *)key
                                  obj:(id)obj;

+ (void)featureAttributeWithTableView:(__kindof UITableView *)view
                                  key:(NSString *)key
                                  obj:(id)obj;

+ (void)featureAttributeWithTextField:(__kindof UITextField *)view
                                  key:(NSString *)key
                                  obj:(id)obj;

+ (void)featureAttributeWithPageControl:(__kindof UIPageControl *)view
                                    key:(NSString *)key
                                    obj:(id)obj;

+ (void)featureAttributeWithLabel:(__kindof UILabel *)view key:(NSString *)key obj:(id)obj;
@end

NS_ASSUME_NONNULL_END
