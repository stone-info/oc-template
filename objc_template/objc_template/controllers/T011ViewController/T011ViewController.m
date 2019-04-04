//
//  T011ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T011ViewController.h"

@interface T011ViewController ()
@property(weak, nonatomic) IBOutlet UIView* mView;

@end

@implementation T011ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (IBAction)pingyiButtonClicked:(UIButton*)sender {
  self.mView.alpha = 1;
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.5];

  CGRect frame = self.mView.frame;

  frame.origin.y -= 20;

  self.mView.frame = frame;

  [UIView commitAnimations];
}

- (IBAction)suofangButtonClicked:(UIButton*)sender {
  self.mView.alpha = 1;
  [UIView animateWithDuration:0.5
      animations:^{
        kScale(self.mView, 0.9, 0.9);
      }
      completion:^(BOOL finished) {
        self.view.backgroundColor = sn.randomColor;
      }];
}

- (IBAction)toumingButtonClicked:(UIButton*)sender {
  [UIView animateWithDuration:2.0
                        delay:0.0
                      options:UIViewAnimationOptionCurveEaseInOut
                   animations:^{
                     self.mView.alpha = 0.001;
                   }
                   completion:^(BOOL finished){

                   }];

  // kToast(self.view, @"hello worldhello worldhello worldhello worldhello
  // worldhello worldhello worldhello worldhello world")

  /** mView */
  // @property (weak, nonatomic) UIView *mView;
  UIView* view = [[UIView alloc] init];
  self.mView = view;

  view.backgroundColor = [UIColor orangeColor];

  [self.view addSubview:view];

  [view mas_makeConstraints:^(MASConstraintMaker* make) {
    // make.top.mas_equalTo(self.view.mas_top).offset(0);
    // make.left.mas_equalTo(self.view.mas_left).offset(0);
    // make.right.mas_equalTo(self.view.mas_right).offset(0);
    // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

    // make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));

    make.center.mas_equalTo(self.view);
    make.width.mas_equalTo(100);
    make.height.mas_equalTo(100);
  }];

  kToast(self.view, @"hello world 你好吗 世界");

  // NSString *text          = @"hello worldhello worldhello worldhello
  // worldhello worldhello worldhello worldhello worldhello world";
  // UIView   *containerView = self.view;
  // UIFont   *font          = kPingFangSCRegular(14);
  // CGFloat singLineHeight = [@"single"
  // stringHeightWithMaxWidth:containerView.bounds.size.width - 46.5 font:font];
  // CGFloat h              = [text
  // stringHeightWithMaxWidth:containerView.bounds.size.width - 46.5 font:font];
  //
  // MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:containerView
  // animated:YES];
  // hud.mode       = MBProgressHUDModeText;
  // hud.label.text = text;
  // hud.label.font = font;
  //
  // if (h > singLineHeight) {
  //   hud.label.textAlignment = NSTextAlignmentLeft;
  // } else {
  //   hud.label.textAlignment = NSTextAlignmentCenter;
  // }
  //
  // hud.label.numberOfLines = 0;
  // hud.offset              = CGPointMake(0.f, MBProgressMaxOffset);
  //
  // [hud hideAnimated:YES afterDelay:3.f];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little
preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
