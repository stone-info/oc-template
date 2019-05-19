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

## MVVM

- `View可以引用ViewModel`，但反过来不行 viewModel 不能引用 view, #import 不要写UIKit.h（即：不要在ViewModel中引入#import UIKit.h，任何视图本身的引用都不能放在ViewModel中），
- `ViewModel可以引用Model`，但反过来不行。model 不能引用 viewModel

- MVVM可以兼容当前你使用的MVC架构，也可以增加你开发的应用的可测试性;MVVM配合一个绑定机制效果最好（eg:ReactiveCocoa）。
- ViewController尽量不要涉及业务逻辑，让ViewModel去做业务逻辑；ViewController 只是一个“中间人”，
接收View的事件、调用ViewModel的方法、响应ViewModel的变化；ViewModel 绝不能包含视图View（UIKit.h），否则就跟View产生耦合，不方便复用和测试。


![enter image description here](https://upload-images.jianshu.io/upload_images/6849686-8634e511c5ec6378?imageMogr2/auto-orient/strip%7CimageView2/2/w/1000/format/webp)


#Objective-c 中 #import 和 @class 的区别
objective c 中 #import 和 @class 都可以从引入一个类。 二者的区别在于：

1. `#import` 会包含这个类的所有信息，包括实体变量和方法，而 @class 只是告诉编译器，其后面声明的名称是类的名称，至于这些类是如何定义的，暂时不用考虑。
2. 在头文件中，一般只需要知道被引用的类的名称就可以了。 不需要知道其内部的实体变量和方法，所以在头文件中一般使用 @class 来声明这个名称是类的名称。 而在实现类里面，因为会用到这个引用类的内部的实体变量和方法，所以需要使用 #import 来包含这个被引用类的头文件。
3. 在编译效率方面考虑，如果你有100个头文件都 #import 了同一个头文件，或者这些文件是依次引用的，如 A–>B, B–>C, C–>D 这样的引用关系。当最开始的那个头文件有变化的话，后面所有引用它的类都需要重新编译，如果你的类有很多的话，这将耗费大量的时间。而是用 @class则不会。
4. 如果有循环依赖关系，如:A–>B, B–>A这样的相互依赖关系，如果使用 #import 来相互包含，那么就会出现编译错误，如果使用 @class 在两个类的头文件中相互声明，则不会有编译错误出现。
所以，一般来说，@class 是放在 interface 中的，只是为了在 interface 中引用这个类，把这个类作为一个类型来用的。 在实现这个接口的实现类中，如果需要引用这个类的实体变量或者方法之类的，还是需要 import 在 @class 中声明的类进来.   使用@class，只能用来定义变量，不能继承，也不能调用该类的方法和变量。使用 #import 则可以进行。