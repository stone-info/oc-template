//
//  ImageCellm.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import "ImageCell.h"

@interface ImageCell ()

@property (weak, nonatomic) UIImageView             *imageView;
@property (weak, nonatomic) UIActivityIndicatorView *activityView;
@end

@implementation ImageCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    {
      UIImageView *view = UIImageView.new;
      self.imageView       = view;
      view.contentMode     = UIViewContentModeScaleAspectFill;
      view.clipsToBounds   = YES;
      view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
      [self.contentView addSubview:view];
    }

    {
      UIActivityIndicatorView *view = [UIActivityIndicatorView.alloc initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
      self.activityView = view;
      [view startAnimating];
      [self.contentView addSubview:view];
    }
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGRect bounds = self.contentView.bounds;

  self.activityView.center = CGPointMake(bounds.size.width / 2.0, bounds.size.height / 2.0);

  self.imageView.frame = bounds;
}

- (void)setImage:(UIImage *)image {
  _image = image;

  if (image) {
    [self.activityView stopAnimating];
  } else {
    [self.activityView startAnimating];
  }

}


@end
