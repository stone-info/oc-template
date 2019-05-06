//
//  ImageCellOC.m
//  objc_template
//
//  Created by stone on 2019-05-05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "ImageCellOC.h"

@interface ImageCellOC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation ImageCellOC

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

}

- (void)bindViewModel:(id)viewModel {
  [self.imageView sd_setImageWithURL:[viewModel url]];
}


@end
