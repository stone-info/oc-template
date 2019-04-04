//
//  T009View.m
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T009View.h"
#import "ShopView.h"

NSUInteger col = 3;
NSUInteger row = 2;

@interface T009View ()
@property(weak, nonatomic) IBOutlet UIButton* addButton;
@property(weak, nonatomic) IBOutlet UIButton* removeButton;
@property(weak, nonatomic) IBOutlet UIView* contentView;
/** shopViewList */
@property(strong, nonatomic) NSMutableArray<UIView*>* shopViewList;
@property(strong, nonatomic) NSMutableArray<NSDictionary*>* dataList;
@property(strong, nonatomic) NSMutableArray<ShopModel*>* modelList;

@end

@implementation T009View

- (NSMutableArray<ShopModel*>*)modelList {
  /** _modelList lazy load */

  if (_modelList == nil) {
    _modelList = [ShopModel mj_objectArrayWithFilename:@"shopList.plist"];
  }
  return _modelList;
}

- (NSMutableArray<NSDictionary*>*)dataList {
  /** _dataList lazy load */

  if (_dataList == nil) {
    _dataList = [NSMutableArray<NSDictionary*> new];

    [_dataList addObject:@{
      @"imageName" : @"danjianbao",
      @"title" : @"单肩包"
    }];
    [_dataList addObject:@{
      @"imageName" : @"liantiaobao",
      @"title" : @"链条包"
    }];
    [_dataList addObject:@{ @"imageName" : @"qianbao", @"title" : @"钱包" }];
    [_dataList addObject:@{
      @"imageName" : @"shoutibao",
      @"title" : @"手提包"
    }];
    [_dataList addObject:@{
      @"imageName" : @"shuangjianbao",
      @"title" : @"双肩包"
    }];
    [_dataList addObject:@{
      @"imageName" : @"xiekuabao",
      @"title" : @"斜挎包"
    }];
  }
  return _dataList;
}

- (NSMutableArray<UIView*>*)shopViewList {
  /** _shopViewList lazy load */

  if (_shopViewList == nil) {
    _shopViewList = [NSMutableArray array];
  }
  return _shopViewList;
}

- (void)awakeFromNib {
  [super awakeFromNib];

  self.removeButton.enabled = self.shopViewList.count != 0;
}

- (IBAction)addButtonClicked:(UIButton*)sender {
  if (self.shopViewList.count == row * col) {
    return;
  }

  CGFloat contentViewWidth = self.contentView.width;
  CGFloat contentViewHeight = self.contentView.height;

  CGFloat horizontalInterval = 10;
  CGFloat verticalInterval = 10;
  CGFloat itemWidth = (contentViewWidth - horizontalInterval * (col - 1)) / col;
  CGFloat itemHeight = (contentViewHeight - verticalInterval * (row - 1)) / row;

  UINib* nib = [UINib nibWithNibName:@"ShopView" bundle:nil];
  ShopView* view = [nib instantiateWithOwner:nil options:nil].lastObject;

  [self.shopViewList addObject:view];

  self.removeButton.enabled = self.shopViewList.count > 0;
  self.addButton.enabled = self.shopViewList.count != row * col;

  CGFloat y;
  CGFloat x;

  x = ((self.shopViewList.count - 1) % col) * (itemWidth + horizontalInterval);
  y = ((self.shopViewList.count - 1) / col) * (itemHeight + verticalInterval);

  view.frame = CGRectMake(x, y, itemWidth, itemHeight);

  [self.contentView addSubview:view];

  view.backgroundColor = [UIColor orangeColor];

  // NSDictionary *dictionary = self.dataList[self.shopViewList.count - 1];
  // view.title     = dictionary[@"title"];
  // view.imageName = dictionary[@"imageName"];
  view.model = self.modelList[self.shopViewList.count - 1];
}

- (IBAction)removeButtonClicked:(UIButton*)sender {
  if (self.shopViewList.count == 0) {
    return;
  }

  UIView* view = self.shopViewList[self.shopViewList.count - 1];
  [view removeFromSuperview];
  [self.shopViewList removeLastObject];

  self.removeButton.enabled = self.shopViewList.count != 0;
  self.addButton.enabled = self.shopViewList.count != row * col;
}

@end
