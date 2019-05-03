//
//  LabelCell.m
//  IGListKitTest
//
//  Created by stone on 2019/5/2.
//  Copyright © 2019 stone. All rights reserved.
//

#import "LabelCell.h"

static UIEdgeInsets insets;
static UIFont       *font;
static CGFloat      singleLineHeight;

@interface LabelCell () <IGListBindable>

@property (strong, nonatomic) CALayer *separator;

@end

@implementation LabelCell

+ (CGFloat)singleLineHeight {
  return font.lineHeight + insets.top + insets.bottom;
}

+ (void)load {
  insets           = UIEdgeInsetsMake(8, 15, 8, 15);
  font             = [UIFont systemFontOfSize:17];
  singleLineHeight = font.lineHeight + insets.top + insets.bottom;
}

+ (CGFloat)textHeightWithText:(NSString *)text width:(CGFloat)width {

  CGSize constrainedSize = CGSizeMake(width - insets.left - insets.right, MAXFLOAT);

  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  dict[NSFontAttributeName] = font;

  CGRect bounds = [text boundingRectWithSize:constrainedSize
                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                        attributes:dict
                        context:nil];

  return ceil(bounds.size.height) + insets.top + insets.bottom;
}

- (UILabel *)label {

  if (_label == nil) {
    _label = [UILabel new];
    _label.backgroundColor = [UIColor clearColor];
    _label.numberOfLines   = 0;
    _label.font            = font;
  }
  return _label;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    self.contentView.backgroundColor = UIColor.whiteColor;
    [self.contentView addSubview:self.label];

    CALayer *separator = [CALayer new];
    self.separator            = separator;
    separator.backgroundColor = HexRGBA(@"#C0C0C0", 1.0).CGColor;
    // separator.frame           = CGRectMake(0, 0, kScreenWidth, 10);
    [self.contentView.layer addSublayer:separator];

  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect bounds = self.contentView.bounds;
  self.label.frame = UIEdgeInsetsInsetRect(bounds, insets);

  CGFloat height = 0.5;
  CGFloat left   = insets.left;
  self.separator.frame = CGRectMake(left, bounds.size.height - height, bounds.size.width - left, height);
  // self.separator.frame = CGRectMake(0, bounds.size.height-1, kScreenWidth, 1);

  // NSLogRect(self.separator.frame);
}

- (void)setHighlighted:(BOOL)highlighted {
  self.contentView.backgroundColor = [UIColor colorWithWhite:highlighted ? 0.9 : 1.0 alpha:1.0];
}

- (void)bindViewModel:(id)viewModel {

  if ([viewModel isKindOfClass:[NSString class]]) {
    NSString *object = (NSString *) viewModel;
    self.label.text = object;
  }

}

@end
