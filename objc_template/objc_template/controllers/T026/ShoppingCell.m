//
//  ShoppingCell.m
//  005_UITableView
//
//  Created by stone on 2018/7/27.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "ShoppingCell.h"
#import "ShoppingModel.h"

@interface ShoppingCell ()

@property(weak, nonatomic) IBOutlet UILabel *mTitleLabel;
@property(weak, nonatomic) IBOutlet UILabel *mSubTitleLabel;
@property(weak, nonatomic) IBOutlet UILabel *countLabel;

@property(weak, nonatomic) IBOutlet UIImageView *mImageView;

@end

@implementation ShoppingCell

- (IBAction)minusButtonClicked:(UIButton *)sender {

  // NSLog(@"self.superview = %@", self.superview);

  self.model.count--;

  if (self.model.count < 0) {
    self.model.count = 0;
  }

  [self setModel:self.model];
  !self.reloadData ?: self.reloadData();

  // if ([self.delegate respondsToSelector:@selector(sn_reloadData)]) {
  //   [self.delegate sn_reloadData];
  // }

  //  if ([self.superview isKindOfClass:[UITableView class]]) {
  //
  //    UITableView *tableView = (UITableView *) self.superview;
  //    NSIndexPath *indexPath = [tableView indexPathForCell:self];
  //
  //    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
  //
  //
  //
  //    // [(UITableView *) self.superview reloadData];
  //  }


}

- (IBAction)plusButtonClicked:(UIButton *)sender {

  // NSLog(@"self.superview = %@",self.superview);

  self.model.count++;

  [self setModel:self.model];
  !self.reloadData ?: self.reloadData();

  // if ([self.delegate respondsToSelector:@selector(sn_reloadData)]) {
  //   [self.delegate sn_reloadData];
  // }

  //  if ([self.superview isKindOfClass:[UITableView class]]) {
  //
  //    UITableView *tableView = (UITableView *) self.superview;
  //    NSIndexPath *indexPath = [tableView indexPathForCell:self];
  //    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
  //
  //
  //
  //    // [(UITableView *) self.superview reloadData];
  //  }
}

- (void)setModel:(ShoppingModel *)model {
  _model = model;
  //  @property(nonatomic, copy) NSString * image;
  //  @property(nonatomic, copy) NSString * money;
  //  @property(nonatomic, copy) NSString * name;

  // NSString *scale    = [NSString stringWithFormat:@"@%li", (NSInteger) [UIScreen mainScreen].scale];
  NSString *resource = [NSString stringWithFormat:@"myBundle.bundle/%@", model.image];
  NSString *path     = [[NSBundle mainBundle] pathForResource:resource ofType:nil];
  UIImage  *image    = [UIImage imageWithContentsOfFile:path];
  self.mImageView.image = image;

  self.mTitleLabel.text = model.name;

  self.mSubTitleLabel.text = [NSString stringWithFormat:@"¥%@", model.money];

  self.countLabel.text = [NSString stringWithFormat:@"%li", model.count];

}

- (void)awakeFromNib {
  [super awakeFromNib];
  // Initialization code

  // @property(weak, nonatomic) IBOutlet UILabel *mTitleLabel;
  // @property(weak, nonatomic) IBOutlet UILabel *mSubTitleLabel;
  // @property(weak, nonatomic) IBOutlet UILabel *countLabel;

  self.mTitleLabel.font          = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
  self.mTitleLabel.numberOfLines = 0;
  self.mSubTitleLabel.font       = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
  self.countLabel.font           = [UIFont fontWithName:@"PingFangSC-Regular" size:12];

  self.mTitleLabel.layer.borderWidth  = 1.0;
  self.mTitleLabel.layer.borderColor  = [UIColor orangeColor].CGColor;
  self.mTitleLabel.layer.cornerRadius = 4.0;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];

  // Configure the view for the selected state
}

@end
