//
//  T034ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T034ViewController.h"

static const int w = 300;
static int       i = 1;

@interface T034ViewController ()

@property (nonatomic, strong) MASConstraint *heightConstraint;
@property (weak, nonatomic) SNImageView     *imageView;
@property (weak, nonatomic) SNLabel         *label;
@end

@implementation T034ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  SNImageView *imageView = [SNImageView makeImageViewWithOptions:@{
    @"borderRadius"   : @4.F,
    @"masksToBounds"  : @(YES),
    @"backgroundColor": HexRGBA(@"#CCCCCC", 1.0),
    @"contentMode"    : @(UIViewContentModeScaleToFill),
    // imageView需要这步操作, 因为layer.contents
    // 光栅化
    @"shouldRasterize": @(YES),
    // UI优化
    // https://www.jianshu.com/p/85837799f3eb
    @"opaque"         : @(YES),
    // @"glass"          : @(YES),
    @"image"          : kImageWithName(kStringFormat(@"abc0%02d", i)),
  }];

  self.imageView = imageView;

  SNLabel *label = [SNLabel makeLabelWithOptions:@{
    @"backgroundColor": [UIColor whiteColor],
    @"textColor"      : [UIColor blackColor],
    @"font"           : [UIFont fontWithName:@"PingFangSC-Regular" size:14],
    @"text"           : kStringFormat(@"abc0%02d", i),
    @"borderColor"    : HexRGBA(@"#cccccc", 1.0),
    @"borderWidth"    : @1.0,
    @"masksToBounds"  : @YES,
    //    @"lineHeight"     : @8,
    //    @"letterSpacing"  : @.5f,
    @"lineBreakMode"  : @(NSLineBreakByTruncatingTail)
  }];
  self.label          = label;
  label.textAlignment = NSTextAlignmentCenter;

  kBorder(label);

  [self.view addSubview:label];

  kBorder(imageView);

  [self.view addSubview:imageView];

  imageView.mas_key = @"你麻痹imageView";

  // MASAttachKeys(imageView);
  [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.edges.insets(UIEdgeInsetsZero);
    // make.center.mas_equalTo(self.view);

    /** full */
    // CGFloat d = kStatusBarHeight + kNavigationBarHeight + 10;
    CGFloat d = 10;
    make.top.mas_equalTo(self.view.mas_top).offset(d);
    make.left.mas_equalTo(self.view.mas_left).offset(10);
    // make.right.mas_equalTo(self.view.mas_right).offset(0);
    // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

    /** width & height */
    make.width.mas_equalTo(w);
    self.heightConstraint = make.height.mas_equalTo(sn.suggestHeight(w, imageView.image));

    // make.size.mas_equalTo(100);
  }];

  // UIView *view;

  // kMasKey(view);
  //
  // [view mas_makeConstraints:^(MASConstraintMaker *make) {
  //   make.edges.insets(UIEdgeInsetsZero);
  //   // make.center.mas_equalTo(self.view);
  //
  //   /** full */
  //   // make.top.mas_equalTo(self.view.mas_top).offset(0);
  //   // make.left.mas_equalTo(self.view.mas_left).offset(0);
  //   // make.right.mas_equalTo(self.view.mas_right).offset(0);
  //   // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
  //
  //   /** width & height */
  //   // make.width.mas_equalTo(100);
  //   // make.height.mas_equalTo(100);
  //   // make.size.mas_equalTo(100);
  //
  //   // @property (nonatomic, strong) MASConstraint *heightConstraint;
  //   // self.heightConstraint = make.height.mas_equalTo(100);
  //
  //   // make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10).priorityHigh();;
  //   // make.bottom.mas_equalTo(self.view.mas_bottom).offset(-100).priorityLow();
  // }];





  // NSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)


  // NSString *filename = [[NSString stringWithFormat:@"%s", __FILE__] lastPathComponent];
  // NSString *result   = [NSString stringWithFormat:@"%@:%d", filename, __LINE__];
  // label.mas_key = [NSString stringWithFormat:@"%@ -> %@", result, @"label"];
  // MASAttachKeys(imageView, @"你麻痹Label");

  kMasKey(label);
  [label mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.edges.insets(UIEdgeInsetsZero);
    // make.center.mas_equalTo(self.view);

    /** full */
    make.top.mas_equalTo(imageView.mas_bottom).offset(10);
    make.left.mas_equalTo(self.view.mas_left).offset(10);
    make.right.mas_equalTo(self.view.mas_right).offset(-10);
    // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

    /** width & height */
    make.width.mas_equalTo(100);
    // make.height.mas_equalTo(100);
    // make.size.mas_equalTo(100);
  }];

  SNImageView *mImageView = [SNImageView makeImageViewWithOptions:kImageViewNormalTemplate];
  mImageView.image = [UIImage imageNamed:@"abc001"];
  [self.view addSubview:mImageView];

  kMasKey(mImageView);
  [mImageView mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.edges.insets(UIEdgeInsetsZero);
    make.center.mas_equalTo(self.view);

    /** full */
    // make.top.mas_equalTo(self.view.mas_top).offset(0);
    // make.left.mas_equalTo(self.view.mas_left).offset(0);
    // make.right.mas_equalTo(self.view.mas_right).offset(0);
    // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

    /** width & height */
    make.width.mas_equalTo(100);
    CGFloat h = sn.suggestHeight(100, mImageView.image);
    make.height.mas_equalTo(h);
    // make.size.mas_equalTo(100);
  }];

  SNLabel *snLabel = [SNLabel makeLabelWithOptions:kLabelNormalTemplate];

  // snLabel.textAlignment = NSTextAlignmentCenter;
  snLabel.text = @"When you are old and grey and full of sleep, ";
  // snLabel.numberOfLines = 0;
  [self.view addSubview:snLabel];

  // kMasKey(snLabel);
  // [snLabel mas_makeConstraints:^(MASConstraintMaker *make) {
  //   // make.edges.insets(UIEdgeInsetsZero);
  //   // make.center.mas_equalTo(self.view);
  //   make.centerY.mas_equalTo(self.view);
  //
  //   /** full */
  //   // make.top.mas_equalTo(self.view.mas_top).offset(0);
  //   make.left.mas_equalTo(self.view.mas_left).offset(10);
  //   make.right.mas_equalTo(self.view.mas_right).offset(-10);
  //   // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);
  //
  //   /** width & height */
  //   // make.width.mas_equalTo(100);
  //   // make.height.mas_equalTo(100);
  //   // make.size.mas_equalTo(100);
  // }];

  // snLabel.textAlignment = NSTextAlignmentLeft;
  // snLabel.lineHeight    = 18;

  kMasKey(snLabel);
  [snLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.edges.insets(UIEdgeInsetsZero);
    // make.center.mas_equalTo(self.view);
    make.center.mas_equalTo(self.view);

    /** full */
    // make.top.mas_equalTo(self.view.mas_top).offset(0);
    make.left.mas_greaterThanOrEqualTo(self.view.mas_left).offset(10);
    make.right.mas_lessThanOrEqualTo(self.view.mas_right).offset(-10);
    // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

    /** width & height */
    // make.width.mas_equalTo(100);
    // make.height.mas_equalTo(100);
    // make.size.mas_equalTo(100);
  }];

  NSLog(@"snLabel.attributedText = %@", snLabel.attributedText);

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

  NSString *name = kStringFormat(@"abc0%02d", ++i);

  self.label.text = name;

  self.imageView.image = kImageWithName(name);

  if (i == 30) { i = 0; }

  // 告诉self.view约束需要更新
  // [self.view setNeedsUpdateConstraints]; // 延迟执行...
  // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
  // [self.view updateConstraintsIfNeeded]; //立即执行 ...
  // 观察名字, setNeeds , ifNeeded , 其他部分的名字相同UpdateConstraints

  MASAttachKeys(self.imageView);
  [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
    // make.width.mas_equalTo(230);
    // make.height.mas_equalTo(230); // 更新基本数据类型的时候 就会重新赋值, 不会叠加约束...
    make.height.mas_equalTo(sn.suggestHeight(w, self.imageView.image));
    // make.height.mas_equalTo(self.mImageView.width * height / width);
  }];

  // [UIView animateWithDuration:0.5 animations:^{
  //   [self.view layoutIfNeeded];
  // } completion:^(BOOL finished) {}];

  [self.view setNeedsUpdateConstraints];
}

