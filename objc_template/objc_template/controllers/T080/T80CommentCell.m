//
//  CommentCellOC.m
//  objc_template
//
//  Created by stone on 2019-05-05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T80CommentCell.h"
#import "T80Comment.h"

@interface T80CommentCell ()


@end

@implementation T80CommentCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

}

- (void)bindViewModel:(T80Comment *)viewModel {

  self.usernameLabel.text = viewModel.username;
  self.commentLabel.text  = viewModel.text;

}


@end
