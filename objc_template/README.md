 # TODO  IGListKit

## IGListBindingSectionController

## IGListCollectionViewLayout

开始使用IGListCollectionViewLayout , 而不是IGListGridCollectionViewLayout.

尚不支持scrollDirection方向。如果您需要水平滚动, 请使用UICollectionViewFlowLayout ) 或文件问题。

 
 ## ListBindingSectionController
ListBindingSectionController是我们为IGListKit构建的最强大的功能之一, 因为它进一步鼓励您设计小型、可组合的模型、视图和控制器。

 您还可以使用节控制器来处理任何交互, 以及处理突变, 就像控制器应该!

 如果您对其他主题有建议, 或希望提供更正, 请创建新问题!


 在 iOS 10 中, 引入了一种新的细胞预取 API.在 Instagam, 启用此功能会显著降低滚动性能。
 我们建议将 isPrefetchingEnabled (在 swift 中为false ). NO请注意, 默认值为true.

 您可以使用UIAppearance在全球范围内设置此设置:
 
```plain
 if ([[UICollectionView class] instancesRespondToSelector:@selector(setPrefetchingEnabled:)]) {
     [[UICollectionView appearance] setPrefetchingEnabled:NO];
 }
 if #available(iOS 10, *) {
     UICollectionView.appearance().isPrefetchingEnabled = false
 }

```


## 使用ListBindingSectionController的一个核心要
现在在Post内部添加一个ListDiffable实现:

// MARK: ListDiffable

func diffIdentifier() -> NSObjectProtocol {
  // 1
  return (username + timestamp) as NSObjectProtocol
}

// 2
func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
  return true
}
为每个帖子派生一个唯一标识符。由于一个帖子永远不应该有相同的username和timestamp组合, 我们可以从这个开始。
使用ListBindingSectionController的一个核心要求是, 如果两个模型具有相同diffIdentifier标识符, 则它们必须相等, 以便节控制器可以比较视图模型。


## 给模型设置 单独的主键 , 如果模型有ID 那更好 , 如果使用self , 永远不会进入 isEqualToDiffableObject 方法

https://stackoverflow.com/questions/42700448/iglistkit-with-sections-and-multiple-items

您应该为每个对象返回节控制器的唯一实例。不要重复使用它们！

另外需要注意的是，您正在使用self diff标识符，这意味着对象的实例标识其唯一性。这意味着两个DataSource对象永远不会被比较（obj.items.count == items.count永远不会发生）。不是一个交易破坏者，但只是意识到它的行为方式。

您还可能需要查看IGListBindingSectionController哪个采用原始模型并将其分解为驱动该部分中每个单元格的视图模型。

更多细节和拉取请求中的示例。请注意，如果您使用CocoaPods，则需要使用master。

https://github.com/Instagram/IGListKit/pull/494



## ListBindingSectionController , 中的这段代码 即便顶层model 传 YES 也会 更新section , 如果数据有变化的话, 这就放心了...呼...
https://github.com/Instagram/IGListKit/issues/1174
```objectivec
- (void)didUpdateToObject:(id)object {
    id oldObject = self.object;
    self.object = object;

    if (oldObject == nil) {
        self.viewModels = [[self.dataSource sectionController:self viewModelsForObject:object] copy];
    } else {
        IGAssert([oldObject isEqualToDiffableObject:object],
                 @"Unequal objects %@ and %@ will cause IGListBindingSectionController to reload the entire section",
                 oldObject, object);
        [self updateAnimated:YES completion:nil];
    }
}
```