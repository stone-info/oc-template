//
// Created by stone on 2019-05-13.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "T078Cell.h"
#import "SNUserModel.h"

@interface T078Cell ()
@property (weak, nonatomic) UILabel *label;
@end

@implementation T078Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self addViews];
    [self setupSubscribeion];
  }
  return self;
}

- (void)addViews {

  UILabel *label = makeLabel(YES);
  _label = label;
  [self.contentView addSubview:label];
  kMasKey(label);
  [label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(10);
    make.left.offset(10);
    make.right.offset(-10);
    make.bottom.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];
}

- (void)setupSubscribeion {

  @weakify(self);
  [RACObserve(self, model) subscribeNext:^(SNUserModel *model) {
    @strongify(self);
    if (!model) { return; }

    NSLog(@"model class = %@", SN.getClassName(model));
    NSLog(@"model = %@", model);

    _label.text = model.name;

  }];
}

@end