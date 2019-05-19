//
//  SNUserCell.m
//  objc_template
//
//  Created by stone on 2019-05-19.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNUserCell.h"
#import "SNUserModel.h"

static NSUUID    *_identifier = nil;
static NSInteger _userCount   = 0;
static CGFloat   _cellHeight  = 540;

// {
// 		"address" : {
// 			"geo" : {
// 				"lat" : "-38.2386",
// 				"lng" : "57.2232"
// 			},
// 			"street" : "Kattie Turnpike",
// 			"suite" : "Suite 198",
// 			"city" : "Lebsackbury",
// 			"zipcode" : "31428-2261"
// 		},
// 		"phone" : "024-648-3804",
// 		"website" : "ambrose.net",
// 		"id" : 10,
// 		"company" : {
// 			"name" : "Hoeger LLC",
// 			"catchPhrase" : "Centralized empowering task-force",
// 			"bs" : "target end-to-end models"
// 		},
// 		"username" : "Moriah.Stanton",
// 		"email" : "Rey.Padberg@karina.biz",
// 		"name" : "Clementina DuBuque"
// 	}
@interface SNUserCell ()

@property (strong, nonatomic) CALayer        *separator;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *websiteLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyCatchPhraseLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyBsLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressSuiteLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressCityLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressZipcodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressStreetLabel;
@property (weak, nonatomic) IBOutlet UILabel *geoLatLabel;
@property (weak, nonatomic) IBOutlet UILabel *getLngLabel;


@end

@implementation SNUserCell

+ (CGFloat)cellHeight {
  return _cellHeight;
}

+ (void)resetIdentifier {
  _identifier = [[NSUUID alloc] init];
}

+ (NSInteger)userCount {
  return _userCount;
}

+ (NSUUID *)identifier {
  if (_identifier == nil) {
    _identifier = [[NSUUID alloc] init];
  }
  return _identifier;
}

+ (void)setIdentifier:(NSUUID *)newIdentifier {
  if (newIdentifier != _identifier) {
    _identifier = [newIdentifier copy];
  }
}

- (void)awakeFromNib {
  [super awakeFromNib];

  _userCount += 1;

  kBorder(self.contentView);

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

- (void)bindViewModel:(SNUserModel *)viewModel {

  self.idLabel.text                 = kStringFormat(@"%li", viewModel.ID);
  self.usernameLabel.text           = viewModel.username;
  self.nameLabel.text               = viewModel.name;
  self.emailLabel.text              = viewModel.email;
  self.phoneLabel.text              = viewModel.phone;
  self.websiteLabel.text            = viewModel.website;
  self.companyNameLabel.text        = viewModel.company.name;
  self.companyCatchPhraseLabel.text = viewModel.company.catchPhrase;
  self.companyBsLabel.text          = viewModel.company.bs;
  self.addressSuiteLabel.text       = viewModel.address.suite;
  self.addressCityLabel.text        = viewModel.address.city;
  self.addressZipcodeLabel.text     = viewModel.address.zipcode;
  self.addressStreetLabel.text      = viewModel.address.street;
  self.geoLatLabel.text             = viewModel.address.geo.lat;
  self.getLngLabel.text             = viewModel.address.geo.lng;

}

@end
