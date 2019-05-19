//
//  ActionCell.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//


#import "T80ActionCell.h"
#import "ActionViewModel.h"

@interface T80ActionCell ()
@property (weak, nonatomic) IBOutlet UILabel  *likesLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation T80ActionCell

- (IBAction)onHeart:(UIButton *)sender {
  if ([_delegate respondsToSelector:@selector(didTapHeart:)]) {
    [_delegate didTapHeart:self];
  }
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

}

- (void)bindViewModel:(ActionViewModel *)viewModel {
  // self.likesLabel.text = kStringFormat(@"%li", viewModel.likes.integerValue);
  self.likesLabel.text = kStringFormat(@"%li", viewModel.likes);
}


@end
