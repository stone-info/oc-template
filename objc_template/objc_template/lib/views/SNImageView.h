//
//  SNImageView.h
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SNImageView : UIImageView

@property (copy, nonatomic) void (^action)(UITapGestureRecognizer *);

+ (instancetype)makeImageView;

+ (instancetype)makeImageViewWithOptions:(NSDictionary *)options;


- (void)setImageWithBundleName:(NSString *)bundleName imageName:(NSString *)imageName extension:(NSString *__nullable)extension;
@end

NS_ASSUME_NONNULL_END
