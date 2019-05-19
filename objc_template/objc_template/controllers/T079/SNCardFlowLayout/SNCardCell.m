//
//  Card.m
//  CardSwitchDemo
//
//  Created by Apple on 2016/11/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "SNCardCell.h"
#import "SNCardItemMoel.h"

@interface SNCardCell ()

@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation SNCardCell

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.imageView = imageView;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    kBorder(imageView);
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.insets(UIEdgeInsetsZero); }];
  }
  return self;
}

- (void)setModel:(SNCardItemMoel *)model {
  _model = model;
  self.imageView.image = [UIImage imageNamed:model.imageName];
}


@end
