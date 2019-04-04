//
//  T025ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T025ViewController.h"

@interface SNPerson : NSObject
@property (strong, nonatomic) NSDictionary *options;
@end

@implementation SNPerson
// - (void)drawRect:(CGRect)rect {
//  
// }
@end

//sn_note:=========  ============================ stone 🐳 ===========/
@interface T025ViewController ()

@property (nonatomic, strong) SNPerson *person1;
@property (nonatomic, strong) SNPerson *person2;
@property (nonatomic, strong) SNPerson *person3;
@property (nonatomic, strong) SNPerson *person4;

@property(nonatomic, weak) id <NSObject> obj;

@end

@implementation T025ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  self.person1 = [[SNPerson alloc] init];
  self.person2 = [[SNPerson alloc] init];
  self.person3 = [[SNPerson alloc] init];
  self.person4 = [[SNPerson alloc] init];

  self.person1.options = @{@"name": @"tom"};
  self.person2.options = @{@"name": @"cindy"};
  self.person3.options = @{@"name": @"stone"};
  self.person4.options = @{@"name": @"loy"};

  {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"notify-one" object:self.person1];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"notify-two" object:self.person2];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"notify-three" object:self.person3];
  }
  // 队列决定 在哪个线程处理任务...能接到从主线程发出来的通知, 放心使用
  // 释放的时候需要注意, 由于是系统管理, 把返回值作为属性, 带死亡的时候 再做销毁
  // 使用weak指针修饰
  // queue 如果传递nil, 在哪个线程创建就使用哪个线程, 不管通知是主队列 还是 子线程来的, 都在主队列处理任务
  self.obj = [[NSNotificationCenter defaultCenter] addObserverForName:@"notify-four" object:self.person4 queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
    NSLog(@"note = %@", note);
    NSLog(@"sender.userInfo = %@", note.userInfo);
    NSLog(@"%s | [NSThread currentThread] = %@", __func__, [NSThread currentThread]);
  }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(nullable UIEvent *)event {
  [[NSNotificationCenter defaultCenter] postNotificationName:@"notify-one" object:self.person1 userInfo:@{@"country": @"China"}];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"notify-two" object:self.person2 userInfo:@{@"country": @"Japan"}];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"notify-three" object:self.person3 userInfo:@{@"country": @"Korea"}];
  [[NSNotificationCenter defaultCenter] postNotificationName:@"notify-four" object:self.person4 userInfo:@{@"country": @"American"}];

  // @try {
  //   id o = [NSObject.new valueForKey:@"options"][@"abc"];
  //   NSLog(@"o = %@", o);
  // } @catch (NSException *exception) {
  //   NSLog(@"exception = %@", exception);
  // }

}

- (void)injected {

}

- (void)notificationHandler:(NSNotification *)sender {
  // NSLog(@"sender = %@", sender);
  if (self.person1 == sender.object) {
    NSLog(@"person1 sended");
    NSLog(@"sender.userInfo = %@", sender.userInfo);
  }

  if (self.person2 == sender.object) {
    NSLog(@"person2 sended");
    NSLog(@"sender.userInfo = %@", sender.userInfo);
  }
  if (self.person3 == sender.object) {
    NSLog(@"person3 sended");
    NSLog(@"sender.userInfo = %@", sender.userInfo);
  }
}

- (void)dealloc {
  NSLog(@"■■■■■■\t%@ is dead ☠☠☠\t■■■■■■", [self class]);
  @try {
    // delete all
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    // delete one
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"notify-one" object:self.person1];
  }
  @catch (NSException *exception) {
    NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
  }
}


@end
