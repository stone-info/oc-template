//
//  T048ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T048ViewController.h"
#import "EHHorizontalSelectionView.h"
#import "UIImage+UIImageAdditions.h"
#import "T048CollectionView.h"

@interface T048ViewController () <EHHorizontalSelectionViewProtocol>
@property (nonatomic, weak) EHHorizontalSelectionView *hSelView2;
@property (weak, nonatomic) T048CollectionView        *collectionView;
@end

@implementation T048ViewController {
  NSArray *_arr2;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  self.view.backgroundColor = UIColor.whiteColor;
  EHHorizontalSelectionView *view = [[EHHorizontalSelectionView alloc] initWithFrame:CGRectMake(0, kStatusBarHeight + kNavigationBarHeight, kScreenWidth, 60)];
  self.hSelView2 = view;
  [view setValue:@(1) forKey:@"type"];

  view.textColor = HexRGBA(@"#1DA2F3", 1.0);
  view.tintColor = HexRGBA(@"#CADFF2", 1.0);
  // view.altTextColor = UIColor.clearColor;
  // view.cellGap      = 20;
  // view.needCentered = YES;

  [self.view addSubview:view];
  _arr2 = @[@"Living Room", @"Kitchen", @"Bedroom", @"Attic", @"Bathroom"];
  _hSelView2.delegate = self;

  [EHHorizontalLineViewCell updateColorHeight:2.f];

  T048CollectionView *collectionView = [T048CollectionView collectionView];
  self.collectionView = collectionView;

  collectionView.backgroundColor = UIColor.whiteColor;
  [self.view addSubview:collectionView];

  kMasKey(collectionView);
  [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.mas_equalTo(self.hSelView2.mas_bottom).offset(0);
    make.left.right.offset(0);
    make.bottom.offset(-kSafeAreaBottomHeight);
  }];

  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationHandler:) name:@"collection-view-send" object:nil];
}

- (void)notificationHandler:(NSNotification *)sender {
  NSNumber *number = sender.userInfo[@"index"];
  [self.hSelView2 selectIndex:(NSUInteger) number.integerValue animated:YES];
}

- (void)dealloc {
  @try {
    // delete all
    // [[NSNotificationCenter defaultCenter] removeObserver:self];

    // delete one
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"collection-view-send" object:nil];
  }
  @catch (NSException *exception) {
    NSLog(@"Exception occurred: %@, %@", exception, [exception userInfo]);
  }
}

#pragma mark - EHHorizontalSelectionViewProtocol

- (NSUInteger)numberOfItemsInHorizontalSelection:(EHHorizontalSelectionView *)hSelView {
  return [_arr2 count];
}

- (NSString *)titleForItemAtIndex:(NSUInteger)index forHorisontalSelection:(EHHorizontalSelectionView *)hSelView {
  return [_arr2[index] uppercaseString];
}

- (EHHorizontalViewCell *)selectionView:(EHHorizontalSelectionView *)selectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  return nil;
}

- (void)horizontalSelection:(EHHorizontalSelectionView *)selectionView willSelectObjectAtIndex:(NSUInteger)index {
  NSLog(@"%s", __func__);

  [[NSNotificationCenter defaultCenter] postNotificationName:@"category-view-send" object:nil userInfo:@{@"index": @(index)}];

}

- (void)horizontalSelection:(EHHorizontalSelectionView *)selectionView didSelectObjectAtIndex:(NSUInteger)index {
  NSLog(@"%s", __func__);
}

#pragma mark - UI

// - (void)viewWillAppear:(BOOL)animated {
//   self.view.backgroundColor                     = [UIColor colorWithPatternImage:[UIImage imageWithStartColor:HexRGBA(@"#1f1c27", 1.0) endColor:HexRGBA(@"#544a57", 1.0) size:CGSizeMake(1, self.view.bounds.size.height)]];
//   self.navigationController.navigationBarHidden = YES;
//   [super viewWillAppear:animated];
// }



@end
    
