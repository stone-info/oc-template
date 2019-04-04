//
//  ShopView.h
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopModel : NSObject
@property(copy, nonatomic) NSString* title;
@property(copy, nonatomic) NSString* imageName;
@end

@interface ShopView : UIView

@property(strong, nonatomic) ShopModel* model;

// @property (copy, nonatomic) NSString *title;
// @property (copy, nonatomic) NSString *imageName;

@end

NS_ASSUME_NONNULL_END
