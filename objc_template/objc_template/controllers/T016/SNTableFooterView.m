//
//  SNTableFooterView.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNTableFooterView.h"

@interface SNTableFooterView ()
@property(weak, nonatomic) IBOutlet UILabel* mLabel;

@end
@implementation SNTableFooterView
- (void)awakeFromNib {
  [super awakeFromNib];

  NSString* content =
      @"参考:\n"
       "https://blog.csdn.net/sw_gegewu/article/details/51244546\n"
       "https://jingyan.baidu.com/article/dca1fa6f723e72f1a440523c.html\n"
       "-------------------------------------------\n"
       "xib约束 关键步骤垂直滑动 添加ContentView的 Horizontal Center in "
       "Container\n"
       "xib约束 关键步骤水平滑动 添加ContentView的 Vertical Center in "
       "Container\n"
       "masonry约束 关键步骤 不要忘记添加所有subview之后增加一个 "
       "lastView和contentView约束";

  self.mLabel.text = content;
  NSString* text = self.mLabel.text;
  self.mLabel.font =
      [UIFont fontWithName:@"PingFangSC-Regular" size:14];  //解决 单行 bug
  NSMutableAttributedString* attributedString =
      [[NSMutableAttributedString alloc] initWithString:text];
  NSMutableParagraphStyle* paragraphStyle =
      [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setLineSpacing:8];  // 设置行间距
  [attributedString addAttribute:NSParagraphStyleAttributeName
                           value:paragraphStyle
                           range:NSMakeRange(0, text.length)];
  self.mLabel.attributedText = attributedString;
  self.mLabel.lineBreakMode = NSLineBreakByTruncatingTail;  // 末尾...
  [self.mLabel sizeToFit];
}
+ (instancetype)tableFooterView {
  UINib* nib = [UINib nibWithNibName:@"SNTableFooterView" bundle:nil];
  SNTableFooterView* _self =
      [nib instantiateWithOwner:nil options:nil].lastObject;
  // 有这步 无需设置初始值...
  // tableView.tableFooterView = tableHeaderView;
  return _self;
}
- (void)layoutSubviews {
  // 一定要调用super的layoutSubviews
  [super layoutSubviews];
  self.suggestHeight = CGRectGetMaxY(self.mLabel.frame);
}
@end
