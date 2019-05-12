//
//  T071UserCell.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T071UserCell.h"
#import "SNUserModel.h"

@interface T071UserCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel     *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel     *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel     *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel     *websiteLabel;
@property (weak, nonatomic) IBOutlet UILabel     *companyLabel;
@property (strong, nonatomic) CALayer            *separator;

@end

@implementation T071UserCell

- (void)awakeFromNib {
  [super awakeFromNib];

  kBorder(_nameLabel);
  kBorder(_usernameLabel);
  kBorder(_emailLabel);
  kBorder(_addressLabel);
  kBorder(_phoneLabel);
  kBorder(_websiteLabel);
  kBorder(_companyLabel);

  CALayer *separator = [CALayer new];
  self.separator            = separator;
  separator.backgroundColor = HexRGBA(@"#C0C0C0", 1.0).CGColor;
  // separator.frame           = CGRectMake(0, 0, kScreenWidth, 10);
  [self.contentView.layer addSublayer:separator];
}

- (void)setModel:(SNUserModel *)model {
  _model = model;

  _nameLabel.text     = model.name;
  _usernameLabel.text = model.username;
  _emailLabel.text    = model.email;
  _addressLabel.text  = model.address.city;
  _phoneLabel.text    = model.phone;
  _websiteLabel.text  = model.website;
  _companyLabel.text  = model.company.name;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {

  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  CGRect  bounds = self.contentView.bounds;
  CGFloat height = 0.5;
  self.separator.frame = CGRectMake(0, bounds.size.height - height, bounds.size.width, height);
}

@end
