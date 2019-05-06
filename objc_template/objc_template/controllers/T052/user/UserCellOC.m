//
//  UserCell.m
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import "UserCellOC.h"
#import "UserViewModel.h"

@interface UserCellOC ()
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation UserCellOC

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
}

- (void)bindViewModel:(UserViewModel *)viewModel {
  self.usernameLabel.text = viewModel.username;
  self.dateLabel.text     = viewModel.timestamp;
}


@end
