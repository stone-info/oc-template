//
//  MonthSectionController.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import <IGListKit/IGListSectionController.h>

NS_ASSUME_NONNULL_BEGIN


/**
 * IGListBindingSectionController
 *
 This section controller uses a data source to transform its "top level" object into an array of diffable view models.
 It then automatically binds each view model to cells via the `IGListBindable` protocol.

 Models used with `IGListBindingSectionController` should take special care to always return `YES` for identical
 objects. That is, any objects with matching `-diffIdentifier`s should always be equal, that way the section controller
 can create new view models via the data source, create a diff, and update the specific cells that have changed.

 In Objective-C, your `-isEqualToDiffableObject:` can simply be:
 ```
 - (BOOL)isEqualToDiffableObject:(id)object {
   return YES;
 }
 ```

 In Swift:
 ```
 func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
   return true
 }
 ```

 Only when `-diffIdentifier`s match is object equality compared, so you can assume the class is the same, and the
 instance has already been checked.

 此节控制器使用数据源将其“顶级”对象转换为可扩散视图模型的数组。
  然后它通过`IGListBindable`协议自动将每个视图模型绑定到单元格。
 
  与`IGListBindingSectionController`一起使用的模型应特别注意始终返回相同的`YES`
 对象。 也就是说，任何匹配`-diffIdentifier'的对象应始终相等，这就是节控制器
  可以通过数据源创建新的视图模型，创建差异，并更新已更改的特定单元格。
 
  在Objective-C中，你的`-isEqualToDiffableObject：`可以简单地是：
 ```
   - （BOOL）isEqualToDiffableObject：（id）object {
    返回YES;
 }
 ```
 
  在Swift中：
 ```
  func isEqual（toDiffableObject object：IGListDiffable？） - > Bool {
    返回true
 }
 ```
 
  只有当`-diffIdentifier的匹配是对象相等时才比较，所以你可以假设类是相同的，而且
  实例已经被检查过。
 */


@interface MonthSectionController : IGListBindingSectionController

@end

NS_ASSUME_NONNULL_END



