//
//  ImageCellOC.m
//  objc_template
//
//  Created by stone on 2019-05-05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T80ImageCell.h"

@interface T80ImageCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end

@implementation T80ImageCell

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
