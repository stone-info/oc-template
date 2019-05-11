//
//  NibCell.m
//  objc_template
//
//  Created by stone on 2019/5/3.
//  Copyright © 2019 stone. All rights reserved.
//

#import "NibCell.h"
//类属性 （Objective-C Class Properties）
//https://www.jianshu.com/p/c7e08e647510

static NSString *_nibName = @"NibCell";

@interface NibCell ()

@property (strong, nonatomic) CALayer *separator;

@end

@implementation NibCell

+ (NSString *)nibName {
  if (!_nibName) {
    _nibName = [[NSString alloc] init];
  }
  return _nibName;
}

+ (void)setNibName:(NSString *)nibName {
  _nibName = nibName;
}

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code

  CALayer *separator = [CALayer new];
  self.separator            = separator;
  separator.backgroundColor = HexRGBA(@"#C0C0C0", 1.0).CGColor;
  [self.contentView.layer addSublayer:separator];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect bounds = self.contentView.bounds;
  CGFloat height = 0.5;
  self.separator.frame = CGRectMake(0, bounds.size.height - height, bounds.size.width, height);
}

@end
