//
//  T023ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T023ViewController.h"
#import "SNView.h"

@interface T023ViewController ()

@property (nonatomic, weak) SNView *mView;
@end

@implementation T023ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  [self makeView];
  [self test1];
}

- (void)makeView {
  SNView *view = [SNView makeViewWithOptions:@{
    @"backgroundColor": [UIColor whiteColor],
    @"borderWidth"    : @1.0,
    @"borderRadius"   : @4.f,
    @"masksToBounds"  : @YES,
    @"action"         : ^void(UITapGestureRecognizer *sender) {
      NSLog(@"hello world");
    },
  }];

  self.mView = view;

  [self.view addSubview:view];
}

- (void)injected {
  [self.view removeAllSubviews];
  [self makeView];
  [self test1];

}

- (void)test1 {

  [self.mView mas_makeConstraints:^(MASConstraintMaker *make) {
    /** full */
    // make.top.mas_equalTo(self.view.mas_top).offset(0);
    // make.left.mas_equalTo(self.view.mas_left).offset(0);
    // make.right.mas_equalTo(self.view.mas_right).offset(0);
    // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

    /** full simple */
    // make.top.left.offset(20);
    // make.right.bottom.offset(-20);
    // make.top.left;
    // make.right.bottom;

    /** edges */
    // make.edges.mas_equalTo(self.view).insets(UIEdgeInsetsMake(20, 20, 20, 20));
    make.edges.insets(UIEdgeInsetsZero);
    /** center */
    // make.centerX.mas_equalTo(self.view.mas_centerX);
    // make.centerY.mas_equalTo(self.view.mas_centerY);
    // make.center.mas_equalTo(self.view);
    // make.center;

    /** width & height */
    // make.width.mas_equalTo(100);
    // make.height.mas_equalTo(100);
    // make.size.mas_equalTo(100);
  }];



}


@end
