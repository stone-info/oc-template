//
//  T070ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T070ViewController.h"

@interface T070ViewController ()
@property (nonatomic, copy) void (^reloadData)(void);

// @property (copy, nonatomic) NSString *name;
@end

@implementation T070ViewController {
  NSString *_name;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  _name = @"stone";


  // 狗屁 下划线 和 self.name 都会引起循环引用... 什么烂结论
  // !self.reloadData ?: self.reloadData();

  [self setReloadData:^{
    NSLog(@"self.name = %@", _name);
  }];
}

- (void)dealloc {
  NSLog(@"■■■■■■\t%@ is dead ☠☠☠\t■■■■■■", [self class]);
}

@end
    