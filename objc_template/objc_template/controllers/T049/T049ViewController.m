//
//  T049ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T049ViewController.h"

@interface T049ViewController ()

@end

@implementation T049ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

  NSArray *array = @[
    @"H",
    @"e",
    @"l",
    @"l",
    @"o",
    @",",
    @" ",
    @"w",
    @"o",
    @"r",
    @"l",
    @"d",
    @"!"
  ];

  // Map: Iterate an array and applies the same block operation to each element in it.
  NSLog(@"%@", [array map:^id(id obj, NSUInteger idx) { return [(NSString *) obj uppercaseString]; }]);

  // Filter: Iterate an array and return elements that meet a condition.
  NSLog(@"%@", [array filter:^BOOL(id obj, NSUInteger idx) { return [(NSString *) obj isEqualToString:@"o"]; }]);

  // Reduce: Combine all elements in an array to create a single output.
  NSLog(@"%@", [array reduce:@"Hey, " block:^id(id obj1, id obj2,NSUInteger idx) { return [NSString stringWithFormat:@"%@%@", obj1, obj2]; }]);

  // Contains: Iterate an array and chekc if any element satisfies a condition.
  NSLog(@"%@", [array contains:^BOOL(id obj) { return [(NSString *) obj isEqualToString:@"H"]; }] ? @"YES" : @"NO");

  // ForEach: A short-hand for the for loop.
  [array forEach:^(id obj, NSUInteger idx) { NSLog(@"%@", obj); }];

  array = @[
    @[@"H", @"e", @"l", @"l", @"o"],
    @[@",", @" "],
    @[@"w", @"o", @"r", @"l", @"d", @"!"]
  ];
  // FlatMap: Flatten an array of arrays.
  NSLog(@"%@", [array flatMap:^id(id obj) { return obj; }]);
}

- (void)injected {

  NSLog(@"%s", __func__);

}

@end
    