//
//  SNTemplate.m
//  objc_template
//
//  Created by stone on 2019/3/31.
//  Copyright © 2019 stone. All rights reserved.
//

NSDictionary *kImageViewNormalTemplate;
NSDictionary *kLabelNormalTemplate;
// const CGFloat   SNhSlowAnimationDuration = 0;
// NSString *const SNhKeyPathContentOffset  = @"contentOffset";
// CGFloat         kSafeAreaContainerViewHeight          = 0;

#import "SNTemplate.h"

@interface SNTemplate ()
@end

@implementation SNTemplate

+ (void)load {

  kImageViewNormalTemplate = @{
    @"borderRadius"   : @4.F,
    // @"masksToBounds" : @(YES),
    @"backgroundColor": HexRGBA(0xCCCCCC, 1.0),
    @"contentMode"    : @(UIViewContentModeScaleToFill),
    // imageView需要这步操作, 因为layer.contents
    // 光栅化
    @"shouldRasterize": @(YES),
    // UI优化
    // https://www.jianshu.com/p/85837799f3eb
    @"opaque"         : @(YES),
    // @"glass"          : @(YES),
    // @"image"          : kImageWithName(kStringFormat(@"abc0%02d", i)),
  };

  kLabelNormalTemplate = @{
    @"backgroundColor": [UIColor whiteColor],
    @"textColor"      : [UIColor blackColor],
    @"font"           : [UIFont fontWithName:@"PingFangSC-Regular" size:14],
    @"text"           : @"When you are old and grey and full of sleep, 当你老了，头发花白，睡意沉沉，\n"
                        "And nodding by the fire，take down this book, 倦坐在炉边，取下这本书来，\n"
                        "And slowly read,and dream of the soft look 慢慢读着，追梦当年的眼神\n"
                        "Your eyes had once,and of their shadows deep; 你那柔美的神采与深幽的晕影。\n"
                        "How many loved your moments of glad grace, 多少人爱过你昙花一现的身影，\n",
    @"textAlignment"  : @(NSTextAlignmentCenter),
    @"borderColor"    : HexRGBA(0xcccccc, 1.0),
    @"borderWidth"    : @1.0,
    //    @"masksToBounds" : @YES,
    @"lineHeight"     : @8,
    @"letterSpacing"  : @.5f,
    @"lineBreakMode"  : @(NSLineBreakByTruncatingTail)
  };
}

+ (void)initialize {
}
@end