- (void)updateViewConstraints {
  // heightConstraint
  // [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
  //   // make.width.mas_equalTo(230);
  //   // make.height.mas_equalTo(230); // 更新基本数据类型的时候 就会重新赋值, 不会叠加约束...
  //   make.height.mas_equalTo(sn.suggestHeight(w, self.imageView.image));
  //   // make.height.mas_equalTo(self.mImageView.width * height / width);
  // }];
  [UIView animateWithDuration:0.5 animations:^{
    [self.view layoutIfNeeded];
  } completion:^(BOOL finished) {}];

  [super updateViewConstraints];
}

@end

// https://blog.csdn.net/gang544043963/article/details/52440621
// - (void)updateConstraintsIfNeeded
// 官网文档的解释：
//
// Updates the constraints for the receiving view and its subviews.
// Whenever a new layout pass is triggered for a view, the system invokes this method to ensure that any constraints for the view and its subviews are updated with information from the current view hierarchy and its constraints. This method is called automatically by the system, but may be invoked manually if you need to examine the most up to date constraints.
// Subclasses should not override this method.
//
// 更新视图和它的子视图的约束。
// 每当一个新的布局，通过触发一个视图，系统调用此方法以确保视图和其子视图的任何约束与当前视图层次结构和约束信息更新。这种方法被系统自动调用，但如果需要检查最新的约束条件，可以手动调用这个方法。
// 子类不应重写此方法。
//
// 注解：立即出发约束更新。      
//
//
//
// - (void)updateConstraints
// 官网文档的解释：
//
// Updates constraints for the view.
// Custom views that set up constraints themselves should do so by overriding this method. When your custom view notes that a change has been made to the view that invalidates one of its constraints, it should immediately remove that constraint, and then call setNeedsUpdateConstraints to note that constraints need to be updated. Before layout is performed, your implementation of updateConstraints will be invoked, allowing you to verify that all necessary constraints for your content are in place at a time when your custom view’s properties are not changing.
// You must not invalidate any constraints as part of your constraint update phase. You also must not invoke a layout or drawing phase as part of constraint updating.
// Important:Important
// Call [super updateConstraints] as the final step in your implementation.
//
// 更新视图的约束。
//
// 自定义视图应该通过重写此方法来设置自己的约束。当你的自定义视图有某个约束发生了变化或失效了，应该立即删除这个约束，然后调用setNeedsUpdateConstraints标记约束需要更新。系统在进行布局layout之前，会调用updateConstraints，让你确认（设置）在视图的属性不变时的必要约束。在更新约束阶段你不应该使任何一个约束失效，而且不能让layerout和drawing作为更新约束的一部分。
//
// 重要提示：要在实现的最后调用[super updateConstraints]。
//
// 注解：自定义view应该重写此方法在其中建立constraints.
//
//
//
// - (BOOL)needsUpdateConstraints
// 这个很简单，返回是否需要更新约束。constraint-based layout system使用此返回值去决定是否需要调用updateConstraints作为正常布局过程的一部分。
//
//
//
// - (void)setNeedsUpdateConstraints
// 官方文档解释：
//
// Controls whether the view’s constraints need updating.
// When a property of your custom view changes in a way that would impact constraints, you can call this method to indicate that the constraints need to be updated at some point in the future. The system will then call updateConstraints as part of its normal layout pass. Updating constraints all at once just before they are needed ensures that you don’t needlessly recalculate constraints when multiple changes are made to your view in between layout passes.
//
// 控制视图的约束是否需要更新。
// 当你的自定义视图的属性改变切影响到约束，你可以调用这个方法来标记未来的某一点上需要更新的约束。然后系统将调用updateconstraints。
//
// 注解：这个方法和updateConstraintsIfNeeded关系有点暧昧，updateConstraintsIfNeeded是立即更新，二这个方法是标记需要更新，然后系统决定更新时机。

