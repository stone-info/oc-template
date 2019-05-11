//
//  SearchCell.m
//  IGListKitTest
//
//  Created by stone on 2019/5/2.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SearchCell.h"

@interface SearchCell ()


@end

@implementation SearchCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    UISearchBar *bar = UISearchBar.new;

    self.searchBar = bar;

    [self.contentView addSubview:bar];

  }
  return self;
}

- (void)layoutSubviews {
  // 一定要调用super的layoutSubviews
  [super layoutSubviews];

  self.searchBar.frame = self.contentView.bounds;
}
@end
