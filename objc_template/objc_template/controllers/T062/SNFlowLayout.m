//
//  SNFlowLayout.m
//  objc_template
//
//  Created by stone on 2019/5/9.
//  Copyright © 2019 stone. All rights reserved.
//

#import "SNFlowLayout.h"

@interface SNFlowLayout ()


@end

@implementation SNFlowLayout

//重载第一个方法 可见区域的内容尺寸
- (CGSize)collectionViewContentSize {
  CGSize visibleSize = [super collectionViewContentSize];

  NSLog(@"可见区域内容尺寸: %@", NSStringFromCGSize(visibleSize));
  return visibleSize;
}

//rect中所有的布局属性
const CGFloat ZDScale = 1.3f;

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

  CGRect  visibleRect    = CGRectMake(self.collectionView.contentOffset.x, 0, self.collectionView.width, self.collectionView.height);
  NSArray *visibleAttriM = [super layoutAttributesForElementsInRect:visibleRect];
  NSLog(@"%@", visibleAttriM);
  [visibleAttriM enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL *_Nonnull stop) {
    NSLog(@"%@", obj);
    CGFloat leftM       = obj.center.x - self.collectionView.contentOffset.x;
    CGFloat halfCenterX = self.collectionView.width * 0.5;
    CGFloat absOffset   = fabs(leftM - halfCenterX) * 0.8;
    NSLog(@"%.2f", absOffset);
    CGFloat scale = 1 - absOffset / halfCenterX;
    obj.transform3D = CATransform3DMakeScale(ZDScale * scale, ZDScale * scale, 1);
    if (scale < 0.6) {
      obj.alpha = 0.6;
    } else if (scale > 0.99) {
      obj.alpha = 1.0;
    } else {
      obj.alpha = scale;
    }
  }];

  NSArray *attriM = [[NSArray alloc] initWithArray:visibleAttriM copyItems:true];
  return attriM;
}

//是否重新布局
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
  NSLog(@"%@", NSStringFromCGRect(newBounds));
  CGPoint     collectionPoint = [self.collectionView.superview convertPoint:self.collectionView.center toView:self.collectionView];
  NSIndexPath *currentIndexP  = [self.collectionView indexPathForItemAtPoint:collectionPoint];
  NSLog(@"%@", currentIndexP);
  [super shouldInvalidateLayoutForBoundsChange:newBounds];
  return true;
}

//自动停到中间
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
  __block CGFloat minMargin       = CGFLOAT_MAX;
  CGRect          visibleRect     = CGRectMake(self.collectionView.contentOffset.x, 0, self.collectionView.width, self.collectionView.height);
  NSArray         *attributsItems = [super layoutAttributesForElementsInRect:visibleRect];
  __block CGFloat visibleCenterX  = proposedContentOffset.x + self.collectionView.bounds.size.width * 0.5;
  [attributsItems enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *obj, NSUInteger idx, BOOL *_Nonnull stop) {
    CGFloat centerMargin = obj.center.x - visibleCenterX;
    if (fabs(minMargin) > fabs(centerMargin)) {
      minMargin = centerMargin;
    }
  }];
  CGFloat         offsetX         = proposedContentOffset.x + minMargin;
  if (offsetX < 0) {
    offsetX = 0;
  } else if (offsetX > self.collectionView.contentSize.width - (self.sectionInset.left + self.sectionInset.right + self.itemSize.width)) {
    offsetX = floorf(offsetX);
  }

  return CGPointMake(offsetX, proposedContentOffset.y);
}


@end
