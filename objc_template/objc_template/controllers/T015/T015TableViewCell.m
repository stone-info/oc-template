//
//  SNOldTableViewCell.m
//  Single_row_centered_multiple_rows_left_aligned
//
//  Created by stone on 2018/8/19.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "T015TableViewCell.h"

#define kPingFangSCRegular(SIZE) \
  [UIFont fontWithName:@"PingFangSC-Regular" size:SIZE]

@interface T015TableViewCell ()

@property(weak, nonatomic) IBOutlet UILabel* mLabel;

@end

@implementation T015TableViewCell

- (void)setModel:(NSString*)model {
  _model = model;

  self.mLabel.text = model;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code

  // #define kPingFangSCRegular(SIZE) [UIFont fontWithName:@"PingFangSC-Regular"
  // size:SIZE]

  NSString* text = self.mLabel.text;
  self.mLabel.font = kPingFangSCRegular(20);  //解决 单行 bug
  NSMutableAttributedString* attributedString =
      [[NSMutableAttributedString alloc] initWithString:text];
  NSMutableParagraphStyle* paragraphStyle =
      [[NSMutableParagraphStyle alloc] init];
  [paragraphStyle setLineSpacing:15];  // 设置行间距
  [attributedString addAttribute:NSParagraphStyleAttributeName
                           value:paragraphStyle
                           range:NSMakeRange(0, text.length)];
  self.mLabel.attributedText = attributedString;
  self.mLabel.lineBreakMode = NSLineBreakByTruncatingTail;  // 末尾...
  [self.mLabel sizeToFit];
}

@end
