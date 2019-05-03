//
//  DemoModel.m
//  IGListKitTest
//
//  Created by stone on 2019/5/2.
//  Copyright © 2019 stone. All rights reserved.
//

#import "DemoModel.h"

@implementation DemoModel

/**
 返回唯一标识对象的键。

  @return可用于唯一标识对象的键。

  @note两个对象可以共享相同的标识符，但不相等。 常见的模式是使用`NSObject`
  自动一致性类别。 然而，这意味着将在其上识别对象
  指针值因此找到更新变得不可能。

  @warning这个值永远不应该变异。

 */
- (nonnull id<NSObject>)diffIdentifier {
  return self.title;
}

/**
 返回接收者和给定对象是否相等。

  @param object要与接收器进行比较的对象。

  @return`YES`如果接收器和对象相等，否则为“NO”。

 */
- (BOOL)isEqualToDiffableObject:(nullable id<IGListDiffable>)object {
  DemoModel *model = (DemoModel *)object;
  return [self.title isEqualToString: model.title];
}

@end
