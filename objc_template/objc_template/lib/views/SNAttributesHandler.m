//
//  SNAttributesHandler.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "SNAttributesHandler.h"

@interface SNAttributesHandler ()

@end

@implementation SNAttributesHandler

+ (void)test:(__kindof UIView *)view {
  // [view setValue:sn.valueWithPoint(-100,-100) forKey:@"contentOffset"];
}

+ (void)commonAttributes:(__kindof UIView *)view key:(NSString *)key obj:(id)obj {
  (
    (void (^)(void)) @{
      @"borderWidth"           : ^{ view.layer.borderWidth = [obj floatValue]; },
      @"borderColor"           : ^{ view.layer.borderColor = [obj CGColor]; },
      @"borderRadius"          : ^{ view.layer.cornerRadius = [obj floatValue]; },

      @"shadowColor"           : ^{ view.layer.shadowColor = [obj CGColor]; },
      @"shadowOpacity"         : ^{ view.layer.shadowOpacity = [obj floatValue]; },
      @"shadowOffset"          : ^{ view.layer.shadowOffset = [obj CGSizeValue]; },
      /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
      @"shadowRadius"          : ^{ view.layer.shadowRadius = [obj floatValue]; },

      @"masksToBounds"         : ^{ view.layer.masksToBounds = [obj boolValue]; },
      @"clipsToBounds"         : ^{ view.clipsToBounds = [obj boolValue]; },
      @"contentMode"           : ^{ view.contentMode = (UIViewContentMode) [obj integerValue]; },
      @"backgroundColor"       : ^{ view.backgroundColor = obj; },
      // @"frame"                 : ^{
      //   view.frame = [obj CGRectValue];
      // },
      @"userInteractionEnabled": ^{ view.userInteractionEnabled = [obj boolValue]; },
      @"shouldRasterize"       : ^{ /* Defaults to NO. Animatable.*/ view.layer.shouldRasterize = [obj boolValue]; },
      @"opaque"                : ^{ view.opaque = [obj boolValue]; },
      @"action"                : ^{ [view setValue:obj forKey:@"action"]; },
    }[key] ?: ^{
      // NSLog(@"default");
    }
  )();
}

// view 特性
+ (void)featureAttributeWithView:(__kindof UIView *)view
        key:(NSString *)key
        obj:(id)obj {
  (
    (void (^)(void)) @{
      // @"action": ^{
      //   view.userInteractionEnabled = YES;
      //   [view setValue:obj forKey:@"action"];
      // },
    }[key] ?: ^{
      // NSLog(@"default");
    }
  )();
}

// image view 特性
+ (void)featureAttributeWithImageView:(__kindof UIImageView *)view key:(NSString *)key obj:(id)obj {
  // (
  //   (void (^)(void)) @{
  //     @"image": ^{
  //       view.image = obj;
  //     },
  //   }[key] ?: ^{
  //     // NSLog(@"default");
  //   }
  // )();

  if ([key isEqualToString:@"glass"] && [obj boolValue] == YES) {
    // https://www.jianshu.com/p/d115836ed3fa

    // iOS2.0
    // UIToolbar *toolbar = UIToolbar.new;
    // imageView.toolbar = toolbar;
    // toolbar.barStyle  = UIBarStyleDefault;
    // toolbar.alpha     = 0.8;
    // // bar.frame = CGRectMake(0, 0, imageView.width, imageView.height);
    // [imageView addSubview:toolbar];
    // [bar mas_makeConstraints:^(MASConstraintMaker *make) {
    //   make.top.mas_equalTo(imageView.mas_top).offset(0);
    //   make.left.mas_equalTo(imageView.mas_left).offset(0);
    //   make.right.mas_equalTo(imageView.mas_right).offset(0);
    //   make.bottom.mas_equalTo(imageView.mas_bottom).offset(0);
    // }];

    // iOS8.0 UIVisuaEffectView
    UIBlurEffect       *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];

    [view addSubview:visualView];

    [visualView mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.insets(UIEdgeInsetsZero); }];

  }
}