//note:=== content === 2019-03-31 ====================================/

// Core Layout Methods

/* To render a window, the following passes will occur, if necessary.

 update constraints
 layout
 display

 Please see the conceptual documentation for a discussion of these methods.
 */

// @interface UIView (UIConstraintBasedLayoutCoreMethods)
// - (void)updateConstraintsIfNeeded NS_AVAILABLE_IOS(6_0); // Updates the constraints from the bottom up for the view hierarchy rooted at the receiver. UIWindow's implementation creates a layout engine if necessary first.
// - (void)updateConstraints NS_AVAILABLE_IOS(6_0) NS_REQUIRES_SUPER; // Override this to adjust your special constraints during a constraints update pass
// - (BOOL)needsUpdateConstraints NS_AVAILABLE_IOS(6_0);
// - (void)setNeedsUpdateConstraints NS_AVAILABLE_IOS(6_0);
// @end

//note:=== content === 2019-03-31 ====================================/

// @interface UIViewController (UIConstraintBasedLayoutCoreMethods)
// /* Base implementation sends -updateConstraints to the view.
//     When a view has a view controller, this message is sent to the view controller during
//      the autolayout updateConstraints pass in lieu of sending updateConstraints directly
//      to the view.
//     You may override this method in a UIViewController subclass for updating custom
//      constraints instead of subclassing your view and overriding -[UIView updateConstraints].
//     Overrides must call super or send -updateConstraints to the view.
//  */
// - (void)updateViewConstraints NS_AVAILABLE_IOS(6_0);
// @end