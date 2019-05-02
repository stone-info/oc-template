//
//  T046ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T046ViewController.h"
#import "STListController.h"
@interface T046ViewController ()
@end

@implementation T046ViewController
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

  STListController *controller = STListController.new;

  [self.navigationController pushViewController:controller animated:YES];
}
@end
    