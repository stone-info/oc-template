//
//  ShopView.m
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import "ShopView.h"

@implementation ShopModel

@end

@interface ShopView ()
@property(weak, nonatomic) IBOutlet UILabel* titleLabel;
@property(weak, nonatomic) IBOutlet UIImageView* iconImageView;

@end

@implementation ShopView
- (void)setModel:(ShopModel*)model {
  _model = model;

  self.titleLabel.text = model.title;
  self.iconImageView.image = [UIImage imageNamed:model.imageName];
}

// - (void)setTitle:(NSString *)title {
//   _title = title;
//   self.titleLabel.text = title;
//   [self.titleLabel sizeToFit];
// }
//
// - (void)setImageName:(NSString *)imageName {
//   _imageName = imageName;
//
//   self.iconImageView.image = [UIImage imageNamed:imageName];
//
// }

@end
