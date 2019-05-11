//
//  DemoViewController.m
//  objc_template
//
//  Created by stone on 2019-05-11.
//  Copyright © 2019 stone. All rights reserved.
//
#import "DemoViewController.h"
#import <IGListKit/IGListKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoViewModel : NSObject <IGListDiffable>
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *controllerName;
@property (assign, nonatomic) BOOL   xib;
@property (assign, nonatomic) BOOL   storyboard;

- (instancetype)initWithTitle:(NSString *)title controllerName:(NSString *)controllerName xib:(BOOL)xib storyboard:(BOOL)storyboard;

- (NSString *)description;

+ (instancetype)modelWithTitle:(NSString *)title controllerName:(NSString *)controllerName xib:(BOOL)xib storyboard:(BOOL)storyboard;

@end

NS_ASSUME_NONNULL_END

@implementation DemoViewModel

- (instancetype)initWithTitle:(NSString *)title controllerName:(NSString *)controllerName xib:(BOOL)xib storyboard:(BOOL)storyboard {
  self = [super init];
  if (self) {
    self.title          = title;
    self.controllerName = controllerName;
    self.xib            = xib;
    self.storyboard     = storyboard;
  }

  return self;
}

+ (instancetype)modelWithTitle:(NSString *)title controllerName:(NSString *)controllerName xib:(BOOL)xib storyboard:(BOOL)storyboard {
  return [[self alloc] initWithTitle:title controllerName:controllerName xib:xib storyboard:storyboard];
}

- (nonnull id <NSObject>)diffIdentifier {
  return self;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  if (!other) { return NO; }
  if (self == other) { return YES; }
  DemoViewModel *model = (DemoViewModel *) other;
  return [self.title isEqualToString:model.title] &&
         [self.controllerName isEqualToString:model.controllerName] &&
         self.xib == model.xib &&
         self.storyboard == model.storyboard;
}

- (NSString *)description {
  NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
  [description appendFormat:@"self.title=%@", self.title];
  [description appendFormat:@", self.controllerName=%@", self.controllerName];
  [description appendFormat:@", self.xib=%@", self.xib ? @"true" : @"false"];
  [description appendFormat:@", self.storyboard=%@", self.storyboard ? @"true" : @"false"];
  [description appendString:@">"];
  return description;
}


@end

//sn_note:=========  ============================ stone 🐳 ===========/

NS_ASSUME_NONNULL_BEGIN

@interface DemoViewCell : UICollectionViewCell
@property (weak, nonatomic) UILabel *label;

@end

NS_ASSUME_NONNULL_END

@implementation DemoViewCell {
  __strong CALayer *_separator;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    UILabel *label = UILabel.new;
    _label         = label;
    label.font = kPingFangSCRegular(12);
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) { make.edges.insets(UIEdgeInsetsMake(8, 8, 8, 8)); }];

    CALayer *separator = [CALayer new];
    _separator = separator;
    separator.backgroundColor = HexRGBA(@"#C0C0C0", 1.0).CGColor;
    // separator.frame           = CGRectMake(0, 0, kScreenWidth, 10);
    [self.contentView.layer addSublayer:separator];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGRect  bounds = self.contentView.bounds;
  CGFloat height = 0.5;
  _separator.frame = CGRectMake(0, bounds.size.height - height, bounds.size.width, height);
}

@end

//sn_note:=========  ============================ stone 🐳 ===========/

@interface DemoViewController () <IGListAdapterDataSource, IGListSingleSectionControllerDelegate>
@property (strong, nonatomic) UICollectionView         *collectionView;
@property (strong, nonatomic) IGListAdapter            *adapter;
@property (strong, nonatomic) UILabel                  *emptyLabel;
@property (strong, nonatomic) NSArray<DemoViewModel *> *dataList;
@end

@implementation DemoViewController

- (UILabel *)emptyLabel {

  if (_emptyLabel == nil) {
    _emptyLabel = [UILabel new];
    _emptyLabel.numberOfLines   = 0;
    _emptyLabel.textAlignment   = NSTextAlignmentCenter;
    _emptyLabel.text            = @"No more data!";
    _emptyLabel.backgroundColor = UIColor.clearColor;
  }
  return _emptyLabel;
}

- (NSArray<DemoViewModel *> *)dataList {

  if (_dataList == nil) {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"demo_data" ofType:@"plist"];

    NSArray *dataList = [NSArray arrayWithContentsOfFile:bundlePath];

    dataList = [[dataList reverseObjectEnumerator] allObjects];

    NSMutableArray *arrM = [NSMutableArray array];

    for (NSUInteger i = 0; i < dataList.count; ++i) {
      NSDictionary<NSString *, NSString *> *dict  = dataList[i];
      DemoViewModel                        *model = [DemoViewModel modelWithTitle:dict[@"title"] controllerName:dict[@"controllerName"] xib:[dict[@"xib"] boolValue] storyboard:[dict[@"storyboard"] boolValue]];
      [arrM addObject:model];
      // [arrM insertObject:model atIndex:0];
    }

    _dataList = arrM;
  }
  return _dataList;
}

- (UICollectionView *)collectionView {

  if (_collectionView == nil) {
    UICollectionViewFlowLayout *flowLayout = UICollectionViewFlowLayout.new;
    // flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    // flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = UIColor.whiteColor;
    // _collectionView.alwaysBounceVertical   = YES;
    // _collectionView.alwaysBounceHorizontal = YES;
    // _collectionView.pagingEnabled          = YES;
  }
  return _collectionView;
}

