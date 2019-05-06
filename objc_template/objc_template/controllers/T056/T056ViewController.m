//
//  T056ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T056ViewController.h"

@interface T056ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton    *loginButton;

@end

@implementation T056ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.


  NSArray               *array         = @[self.usernameTextField.rac_textSignal, self.passwordTextField.rac_textSignal];
  RACSignal<RACTuple *> *enabledSignal = [[RACSignal combineLatest:array] map:^id(id value) {
    NSLog(@"obj = %@", value);
    NSLog(@"obj class = %@", SN.getClassName(value));
    return @([value[0] length] > 0 && [value[1] length] >= 6);
  }];

  [self.loginButton setRac_command:[[RACCommand alloc] initWithEnabled:enabledSignal signalBlock:^RACSignal *(id input) {
    // return nil;
    return [RACSignal empty];
  }]];
}

- (void)demo1 {
  [self.usernameTextField.rac_textSignal subscribeNext:^(NSString *x) {
    NSLog(@"x = %@", x);
  }];

  // 一个类 居然有泛型?? 怎么写??
  RACSignal<NSNumber *> *enabledSignal = [self.usernameTextField.rac_textSignal map:^id(NSString *value) {
    return @(value.length > 0);
  }];

  [self.loginButton setRac_command:[[RACCommand alloc] initWithEnabled:enabledSignal signalBlock:^RACSignal *(id input) {
    // return nil;
    return [RACSignal empty];
  }]];
}

@end
    
