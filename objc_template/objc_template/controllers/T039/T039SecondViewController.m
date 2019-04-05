//
//  T039SecondViewController.m
//  objc_template
//
//  Created by stone on 2019/4/6.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T039SecondViewController.h"

@interface T039SecondViewController ()

@end

@implementation T039SecondViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Do any additional setup after loading the view.

  //secondPageController.m 执行代理方法
  // 判断代理信号是否有值
  self.view.backgroundColor = UIColor.orangeColor;

  self.title = kStringFormat(@"%@", NSStringFromClass(self.class));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  if (self.delegateSignal) {
    [self.delegateSignal sendNext:@"我是secondPage传来的值"];
  }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