- (IGListAdapter *)adapter {

  if (_adapter == nil) {
    _adapter = [[IGListAdapter alloc] initWithUpdater:IGListAdapterUpdater.new viewController:self];
    _adapter.dataSource = self;
  }
  return _adapter;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  self.view.backgroundColor = UIColor.whiteColor;
  // make layout
  [self.view addSubview:self.collectionView];

  [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.insets(UIEdgeInsetsMake(kStatusBarHeight + kNavigationBarHeight, 0, kSafeAreaBottomHeight, 0));
  }];
  self.adapter.collectionView = self.collectionView;

  if (@available(iOS 11.0, *)) {
    // 取消自动调整内边距
    self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  } else {
    self.automaticallyAdjustsScrollViewInsets = NO;
  }

  // printf("■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■\n");

  // auto push
  if (kAutoPush) {
    DemoViewModel *model = self.dataList.firstObject;

    UIViewController *viewController;

    if (model.xib == YES) {
      /** 根据xib 获取 viewController */
      viewController = [(UIViewController *) [NSClassFromString(model.controllerName) alloc] initWithNibName:model.controllerName bundle:nil];
    } else if (model.storyboard == YES) {
      /** 根据storyboard 获取 viewController */
      viewController = [[UIStoryboard storyboardWithName:model.controllerName bundle:nil] instantiateViewControllerWithIdentifier:model.controllerName];
    } else {
      viewController = [(UIViewController *) [NSClassFromString(model.controllerName) alloc] init];
    }

    if (viewController.view.backgroundColor) {
      // 有颜色
    } else {
      viewController.view.backgroundColor = UIColor.whiteColor;
    }

    viewController.title = kStringFormat(@"%03ld-%@", self.dataList.count - 1, model.title);

    [self.navigationController pushViewController:viewController animated:YES];
  }
}

// - (void)viewDidLayoutSubviews {
//   [super viewDidLayoutSubviews];
//
//   CGFloat y      = kStatusBarHeight + kNavigationBarHeight;
//   CGFloat height = kScreenHeight - y - kSafeAreaBottomHeight;
//   self.collectionView.frame = CGRectMake(0, y, kScreenWidth, height);
// }

#pragma mark - <IGListAdapterDataSource>

// 返回遵守IGListDiffable协议的 对象数组, @(1) number类型和 字符串 好像默认遵守了该协议, 待研究
- (NSArray<id <IGListDiffable>> *)objectsForListAdapter:(IGListAdapter *)listAdapter {

  return self.dataList;
}

// 绑定 model和cell的 viewModel
- (IGListSectionController *)listAdapter:(IGListAdapter *)listAdapter sectionControllerForObject:(id)object {

  DemoViewModel *model = (DemoViewModel *) object;

  IGListSingleSectionController *sectionController = [IGListSingleSectionController.alloc
    initWithCellClass:DemoViewCell.class
    configureBlock:^(id item, __kindof DemoViewCell *cell) {
      // cell.contentView.backgroundColor = sn.randomColor;
      cell.label.text = kStringFormat(@"%03li-%@", (self.dataList.count - 1) - [listAdapter sectionForObject:item], model.title);
    }
    sizeBlock:^CGSize(id item, id <IGListCollectionContext> collectionContext) {
      if (collectionContext) {
        return CGSizeMake(collectionContext.containerSize.width, 55);
      } else {
        return CGSizeZero;
      }
    }];

  sectionController.selectionDelegate = self;

  return sectionController;
}

// 无数据时 显示用的View;
- (nullable UIView *)emptyViewForListAdapter:(IGListAdapter *)listAdapter {
  return self.emptyLabel;
}

#pragma mark - <IGListSingleSectionControllerDelegate>

- (void)didSelectSectionController:(IGListSingleSectionController *)sectionController withObject:(id)object {

  DemoViewModel *model = (DemoViewModel *) object;

  UIViewController *viewController;

  if (model.xib == YES) {
    /** 根据xib 获取 viewController */
    viewController = [(UIViewController *) [NSClassFromString(model.controllerName) alloc] initWithNibName:model.controllerName bundle:nil];
  } else if (model.storyboard == YES) {
    /** 根据storyboard 获取 viewController */
    viewController = [[UIStoryboard storyboardWithName:model.controllerName bundle:nil] instantiateViewControllerWithIdentifier:model.controllerName];
  } else {
    viewController = [(UIViewController *) [NSClassFromString(model.controllerName) alloc] init];
  }

  if (viewController.view.backgroundColor) {
    // 有颜色
  } else {
    viewController.view.backgroundColor = UIColor.whiteColor;
  }

  NSLog(@"viewController = %@", viewController);
  viewController.view.backgroundColor = UIColor.whiteColor;

  // NSUInteger i = self.dataList.count - (NSUInteger) indexPath.row - 1;

  viewController.title = kStringFormat(@"%03li-%@", ((self.dataList.count - 1) - sectionController.section), model.title);

  [self.navigationController pushViewController:viewController animated:YES];
}

// - (void)didDeselectSectionController:(IGListSingleSectionController *)sectionController withObject:(id)object {
//
// }
@end
