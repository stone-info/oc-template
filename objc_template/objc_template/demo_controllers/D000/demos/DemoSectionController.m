//
//  DemoSectionController.m
//  objc_template
//
//  Created by stone on 2019/5/3.
//  Copyright © 2019 stone. All rights reserved.
//

#import "DemoSectionController.h"
#import "LabelCell.h"

@interface DemoItem ()

@end

@implementation DemoItem

- (instancetype)initWithName:(NSString *)name controllerClass:(Class)controllerClass {
  self = [super init];
  if (self) {
    self.name                 = name;
    self.controllerClass      = controllerClass;
    self.controllerIdentifier = nil;
  }
  return self;
}

- (instancetype)initWithName:(NSString *)name controllerClass:(Class)controllerClass controllerIdentifier:(NSString *)controllerIdentifier {
  self = [super init];
  if (self) {
    self.name                 = name;
    self.controllerClass      = controllerClass;
    self.controllerIdentifier = controllerIdentifier;
  }
  return self;
}

- (nonnull id <NSObject>)diffIdentifier {
  return self.name;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {

  if (self == other) { return YES; }

  if (!other) { return NO; }

  DemoItem *item = (DemoItem*)other;
  return (self.controllerClass == [item controllerClass] && [self.controllerIdentifier isEqualToString:[item controllerIdentifier]]);
}


@end

//sn_note:=========  ============================ stone 🐳 ===========/

@interface DemoSectionController ()

@property (strong, nonatomic) DemoItem *object;

@end

@implementation DemoSectionController

/**
 Returns the number of items in the section.

 @return A count of items in the list.

 @note The count returned is used to drive the number of cells displayed for this section controller. The default
 implementation returns 1. **Calling super is not required.**


  返回该section中的项目数。

  @return列表中的项目数。

  @note返回的计数用于驱动为此节控制器显示的单元格数。 默认
  实现返回1. **不需要调用super。**

 */
- (NSInteger)numberOfItems {
  return 1;
}

/**
 The specific size for the item at the specified index.

 @param index The row index of the item.

 @return The size for the item at index.

 @note The returned size is not guaranteed to be used. The implementation may query sections for their
 layout information at will, or use its own layout metrics. For example, consider a dynamic-text sized list versus a
 fixed height-and-width grid. The former will ask each section for a size, and the latter will likely not. The default
 implementation returns size zero. **Calling super is not required.**

 指定索引处项的特定大小。

 @param index项的行索引。

 @return索引处项目的大小。

 @note不保证使用返回的大小。 实现可以查询它们的部分
 随意布局信息，或使用自己的布局指标。 例如，考虑动态文本大小的列表与
 固定的高宽网格。 前者会询问每个部分的大小，后者可能不会。 默认
 实现返回大小为零。 **不需要调用super。**
 */
- (CGSize)sizeForItemAtIndex:(NSInteger)index {
  return CGSizeMake(self.collectionContext.containerSize.width, 55);
}

/**
 Return a dequeued cell for a given index.

 @param index The index of the requested row.

 @return A configured `UICollectionViewCell` subclass.

 @note This is your opportunity to do any cell setup and configuration. The infrastructure requests a cell when it
 will be used on screen. You should never allocate new cells in this method, instead use the provided adapter to call
 one of the dequeue methods on the IGListCollectionContext. The default implementation will assert. **You must override
 this method without calling super.**

 @warning Don't call this method to obtain a reference to currently dequeued cells: a new cell will be dequeued
 and returned, rather than the existing cell that you may have intended to retrieve. Instead, you can call
 `-cellForItemAtIndex:sectionController:` on `IGListCollectionContext` to obtain active cell references.
 */

/**
 返回给定索引的出列单元格。
 @param index请求行的索引。

 @return配置的`UICollectionViewCell`子类。

 @note这是您进行任何单元设置和配置的机会。 基础架构在请求单元时请求它
 将在屏幕上使用。 您永远不应该在此方法中分配新单元格，而是使用提供的适配器进行调用
 IGListCollectionContext上的一个dequeue方法。 默认实现将断言。 **你必须覆盖
 这个方法没有调用super。**

 @warning不要调用此方法来获取对当前出列单元格的引用：新单元格将出列
 并返回，而不是您可能要检索的现有单元格。 相反，你可以打电话
 `-cellForItemAtIndex：sectionController：`on` IGListCollectionContext`获取活动单元格引用。
 */
- (__kindof UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {

  LabelCell *cell = [self.collectionContext dequeueReusableCellOfClass:LabelCell.class forSectionController:self atIndex:index];

  cell.label.text = self.object.name;

  return cell;
}

/**
 Updates the section controller to a new object.

 @param object The object mapped to this section controller.

 @note When this method is called, all available contexts and configurations have been set for the section
 controller. This method will only be called when the object instance has changed, including from `nil` or a previous
 object. **Calling super is not required.**
 */
/**
 将节控制器更新为新对象。

 @param对象映射到此节控制器的对象。


 @note调用此方法时，已为该部分设置了所有可用的上下文和配置
控制器。 只有在对象实例发生变化时才会调用此方法，包括来自`nil`或previous
宾语。 **不需要拨打超级电话。**
*/
- (void)didUpdateToObject:(id)object {
  self.object = object;
}

/**
 Tells the section controller that the cell at the specified index path was selected.

 @param index The index of the selected cell.

 @note The default implementation does nothing. **Calling super is not required.**

 告诉段控制器选择了指定索引路径的单元。

  @param index所选单元格的索引。

  @note默认实现什么都不做。 **不需要拨打超级电话。**
 */
- (void)didSelectItemAtIndex:(NSInteger)index {
  NSString *identifier = self.object.controllerIdentifier;
  if (identifier) {
    UIStoryboard              *storyboard = [UIStoryboard storyboardWithName:@"Demo" bundle:nil];
    __kindof UIViewController *controller = [storyboard instantiateViewControllerWithIdentifier:identifier];
    controller.title = self.object.name;

    if (controller.view.backgroundColor) {
      // 有颜色
    } else {
      controller.view.backgroundColor = UIColor.whiteColor;
    }

    [self.viewController.navigationController pushViewController:controller animated:YES];
  } else {
    __kindof UIViewController *controller = (__kindof UIViewController *) [[self.object.controllerClass alloc] init];
    controller.title = self.object.name;

    if (controller.view.backgroundColor) {
      // 有颜色
    } else {
      controller.view.backgroundColor = UIColor.whiteColor;
    }

    [self.viewController.navigationController pushViewController:controller animated:YES];
  }
}

/**
 Tells the section controller that the cell at the specified index path was deselected.

 @param index The index of the deselected cell.

 @note The default implementation does nothing. **Calling super is not required.**
 告诉段控制器取消选择指定索引路径的单元。

  @param index取消选择的单元格的索引。

  @note默认实现什么都不做。 **不需要拨打超级电话。**
 */
- (void)didDeselectItemAtIndex:(NSInteger)index {
  NSLog(@"%s", __func__);
}

/**
 Tells the section controller that the cell at the specified index path was highlighted.

 @param index The index of the highlighted cell.

 @note The default implementation does nothing. **Calling super is not required.**

 告诉段控制器指定索引路径上的单元格是否突出显示。

  @param index突出显示的单元格的索引。

  @note默认实现什么都不做。 **不需要拨打超级电话。**

 */
- (void)didHighlightItemAtIndex:(NSInteger)index {
  // NSLog(@"%s", __func__);
}

/**
 Tells the section controller that the cell at the specified index path was unhighlighted.

 @param index The index of the unhighlighted cell.

 @note The default implementation does nothing. **Calling super is not required.**
 告诉段控制器指定索引路径上的单元格未被突出显示。

  @param index未突出显示的单元格的索引。

  @note默认实现什么都不做。 **不需要拨打超级电话。**
 */
- (void)didUnhighlightItemAtIndex:(NSInteger)index {
  // NSLog(@"%s", __func__);
}

/**
 Identifies whether an object can be moved through interactive reordering.

 @param index The index of the object in the list.

 @return `YES` if the object is allowed to move, otherwise `NO`.

 @note Interactive reordering is supported both for items within a single section, as well as for reordering sections
 themselves when sections contain only one item. The default implementation returns false.

 标识是否可以通过交互式重新排序移动对象。

  @param index列表中对象的索引。

  @return`YES`如果允许移动对象，否则为“NO”。

  @note交互式重新排序既支持单个部分中的项目，也支持重新排序部分
  部分只包含一个项目时自己。 默认实现返回false。

 */
- (BOOL)canMoveItemAtIndex:(NSInteger)index {
  return NO;
}

/**
 Notifies the section that a list object should move within a section as the result of interactive reordering.

 @param sourceIndex The starting index of the object.
 @param destinationIndex The ending index of the object.

 @note this method must be implemented if interactive reordering is enabled.

 作为交互式重新排序的结果，通知该部分列表对象应在一个部分内移动。

  @param sourceIndex对象的起始索引。
  @param destinationIndex对象的结束索引。

  @note如果启用了交互式重新排序，则必须实现此方法。
 */
- (void)moveObjectFromIndex:(NSInteger)sourceIndex toIndex:(NSInteger)destinationIndex NS_AVAILABLE_IOS(9_0) {
  NSLog(@"%s", __func__);
}

/**
 The view controller housing the adapter that created this section controller.

 @note Use this view controller to push, pop, present, or do other custom transitions.

 @warning It is considered very bad practice to cast this to a known view controller
 and call methods on it other than for navigations and transitions.

 视图控制器容纳创建此部分控制器的适配器。

  @note使用此视图控制器来推送，弹出，显示或执行其他自定义转换。

  @warning将此转换为已知的视图控制器被认为是非常糟糕的做法
  并在其上调用方法而不是导航和转换。
 */
// @property (nonatomic, weak, nullable, readonly) UIViewController *viewController;

/**
 A context object for interacting with the collection.

 Use this property for accessing the collection size, dequeuing cells, reloading, inserting, deleting, etc.

 用于与集合交互的上下文对象。

  使用此属性可以访问集合大小，出列单元格，重新加载，插入，删除等。

 */
// @property (nonatomic, weak, nullable, readonly) id <IGListCollectionContext> collectionContext;

/**
 Returns the section within the list for this section controller.

 @note This value also relates to the section within a `UICollectionView` that this section controller's cells belong.
 It also relates to the `-[NSIndexPath section]` value for individual cells within the collection view.

  返回此节控制器列表中的节。

  @note此值还与此部分控制器的单元格所属的`UICollectionView`中的部分有关。
  它还涉及集合视图中单个单元格的` -  [NSIndexPath section]`值。

 */
// @property (nonatomic, assign, readonly) NSInteger section;

/**
 Returns `YES` if the section controller is the first section in the list, `NO` otherwise.
 如果节控制器是列表中的第一个节，则返回“是”，否则返回“否”。
 */
// @property (nonatomic, assign, readonly) BOOL isFirstSection;

/**
 Returns `YES` if the section controller is the last section in the list, `NO` otherwise.
 如果节控制器是列表中的最后一节，则返回“是”，否则返回“否”。
 */
// @property (nonatomic, assign, readonly) BOOL isLastSection;

/**
 The margins used to lay out content in the section controller.
边距用于在节控制器中布置内容。
 @see `-[UICollectionViewFlowLayout sectionInset]`.
 */
// @property (nonatomic, assign) UIEdgeInsets inset;

/**
 The minimum spacing to use between rows of items.
项目行之间使用的最小间距。
 @see `-[UICollectionViewFlowLayout minimumLineSpacing]`.
 */
// @property (nonatomic, assign) CGFloat minimumLineSpacing;

/**
 The minimum spacing to use between items in the same row.
 在同一行中的项目之间使用的最小间距。

 @see `-[UICollectionViewFlowLayout minimumInteritemSpacing]`.
 */
// @property (nonatomic, assign) CGFloat minimumInteritemSpacing;

/**
 The supplementary view source for the section controller. Can be `nil`.

 @return An object that conforms to `IGListSupplementaryViewSource` or `nil`.

 @note You may wish to return `self` if your section controller implements this protocol.

 部分控制器的补充视图源。 可以是'nil`。
Supplementary : adj. 增补的; 补充的
  @return符合`IGListSupplementaryViewSource`或`nil`的对象。

  @note如果你的节控制器实现了这个协议，你可能希望返回`self`。

 */
// @property (nonatomic, weak, nullable) id <IGListSupplementaryViewSource> supplementaryViewSource;

/**
 An object that handles display events for the section controller. Can be `nil`.

 @return An object that conforms to `IGListDisplayDelegate` or `nil`.

 @note You may wish to return `self` if your section controller implements this protocol.

 处理节控制器的显示事件的对象。 可以是'nil`。

  @return符合`IGListDisplayDelegate`或`nil`的对象。

  @note如果你的节控制器实现了这个协议，你可能希望返回`self`。
 */
// @property (nonatomic, weak, nullable) id <IGListDisplayDelegate> displayDelegate;

/**
 An object that handles working range events for the section controller. Can be `nil`.

 @return An object that conforms to `IGListWorkingRangeDelegate` or `nil`.

 @note You may wish to return `self` if your section controller implements this protocol.

 处理节控制器的工作范围事件的对象。 可以是'nil`。

  @return符合`IGListWorkingRangeDelegate`或`nil`的对象。

  @note如果你的节控制器实现了这个协议，你可能希望返回`self`。

 */
// @property (nonatomic, weak, nullable) id <IGListWorkingRangeDelegate> workingRangeDelegate;

/**
 An object that handles scroll events for the section controller. Can be `nil`.

 @return An object that conforms to `IGListScrollDelegate` or `nil`.

 @note You may wish to return `self` if your section controller implements this protocol.

 处理节控制器的滚动事件的对象。 可以是'nil`。

  @return符合`IGListScrollDelegate`或`nil`的对象。

  @note如果你的节控制器实现了这个协议，你可能希望返回`self`。

 */
// @property (nonatomic, weak, nullable) id <IGListScrollDelegate> scrollDelegate;

/**
 An object that handles transition events for the section controller. Can be `nil`.

 @return An object that conforms to `IGListTransitionDelegat` or `nil`.

 @note You may wish to return `self` if your section controller implements this protocol.

 处理节控制器的转换事件的对象。 可以是'nil`。

  @return符合`IGListTransitionDelegat`或`nil`的对象。

  @note如果你的节控制器实现了这个协议，你可能希望返回`self`。

 */
// @property (nonatomic, weak, nullable) id<IGListTransitionDelegate> transitionDelegate;

@end