// scroll view 特性
+ (void)featureAttributeWithScrollView:(__kindof UIScrollView *)view key:(NSString *)key obj:(id)obj {
  (
    (void (^)(void)) @{
      @"contentSize"                   : ^{ view.contentSize = [obj CGSizeValue]; },
      @"scrollEnabled"                 : ^{ view.scrollEnabled = [obj boolValue]; },
      @"bounces"                       : ^{ view.bounces = [obj boolValue]; },
      @"alwaysBounceHorizontal"        : ^{ view.alwaysBounceHorizontal = [obj boolValue]; },
      @"alwaysBounceVertical"          : ^{ view.alwaysBounceVertical = [obj boolValue]; },
      @"showsHorizontalScrollIndicator": ^{ view.showsHorizontalScrollIndicator = [obj boolValue]; },
      @"showsVerticalScrollIndicator"  : ^{ view.showsVerticalScrollIndicator = [obj boolValue]; },
      @"contentInset"                  : ^{ view.contentInset = [obj UIEdgeInsetsValue]; },

    }[key] ?: ^{
      // NSLog(@"default");
    }
  )();
}

// table view 特性
+ (void)featureAttributeWithTableView:(__kindof UITableView *)view key:(NSString *)key obj:(id)obj {
  (
    (void (^)(void)) @{
      // 数据源
      @"delegate"                    : ^{ view.delegate = obj; },
      @"dataSource"                  : ^{ view.dataSource = obj; },

      // 滚动条
      @"showsVerticalScrollIndicator": ^{ view.showsVerticalScrollIndicator = [obj boolValue]; },

      // 分割线
      @"separatorStyle"              : ^{ view.separatorStyle = (UITableViewCellSeparatorStyle) [obj integerValue]; },
      @"separatorInset"              : ^{ view.separatorInset = [obj UIEdgeInsetsValue]; },
      @"separatorColor"              : ^{ view.separatorColor = obj; },

      // 页脚 页码
      @"tableHeaderView"             : ^{ view.tableHeaderView = obj; },
      @"tableFooterView"             : ^{ view.tableFooterView = obj; },
      // height 相关
      @"rowHeight"                   : ^{ view.rowHeight = [obj floatValue]; },
      @"estimatedRowHeight"          : ^{ view.estimatedRowHeight = [obj floatValue]; },
      @"sectionHeaderHeight"         : ^{ view.sectionHeaderHeight = [obj floatValue]; },
      @"sectionFooterHeight"         : ^{ view.sectionFooterHeight = [obj floatValue]; },
      @"estimatedSectionHeaderHeight": ^{ view.estimatedSectionHeaderHeight = [obj floatValue]; },
      @"estimatedSectionFooterHeight": ^{ view.estimatedSectionFooterHeight = [obj floatValue]; },

      // 注册class
      @"registerCellFromClass"       : ^{ [view registerClass:obj forCellReuseIdentifier:NSStringFromClass(obj)]; },
      @"registerHeaderFromClass"     : ^{ [view registerClass:obj forHeaderFooterViewReuseIdentifier:NSStringFromClass(obj)]; },
      @"registerFooterFromClass"     : ^{ [view registerClass:obj forHeaderFooterViewReuseIdentifier:NSStringFromClass(obj)]; },

      // 注册nib
      @"registerCellFromNib"         : ^{ [view registerNib:[UINib nibWithNibName:NSStringFromClass(obj) bundle:nil] forCellReuseIdentifier:NSStringFromClass(obj)]; },
      @"registerHeaderFromNib"       : ^{ [view registerNib:[UINib nibWithNibName:NSStringFromClass(obj) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass(obj)]; },
      @"registerFooterFromNib"       : ^{ [view registerNib:[UINib nibWithNibName:NSStringFromClass(obj) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass(obj)]; },
    }[key] ?: ^{
      // NSLog(@"default");
    }
  )();
}

// text field 特性
+ (void)featureAttributeWithTextField:(__kindof UITextField *)view key:(NSString *)key obj:(id)obj {
  (
    (void (^)(void)) @{
      @"placeholder"       : ^{ view.placeholder = obj; },
      @"textAlignment"     : ^{ view.textAlignment = (NSTextAlignment) [obj integerValue]; },
      @"borderStyle"       : ^{ view.borderStyle = (UITextBorderStyle) [obj integerValue]; },
      @"clearButtonMode"   : ^{ view.clearButtonMode = (UITextFieldViewMode) [obj integerValue]; },
      @"font"              : ^{ view.font = obj; },
      @"keyboardAppearance": ^{ view.keyboardAppearance = (UIKeyboardAppearance) [obj integerValue]; },
      @"returnKeyType"     : ^{ view.returnKeyType = (UIReturnKeyType) [obj integerValue]; },
      @"delegate"          : ^{ view.delegate = obj; },
    }[key] ?: ^{
      // NSLog(@"default");
    }
  )();
}

// page control 特性
+ (void)featureAttributeWithPageControl:(__kindof UIPageControl *)view key:(NSString *)key obj:(id)obj {
  (
    (void (^)(void)) @{
      @"hidesForSinglePage"           : ^{ view.hidesForSinglePage = [obj boolValue]; },
      @"numberOfPages"                : ^{ view.numberOfPages = [obj integerValue]; },
      @"currentPage"                  : ^{ view.currentPage = [obj integerValue]; },
      @"pageIndicatorTintColor"       : ^{ view.pageIndicatorTintColor = obj; },
      @"currentPageIndicatorTintColor": ^{ view.currentPageIndicatorTintColor = obj; },
      @"currentPageImage"             : ^{ [view setValue:obj forKeyPath:@"_currentPageImage"]; },
      @"pageImage"                    : ^{ [view setValue:obj forKeyPath:@"_pageImage"]; },
    }[key] ?: ^{
      // NSLog(@"default");
    }
  )();
}

// label 特性
+ (void)featureAttributeWithLabel:(__kindof UILabel *)view key:(NSString *)key obj:(id)obj {

  (
    (void (^)(void)) @{
      @"textColor"    : ^{ view.textColor = obj; },
      @"text"         : ^{ view.text = obj; },
      @"font"         : ^{ view.font = obj; },
      @"lineBreakMode": ^{ view.lineBreakMode = (NSLineBreakMode) [obj integerValue]; },
    }[key] ?: ^{
      // NSLog(@"default");
    }
  )();
}

// button 特性
+ (void)featureAttributeWithButton:(__kindof UIButton *)view key:(NSString *)key obj:(id)obj {
  (
    (void (^)(void)) @{
      @"adjustsImageWhenHighlighted": ^{ [view setAdjustsImageWhenHighlighted:[obj boolValue]]; },
      @"titleNormal"                : ^{ [view setTitle:obj forState:UIControlStateNormal]; },
      @"titleColorNormal"           : ^{ [view setTitleColor:obj forState:UIControlStateNormal]; },
      @"titleHighlighted"           : ^{ [view setTitle:obj forState:UIControlStateHighlighted]; },
      @"titleColorHighlighted"      : ^{ [view setTitleColor:obj forState:UIControlStateHighlighted]; },
      @"font"                       : ^{ view.titleLabel.font = obj; },
      @"imageNormal"                : ^{ [view setImage:obj forState:UIControlStateNormal]; },
      @"imageSelected"              : ^{ [view setImage:obj forState:UIControlStateSelected]; },
      @"imageHighlighted"           : ^{ [view setImage:obj forState:UIControlStateHighlighted]; },
      @"backgroundImageNormal"      : ^{ [view setBackgroundImage:obj forState:UIControlStateNormal]; },
      @"backgroundImageSelected"    : ^{ [view setBackgroundImage:obj forState:UIControlStateSelected]; },
      @"backgroundImageHighlighted" : ^{ [view setBackgroundImage:obj forState:UIControlStateHighlighted]; },
    }[key] ?: ^{
      // NSLog(@"default");
    }
  )();
}


@end
