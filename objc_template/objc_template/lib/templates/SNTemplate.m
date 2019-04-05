//
//  SNTemplate.m
//  objc_template
//
//  Created by stone on 2019/3/31.
//  Copyright © 2019 stone. All rights reserved.
//

NSDictionary *kImageViewNormalTemplate;
NSDictionary *kLabelNormalTemplate;
NSDictionary *kButtonNormalTemplate;
NSDictionary *kTableViewNormalTemplate;
// const CGFloat   SNhSlowAnimationDuration = 0;
// NSString *const SNhKeyPathContentOffset  = @"contentOffset";
// CGFloat         kSafeAreaContainerViewHeight          = 0;

#import "SNTemplate.h"

@interface SNTemplate ()
@end

@implementation SNTemplate

+ (void)load {
  [self normalTemplates];
}

+ (void)normalTemplates {
  kImageViewNormalTemplate = @{
    // @"borderRadius"   : @4.F,
    // @"masksToBounds" : @(YES),
    @"backgroundColor": HexRGBA(@"#CCCCCC", 1.0),
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

  kLabelNormalTemplate  = @{
    @"borderColor"    : HexRGBA(@"#cccccc", 1.0),
    @"borderWidth"    : @1.0,
    @"backgroundColor": [UIColor whiteColor],
    @"textColor"      : [UIColor blackColor],
    @"font"           : [UIFont fontWithName:@"PingFangSC-Regular" size:14],
    @"text"           : @"label",
    @"textAlignment"  : @(NSTextAlignmentCenter),
    //    @"masksToBounds" : @YES,
    // @"lineHeight"     : @8,
    // @"letterSpacing"  : @.5f,
    // @"lineBreakMode"  : @(NSLineBreakByTruncatingTail)
  };
  kButtonNormalTemplate = @{
    @"borderColor": HexRGBA(@"#cccccc", 1.0),
    @"borderWidth": @1.0,
  };

  kTableViewNormalTemplate=@{

    @"borderColor": HexRGBA(@"#cccccc", 1.0),
    @"borderWidth": @1.0,

    @"style"                : @(UITableViewStyleGrouped),
    // @"frame"                : sn.valueWithCGRect(CGRectMake(0, kStatusNavigationBarHeight, kScreenWidth, kSafeAreaContainerViewHeight)),

    /** 数据源 */
    @"delegate"             : self,
    @"dataSource"           : self,

    /** 注册 class */
    @"registerCellFromClass": UITableViewCell.class,
    // @"registerHeaderFromClass"     : UITableViewHeaderFooterView.class,
    // @"registerFooterFromClass"     : UITableViewHeaderFooterView.class,

    /** 注册 xib */
    // @"registerCellFromNib"         : UITableViewCell.class,
    // @"registerHeaderFromNib"       : UITableViewHeaderFooterView.class,
    // @"registerFooterFromNib"       : UITableViewHeaderFooterView.class,

    /** 上下view */
    // @"tableFooterView"             : UIView.new, // if (tableView.style == UITableViewStylePlain) { tableView.tableFooterView = UIView.new; }
    // @"tableHeaderView"             : UIView.new,

    /** 分割线 */
    // @"separatorStyle"              : @(UITableViewCellSeparatorStyleNone),
    // @"separatorInset"              : sn.valueWithUIEdgeInsets(UIEdgeInsetsZero),
    // @"separatorColor"              : HexRGBA(@"#CCCCCC", 1.0),
    // @"showsVerticalScrollIndicator": @(NO),

    /** section header height */
    @"sectionHeaderHeight"  : @(0.001),
    // @"sectionHeaderHeight"         : @(100),
    // @"sectionHeaderHeight"         : @(UITableViewAutomaticDimension),
    // @"estimatedSectionHeaderHeight": @(100),

    /** section footer height */
    @"sectionFooterHeight"  : @(0.001),
    // @"sectionFooterHeight"         : @(100),
    // @"sectionFooterHeight"         : @(UITableViewAutomaticDimension),
    // @"estimatedSectionFooterHeight": @(100),

    /** cell height */
    @"rowHeight"            : @(44),
    // @"estimatedRowHeight"   : @(100),
    // @"rowHeight"            : @(UITableViewAutomaticDimension),
  };
}

+ (void)initialize {}
@end
