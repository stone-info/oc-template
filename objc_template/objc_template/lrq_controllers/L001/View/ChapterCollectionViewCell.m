//
// Created by Maskkkk on 2019-05-06.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "ChapterCollectionViewCell.h"
#import "ChapterSectionController.h"

@interface ChapterCollectionViewCell () <IGListBindable>

@end

@implementation ChapterCollectionViewCell {}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self.contentView addSubview:self.chapterLabel];
    MASAttachKeys(self.chapterLabel);
    [self.chapterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(self.contentView);
      make.left.mas_equalTo(self.contentView);
    }];
  }
  return self;
}

- (SNLabel *)chapterLabel {

  /** _chapterLabel lazy load */

  if (_chapterLabel == nil) {
    _chapterLabel = [SNLabel makeLabelWithOptions:@{
      // @"borderColor"    : HexRGBA(@"#111", 1.0),
      // @"borderWidth"    : @1.0,
      @"backgroundColor": [UIColor whiteColor],
      @"textColor"      : [UIColor blackColor],
      @"font"           : [UIFont fontWithName:@"PingFangSC-Regular" size:14],
      @"text"           : @"label",
      @"textAlignment"  : @(NSTextAlignmentCenter),
      //    @"masksToBounds" : @YES,
      // @"lineHeight"     : @8,
      // @"letterSpacing"  : @.5f,
      // @"lineBreakMode"  : @(NSLineBreakByTruncatingTail)
    }];
  }
  return _chapterLabel;
}

- (void)bindViewModel:(id)viewModel {
  ChapterViewModel *chapterViewModel = (ChapterViewModel *)viewModel;
  [self.chapterLabel setText:kStringFormat(@"%zd: %@", chapterViewModel.chapterNo, chapterViewModel.chapterName)];
}

@end