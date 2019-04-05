//
//  SNGlobalFunctions.m
//  objc_template
//
//  Created by stone on 2019/4/6.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNGlobalFunctions.h"
#import "SNHexColor.h"

UIImage *kImageWithName(NSString *name) {
  return [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

CGFloat kDegreesToRadian(CGFloat angle) {
  return M_PI * (angle) / 180.0;
}

// table view

void registerForCellFromNib(__kindof UITableView *tableView, Class nibClass) {
  [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(nibClass) bundle:nil] forCellReuseIdentifier:NSStringFromClass(nibClass)];
}

void registerForHeaderFooterViewFromNib(__kindof UITableView *tableView, Class nibClass) {
  [tableView registerNib:[UINib nibWithNibName:NSStringFromClass(nibClass) bundle:nil] forHeaderFooterViewReuseIdentifier:NSStringFromClass(nibClass)];
}

void registerForCellFromClass(__kindof UITableView *tableView, Class cellClass) {
  [tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
}

void registerForHeaderFooterViewFromClass(__kindof UITableView *tableView, Class headerFooterViewClass) {
  [tableView registerClass:headerFooterViewClass forHeaderFooterViewReuseIdentifier:NSStringFromClass(headerFooterViewClass)];
}

__kindof UITableViewCell *dequeueForCell(__kindof UITableView *tableView, Class cellClass) {
  return [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
}

__kindof UITableViewHeaderFooterView *dequeueForHeaderFooterView(__kindof UITableView *tableView, Class headerFooterViewClass) {
  return [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(headerFooterViewClass)];
}

void cellDifferentColor(__kindof UITableViewCell *cell, NSIndexPath *indexPath) {
  cell.contentView.backgroundColor = indexPath.row % 2 == 0 ?
    [UIColor colorWithRed:247 / 255.0 green:206 / 255.0 blue:166 / 255.0 alpha:1.0] :
    [UIColor colorWithRed:242 / 255.0 green:154 / 255.0 blue:76 / 255.0 alpha:1.0];
}

// collection view
void registerForCollectionCellFromNib(__kindof UICollectionView *collectionView, Class nibClass) {
  [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(nibClass) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(nibClass)];
}

void registerForCollectionCellFromClass(__kindof UICollectionView *collectionView, Class itemClass) {
  [collectionView registerClass:itemClass forCellWithReuseIdentifier:NSStringFromClass(itemClass)];
}

__kindof UICollectionViewCell *dequeueForCollectionCell(__kindof UICollectionView *collectionView, Class itemClass, NSIndexPath *indexPath) {
  return [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(itemClass) forIndexPath:indexPath];
}

SNHexColor *HexRGBA(NSString *hex, CGFloat alpha) {
  return [SNHexColor hexColorWithHex:hex alpha:alpha];
}

SNHexColor *HexRGB(NSString *hex) {
  return [SNHexColor hexColorWithHex:hex];
}

UIFont *kPingFangSCRegular(CGFloat size) {
  return [UIFont fontWithName:@"PingFangSC-Regular" size:size];
}

UIFont *kPingFangSCMedium(CGFloat size) {

  return [UIFont fontWithName:@"PingFangSC-Medium" size:size];
}

UIFont *kSystemFont(CGFloat size) {

  return [UIFont systemFontOfSize:size];
}

UIFont *kFont(NSString *fontFamily, CGFloat size) {

  return [UIFont fontWithName:fontFamily size:size];
}

// 无参和有LOG的不做 全局函数

@interface SNGlobalFunctions ()

@end

@implementation SNGlobalFunctions

@end
