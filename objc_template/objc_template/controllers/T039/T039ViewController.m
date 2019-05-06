//
//  T039ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "T039ViewController.h"
#import "SNTextField.h"
#import "T039SecondViewController.h"
#import "SNTextField.h"

@interface T039ViewController ()

@property (nonatomic, strong) SNButton    *testButton;
@property (nonatomic, strong) SNLabel     *testLabel;
@property (nonatomic, strong) SNTextField *textField;
@end

@implementation T039ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  [self demo1];
  // [self demo2];
  // [self demo4];
  // [self demo5];
  // [self demo6];
  // [self demo7];
  // NSString *s = @"hello world";

}

- (void)demo7 {
  //遍历 NSArray
  // 这他妈 还是异步的??
  NSArray<NSString *> *numbers = @[@"1", @"2", @"3", @"4"];

  [numbers.rac_sequence.signal subscribeNext:^(id x) {
    NSLog(@"%@", x);
  }];

  //遍历 NSDictionary
  // 这他妈 还是异步的??
  NSDictionary<NSString *, id> *dict = @{
    @"name": @"小马",
    @"sex" : @"男",
    @"age" : @18
  };

  [dict.rac_sequence.signal subscribeNext:^(id x) {
    RACTupleUnpack(NSString *key, NSString *value) = x;
    NSLog(@"key=%@ value=%@", key, value);
  }];
}

- (void)demo6 {
  self.textField = [SNTextField makeTextField];
  [self.view addSubview:self.textField];

  kMasKey(self.textField);
  [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
    // make.edges.insets(UIEdgeInsetsZero);
    // make.center.mas_equalTo(self.view);
    make.center;

    /** full */
    // make.top.mas_equalTo(self.view.mas_top).offset(0);
    make.left.mas_equalTo(self.view.mas_left).offset(20);
    make.right.mas_equalTo(self.view.mas_right).offset(-20);
    // make.bottom.mas_equalTo(self.view.mas_bottom).offset(0);

    /** width & height */
    // make.width.mas_equalTo(100);
    make.height.mas_equalTo(30);
    // make.height.mas_equalTo(sn.suggestHeight(100, imageView.image));

    // make.size.mas_equalTo(100);
  }];

  //这里由UITextField作为示例
  [RACObserve(self.textField, text) subscribeNext:^(id x) {
    NSLog(@"%s", __func__);
  }];

  [[self.textField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x) {
    // NSLog(@"change");
    // NSLog(@"x = %@", x);
    NSLog(@"self.textField.text = %@", self.textField.text);
  }];
}

- (void)demo5 {
  self.testButton = [SNButton makeButton];
  [self.view addSubview:self.testButton];
  kMasKey(self.testButton);
  [self.testButton mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center;
    make.size.mas_equalTo(100);
  }];

  self.testLabel                        = [SNLabel makeLabel];
  self.testLabel.userInteractionEnabled = YES;
  [self.view addSubview:self.testLabel];

  kMasKey(self.testLabel);
  [self.testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerX;
    /** full */
    make.top.mas_equalTo(self.testButton.mas_bottom).offset(20);
    make.size.mas_equalTo(100);
  }];

  //这里只用UIButton的点击事件 和 UILabel的手势作为示例
  /**
       UIButton的点击事件
     */
  [[self.testButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

    //执行button的点击事件
    NSLog(@"x = %@", x);
    NSLog(@"%s", __func__);

  }];
  /**
    UILabel 手势
   */
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
  [[tap rac_gestureSignal] subscribeNext:^(id x) {

    //执行手势事件
    NSLog(@"x = %@", x);
    NSLog(@"%s", __func__);

  }];
  [self.testLabel addGestureRecognizer:tap];
}

- (void)demo4 {
  // 本次示例是由firstPageController 跳转到secondPageController

  /**
     *  注册通知并监听
     */
  [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"notification" object:nil] subscribeNext:^(NSNotification *notification) {
    //收到nsnotification 通知
    NSLog(@"%@ \n %@", notification.name, notification.object);

  }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  // [self demo3];

  /**
      发送通知
   */
  // NSMutableArray *dataArray = [@[@"1", @"2", @"3"] mutableCopy];
  // [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:dataArray];

}

- (void)demo3 {
  //firstPageController 点击页面跳转事件
  T039SecondViewController *second = [[T039SecondViewController alloc] init];

  // 设置代理信号
  second.delegateSignal = [RACSubject subject];

  // 订阅代理信号
  [second.delegateSignal subscribeNext:^(id x) {

    NSLog(@"x class = %@", SN.getClassName(x));

    NSLog(@"x = %@", x);

    NSLog(@"点击了通知按钮");

  }];


  // 跳转到 secondPageController
  [self.navigationController pushViewController:second animated:YES];
}

- (void)demo2 {
  /**
     * RACSubject使用步骤
      1.创建信号 跟RACSiganl不一样，创建信号时也没有触发.
      2.订阅信号
      3.发送信号
     */
  // subject 제목 | 主题，话题
  // 信号 想象成 收音机
  // 1.创建信号
  RACSubject *subject = [RACSubject subject];

  // 2.订阅信号
  // subscribe 구독하다 | 订阅
  [subject subscribeNext:^(id x) {
    // block调用时刻：当信号发出新值，就会调用.
    NSLog(@"接收信号信息%@", x);
  }];

  // 3.发送信号
  [subject sendNext:@"发送订阅信息"];
}

- (void)demo1 {
  /**
     * RACSignal使用步骤：
     1.创建信号,创建完成还不会触发.
     2.订阅信号,才会激活信号.
     3.发送信号 发送信息.
     */
  // Disposable 一次性的，可任意处理的 | 사용 후 버릴 수 있는 | 一次使用后即丢掉的, 一次性的
  // Subscriber 구독자 | 用户，订户 | 订阅人,订购者,订户 | 消费者;用户
  //1.创建信号.
  RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id <RACSubscriber> subscriber) {
    //2.发送信号.
    [subscriber sendNext:@"这是我的订阅信息"];//发送信号
    [subscriber sendCompleted];//发送信号完成,

    return [RACDisposable disposableWithBlock:^{

      // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
      NSLog(@"信号被销毁");

    }];
  }];
  //3.订阅信号.
  [siganl subscribeNext:^(id x) {

    NSLog(@"接收到信号信息:%@", x);
  }];
}


@end
    
    
    
