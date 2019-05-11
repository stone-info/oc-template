//
//  FullWidthSelfSizingCell.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import "FullWidthSelfSizingCell.h"

@interface FullWidthSelfSizingCell ()


@end

@implementation FullWidthSelfSizingCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.contentView.backgroundColor = UIColor.whiteColor;


    UILabel *label = UILabel.new;
    self.label = label;
    label.backgroundColor = HexRGBA(@"#FFC1C1", 0.1);
    label.numberOfLines                             = 1;
    label.translatesAutoresizingMaskIntoConstraints = NO;

    [self.contentView addSubview:label];

    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1 constant:15].active                = YES;
    [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1 constant:15].active        = YES;
    [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.label attribute:NSLayoutAttributeBottom multiplier:1 constant:15].active     = YES;
    [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.label attribute:NSLayoutAttributeTrailing multiplier:1 constant:15].active = YES;

  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
  // return [super preferredLayoutAttributesFittingAttributes:layoutAttributes];

  [self setNeedsLayout];
  [self layoutIfNeeded];

  CGSize size = [self.contentView systemLayoutSizeFittingSize:layoutAttributes.size];

  CGRect newFrame = layoutAttributes.frame;
  // newFrame.size.width    = ceil(size.width);
  newFrame.size.height   = ceil(size.height);
  layoutAttributes.frame = newFrame;
  return layoutAttributes;
}


@end
