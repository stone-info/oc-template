//
//  T031ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T031ViewController.h"


#define oriOfftY -244
#define oriHeight 200

@interface T031ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightConstr;

@end

@implementation T031ViewController


static NSString *ID = @"cell";
- (void)viewDidLoad {
  [super viewDidLoad];
  
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
  
  
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
  
  //NSLog(@"%@",NSStringFromCGRect(self.tableView.frame));
  
  //1.凡是在导航条下面的scrollView.默认会设置偏移量.UIEdgeInsetsMake(64, 0, 0, 0)
  //self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
  
  //不要自动设置偏移量
  if (@available(iOS 11.0, *)) {
    // 取消自动调整内边距
    self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
  } else {
    // view.automaticallyAdjustsScrollViewInsets = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
  }
  
  //让导航条隐藏
  //self.navigationController.navigationBar.hidden = YES;
  
  //导航条或者是导航条上的控件设置透明度是没有效果.
  //self.navigationController.navigationBar.alpha = 0;
  
  //设置导航条背景(必须得要使用默认的模式UIBarMetricsDefault)
  //当背景图片设置为Nil,系统会自动生成一张半透明的图片,设置为导航条背景
  
  [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
  
  [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
  
  //当调用contentInset会自动调用scrollViewDidScroll
  self.tableView.contentInset = UIEdgeInsetsMake(244, 0, 0, 0);
  
  //设置标题
  UILabel *title = [[UILabel alloc] init];
  title.text = @"个人详情页";
  [title sizeToFit];
  title.textColor = [UIColor colorWithWhite:0 alpha:0];
  
  self.navigationItem.titleView = title;
}




-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

  //求偏移量
  //当前点 - 最原始的点
  NSLog(@"%f",scrollView.contentOffset.y);
  CGFloat offset = scrollView.contentOffset.y - oriOfftY;
  NSLog(@"offset======%f",offset);
  
  CGFloat h = oriHeight - offset;
  if (h < 64) {
    h = 64;
  }
  self.heightConstr.constant = h;
  
  
  //根据透明度来生成图片
  //找最大值/
  CGFloat alpha = offset * 1 / 136.0;
  if (alpha >= 1) {
    alpha = 0.99;
  }
  
  //拿到标题
  UILabel *titleL = (UILabel *)self.navigationItem.titleView;
  titleL.textColor = [UIColor colorWithWhite:0 alpha:alpha];
  
  //把颜色生成图片
  UIColor *alphaColor = [UIColor colorWithWhite:1 alpha:alpha];
  //把颜色生成图片
  // UIImage *alphaImage = [UIImage imageWithColor:alphaColor];
  UIImage *alphaImage = sn.imageWithColor(alphaColor);
  //修改导航条背景图片
  [self.navigationController.navigationBar setBackgroundImage:alphaImage forBarMetrics:UIBarMetricsDefault];
  
  
  
  
  
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
  return 40;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  //UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:ID];
  UITableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
  
  
  cell.textLabel.text = @"hello world";
  
  return cell;
}


@end

