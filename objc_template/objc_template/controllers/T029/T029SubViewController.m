//
//  T029SubViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T029SubViewController.h"

@interface T029SubViewController ()

@end

@implementation T029SubViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  NSLog(@"%@", @"能执行吗???");

  NSLog(@"self.navigationController class = %@", SN.getClassName(self.navigationController));

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  // mvvm 雏形...
  [[NSNotificationCenter defaultCenter] postNotificationName:@"change-background-color" object:nil userInfo:nil];
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
