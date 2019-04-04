//
//  T014ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/29.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T014ViewController.h"
#import <KVOController/KVOController.h>

@interface Info : NSObject
@property(copy, nonatomic) NSString* country;

- (NSString*)description;

@end

@implementation Info
- (NSString*)description {
  NSMutableString* description = [NSMutableString
      stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
  [description appendFormat:@"self.country=%@", self.country];
  [description appendString:@">"];
  return description;
}

@end

// sn_note:=========  ============================ stone 🐳 ===========/

@interface Person : NSObject
@property(copy, nonatomic) NSString* username;
@property(assign, nonatomic) CGFloat money;
@property(strong, nonatomic) Info* info;
@end

@implementation Person
// - (void)drawRect:(CGRect)rect {
//
// }

@end

// sn_note:=========  ============================ stone 🐳 ===========/

@interface T014ViewController ()
/** mLabel */
@property(weak, nonatomic) UILabel* mLabel;

@property(nonatomic, strong) Person* person;
@property(nonatomic, strong) Person* person1;
@property(nonatomic, strong) Person* person2;
@property(nonatomic, strong) Person* person3;

@end

@implementation T014ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  self.person = Person.new;
  Info* info = Info.new;
  info.country = @"China";
  self.person.info = info;
  // create KVO controller with observer
  FBKVOController* KVOController =
      [FBKVOController controllerWithObserver:self];
  self.KVOController = KVOController;

  // https://www.jianshu.com/p/3bdc82e0ed4e
  //
  // 可以很清楚的看到，其中包含了四种值，分别为：
  // NSKeyValueObservingOptionNew：提供更改前的值
  // NSKeyValueObservingOptionOld：提供更改后的值
  // NSKeyValueObservingOptionInitial：观察最初的值（在注册观察服务时会调用一次触发方法）
  // NSKeyValueObservingOptionPrior：分别在值修改前后触发方法（即一次修改有两次触发）
  //
  // observe clock date property
  [self.KVOController
      observe:self.person
      keyPath:@"username"
      options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew |
              NSKeyValueObservingOptionOld
        block:^(id observer, id object, NSDictionary* change) {
          NSLog(@"observer = %@", observer);
          NSLog(@"object = %@", object);
          NSLog(@"change = %@", change);

        }];
  // note:=== content === 2019-03-29 ====================================/

  {
    UILabel* label = [[UILabel alloc] init];
    /** GPU 优化 */
    label.opaque = YES;
    label.backgroundColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    //------------------------------
    label.numberOfLines = 0;
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"When you are old and grey and full of sleep, "
                 @"当你老了，头发花白，睡意沉沉";
    label.font = kPingFangSCRegular(14);

    [self.view addSubview:label];

    [label mas_makeConstraints:^(MASConstraintMaker* make) {
      make.center.equalTo(label.superview);
      // make.top.mas_equalTo(self.view.mas_top).offset(10);
      // make.left.mas_equalTo(self.view.mas_left).offset(10);
      // make.right.mas_equalTo(self.view.mas_right).offset(-10);
      // make.bottom.mas_equalTo(self.view.mas_bottom).offset(-10);

      make.width.mas_equalTo(150);
      make.height.mas_equalTo(150);
    }];

    self.mLabel = label;
    self.mLabel.text = self.person.username;
  }

  {
    self.person1 = Person.new;
    self.person2 = Person.new;
    self.person3 = Person.new;

    Info* info1 = Info.new;
    info1.country = @"China";
    self.person1.info = info1;

    Info* info2 = Info.new;
    info2.country = @"Japan";
    self.person2.info = info2;

    Info* info3 = Info.new;
    info3.country = @"Korea";
    self.person3.info = info3;

    NSArray* persons = @[
      self.person1,
      self.person2,
      self.person3,
    ];

    // 批量获取某一个属性...
    id infoList = [persons valueForKeyPath:@"info"];
    NSLog(@"infoList = %@", infoList);
  }
}

- (void)injected {
  self.mLabel.text = @"hello world 帅呆了111";

  NSLog(@"self.person.username = %@", self.person.username);

  [self.person setValue:sn.randomString forKey:@"username"];

  self.person.money = .2f;

  // 基本数据类型
  [self.person setValue:@(arc4random_uniform(1000) * 0.001)
             forKeyPath:@"money"];

  NSLog(@"arc4random_uniform() = %u", arc4random_uniform(10));
  // 字典能赋值吗?? 字典的值 能取, 不能赋值, 哦....对 应该是因为
  // 不可变字典导致的
  // NSLog(@"%@", [self.person valueForKeyPath:@"obj.country"]);

  [self.person setValue:@"japan" forKeyPath:@"info.country"];

  NSLog(@"%@", [self valueForKeyPath:@"view.subviews"]);

  NSLog(@"self.person.info = %@", self.person.info.country);

  // note:=== content === 2019-03-29 ====================================/
  // self.mLabel.text = self.person.username;
  self.mLabel.text = kStringFormat(@"%lf", self.person.money);

  NSLog(@"self.person.info = %@", self.person.info);

  NSDictionary* dictionary = [self.person
      dictionaryWithValuesForKeys:@[ @"username", @"money", @"info" ]];

  NSLog(@"dictionary = %@", dictionary);
}

- (void)touchesBegan:(NSSet<UITouch*>*)touches
           withEvent:(nullable UIEvent*)event {
  NSString* string = sn.randomString;
  self.person.username = string;
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
