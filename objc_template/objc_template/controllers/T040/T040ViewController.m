//
//  T040ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T040ViewController.h"

@interface T040ViewController ()

@end

@implementation T040ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  // NSString * strsssss = @"0123456789abcdef";
  // NSLog(@"strsssss = %@", strsssss);

  NSLog(@"hello world");

  NSMutableArray<SNView *> *arrM = [NSMutableArray array];
  for (NSInteger           i     = 0; i < 10; ++i) {
    SNView *view = [SNView makeView];
    kBorder(view);
    [self.view addSubview:view];

    kMasKey(view);
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
      if (i == 0) {
        make.top.mas_equalTo(self.view.mas_top).offset(0);
      } else {

        make.top.mas_equalTo(arrM.lastObject.mas_bottom).offset(10);
      }

      make.left.mas_equalTo(self.view.mas_left).offset(0);
      make.right.mas_equalTo(self.view.mas_right).offset(0);
      make.height.mas_equalTo(30);
    }];
    [arrM addObject:view];
  }
}


@end
    
    
    