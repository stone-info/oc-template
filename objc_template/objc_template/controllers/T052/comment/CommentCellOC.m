//
//  CommentCellOC.m
//  objc_template
//
//  Created by stone on 2019-05-05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "CommentCellOC.h"
#import "CommentOC.h"

@interface CommentCellOC ()


@end

@implementation CommentCellOC

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

}

- (void)bindViewModel:(CommentOC *)viewModel {

  self.usernameLabel.text = viewModel.username;
  self.commentLabel.text  = viewModel.text;

}


@end
