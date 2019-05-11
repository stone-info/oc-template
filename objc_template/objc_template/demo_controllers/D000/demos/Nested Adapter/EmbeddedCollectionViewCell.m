//
//  EmbeddedCollectionViewCell.m
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import "EmbeddedCollectionViewCell.h"

@interface EmbeddedCollectionViewCell ()


@end

@implementation EmbeddedCollectionViewCell

- (UICollectionView *)collectionView {

  if (_collectionView == nil) {
    UICollectionViewFlowLayout *flowLayout = UICollectionViewFlowLayout.new;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = UIColor.whiteColor;
    // _collectionView.alwaysBounceVertical   = NO;
    // _collectionView.alwaysBounceHorizontal = YES;
  }
  return _collectionView;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self.contentView addSubview:self.collectionView];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.collectionView.frame = self.contentView.frame;
}

@end
