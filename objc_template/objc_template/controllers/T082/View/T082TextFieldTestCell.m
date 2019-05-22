//
//  T082TestCell.m
//  objc_template
//
//  Created by stone on 2019-05-20.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T082TextFieldTestCell.h"
#import "T082TestViewModel.h"

@interface T082TextFieldTestCell ()


@end

@implementation T082TextFieldTestCell

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

    UILabel *label = makeLabel(NO);
    self.label = label;
    [self.contentView addSubview:label];
    kMasKey(label);
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.offset(0);
      make.left.offset(0);
      make.right.offset(0);
      make.height.mas_equalTo(30);
    }];

    UITextField *field = makeTextField(NO);
    self.field = field;
    [self.contentView addSubview:field];

    kMasKey(field);
    [field mas_makeConstraints:^(MASConstraintMaker *make) {
      make.top.mas_equalTo(label.mas_bottom).offset(8);
      make.left.offset(20);
      make.right.offset(-20);
      make.height.mas_equalTo(30);
    }];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

}

@end
