//
//  T037ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T037ViewController.h"

@interface T037ViewController ()

@end

@implementation T037ViewController

- (void)foo1 {
  NSLog(@"call method \"%s\"", sel_getName(_cmd));
}

- (void)foo2 {
  NSLog(@"call method \"%s\"", sel_getName(_cmd));
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  // 根据C标准，用##操作后的结果必须是一个已经预定义过的符号，否则就是未定义的。
  // 预定义的符号：头文件名, 等式, 预处理数字, 字符常数, 字符串值, 标点符号, 单个非空字符
  // 在逗号和__VA_ARGS__之间的双井号，除了拼接前后文本之外，还有一个功能，那就是如果后方文本为空，那么它会将前面一个逗号吃掉。
  // 这个特性当且仅当上面说的条件成立时才会生效，因此可以说是特例。
#define kMethod(number) [self foo##number]

  kMethod(1);
  kMethod(2);



}

@end
    
    
    