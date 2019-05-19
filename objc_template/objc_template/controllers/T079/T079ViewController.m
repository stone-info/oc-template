//
//  T079ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T079ViewController.h"
#import "T079Consts.h"
#import "SNCardCollectionWrapperView.h"

@interface T079ViewController () <SNCardDelegate>


@end

@implementation T079ViewController {

  SNCardCollectionWrapperView *_cardSwitch;

  UIImageView *_imageView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.title                = @"SNCardCollectionWrapperView";
  self.view.backgroundColor = [UIColor whiteColor];

  // self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Previous" style:UIBarButtonItemStylePlain target:self action:@selector(switchPrevious)];

  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(switchNext)];

  [self addCardSwitch];
}

- (void)addCardSwitch {
  //初始化数据源
  NSString       *filePath = [[NSBundle mainBundle] pathForResource:@"DataPropertyList" ofType:@"plist"];
  NSArray        *arr      = [NSArray arrayWithContentsOfFile:filePath];
  NSMutableArray *items    = [NSMutableArray new];

  for (NSDictionary *dic in arr) {
    SNCardItemMoel *item = [[SNCardItemMoel alloc] init];
    [item setValuesForKeysWithDictionary:dic];
    [items addObject:item];
  }

  //设置卡片浏览器
  _cardSwitch = [[SNCardCollectionWrapperView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight + 10, self.view.bounds.size.width, 400)];
  _cardSwitch.items         = items;
  _cardSwitch.delegate      = self;
  //分页切换
  _cardSwitch.pagingEnabled = true;
  //设置初始位置，默认为0
  _cardSwitch.selectedIndex = 0;

  [self.view addSubview:_cardSwitch];
}

#pragma mark -
#pragma mark CardSwitchDelegate

- (void)SNCardDidSelectedAt:(NSInteger)index {
  NSLog(@"选中了：%zd", index);
}

- (void)switchPrevious {
  NSInteger index = _cardSwitch.selectedIndex - 1;
  index = index < 0 ? 0 : index;
  [_cardSwitch switchToIndex:index animated:true];
}

- (void)switchNext {
  NSInteger index = _cardSwitch.selectedIndex + 1;
  index = index > _cardSwitch.items.count - 1 ? _cardSwitch.items.count - 1 : index;
  [_cardSwitch switchToIndex:index animated:true];
}


@end
    
