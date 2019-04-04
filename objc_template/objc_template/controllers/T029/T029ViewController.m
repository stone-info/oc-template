//
//  T029ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T029ViewController.h"

@interface T029ViewController ()
@property (nonatomic, strong) id <NSObject> obj;
@end

@implementation T029ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.


  // 队列决定 在哪个线程处理任务...能接到从主线程发出来的通知, 放心使用
  // 释放的时候需要注意, 由于是系统管理, 把返回值作为属性, 带死亡的时候 再做销毁
  // 使用weak指针修饰
  // queue 如果传递nil, 在哪个线程创建就使用哪个线程, 不管通知是主队列 还是 子线程来的, 都在主队列处理任务
  self.obj = [[NSNotificationCenter defaultCenter] addObserverForName:@"change-background-color" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
    self.view.backgroundColor = UIColor.orangeColor;
  }];
}

- (void)dealloc {
  NSLog(@"■■■■■■\t%@ is dead ☠☠☠\t■■■■■■", [self class]);

  @try {
    [[NSNotificationCenter defaultCenter] removeObserver:self.obj name:@"change-background-color" object:nil];
  }
  @catch (NSException *exception) {
    NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
  }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

  MBProgressHUD *hud = sn.showHUD(self.view, @"Loading...");
  setTimeout(self, ^(dispatch_source_t timer) {
    [self performSegueWithIdentifier:@"T029Segue" sender:nil];
    // [self.navigationController pushViewController:UIViewController.new animated:YES];
    sn.hideHUD(hud);
  }, 1000);




  // MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  //
  // setTimeout(self, ^(dispatch_source_t timer) {
  //   [self performSegueWithIdentifier:@"T029Segue" sender:nil];
  //   [hud hideAnimated:YES];
  // }, 1000);

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(nullable id)sender {
  NSLog(@"segue.destinationViewController = %@", segue.destinationViewController);
  NSLog(@"segue.sourceViewController = %@", segue.sourceViewController);

  // 用线关联到本地 segue对象的时候这么用, 和push一样...
  // [segue perform];
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
