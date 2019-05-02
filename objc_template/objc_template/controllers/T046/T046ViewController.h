//
//  T046ViewController.h
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define RGBColorAlpha(r,g,b,f)   [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:f]
#define RGBColor(r,g,b)          RGBColorAlpha(r,g,b,1)

typedef NS_ENUM(NSInteger,STControllerType) {
  STControllerTypeNormal,
  STControllerTypeHybrid,
  STControllerTypeDisableBarScroll,
  STControllerTypeHiddenNavBar,
};

@interface T046ViewController : UIViewController

@property (nonatomic, assign) STControllerType type;
@property (nonatomic, strong) UIImageView * headerImageView;

@end

NS_ASSUME_NONNULL_END
    
    