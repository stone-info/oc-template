//
// Created by stone on 2019-05-11.
// Copyright (c) 2019 stone. All rights reserved.
//

#import "RACTupleViewController.h"
#import "SNUserModel.h"

@interface RACTupleViewController ()
@property (strong, nonatomic) NSArray *users;
@end

@implementation RACTupleViewController {}

- (NSArray *)users {

  if (_users == nil) {
    NSString *filePath  = [[NSBundle mainBundle] pathForResource:@"users" ofType:@"json"];
    NSData   *data      = [NSData dataWithContentsOfFile:filePath];
    NSArray  *jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions | NSJSONWritingPrettyPrinted error:nil];
    _users = jsonArray;
  }
  return _users;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  [self entry];
}

- (void)injected {
  [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  // [self.views removeAllObjects];
  // self.views = nil;
  [self entry];
}

- (void)entry {
  NSLog(@"self.users = %@", self.users);

  NSArray *array = [[self.users.rac_sequence map:^SNUserModel *(NSDictionary *value) {
    SNUserModel *model = [SNUserModel mj_objectWithKeyValues:value];;
    return model;
  }] array];

  NSLog(@"array = %@", array);

}

- (void)entry3 {

  NSDictionary *dict = @{
    @"name": @"stone",
    @"age" : @29
  };

  [dict.rac_sequence.signal subscribeNext:^(RACTwoTuple *x) {
    // NSLog(@"x class = %@", SN.getClassName(x));
    // NSLog(@"x = %@", x);
    //
    // id key  = x[0];
    // id value = x[1];
    //
    // NSLog(@"key class = %@", SN.getClassName(key));
    // NSLog(@"key = %@", key);
    //
    // NSLog(@"value class = %@", SN.getClassName(value));
    // NSLog(@"value = %@", value);

    RACTupleUnpack(NSString *key, id value) = x;

    NSLog(@"key class = %@", SN.getClassName(key));
    NSLog(@"key = %@", key);

    NSLog(@"value class = %@", SN.getClassName(value));
    NSLog(@"value = %@", value);

  }];

}

- (void)entry2 {

  NSArray *array = @[@"江户川柯南", @"工藤新一", @123];
  // RACSequence *sequence = array.rac_sequence;
  // RACSignal *racSignal = sequence.signal;
  // [racSignal subscribeNext:^(id x) {
  //   NSLog(@"x class = %@", SN.getClassName(x));
  //   NSLog(@"x = %@", x);
  // }];

  [array.rac_sequence.signal subscribeNext:^(id x) {
    NSLog(@"x class = %@", SN.getClassName(x));
    NSLog(@"x = %@", x);
  }];
}

- (void)entry1 {

  UILabel *label = makeLabel(YES);
  [self.view addSubview:label];

  kMasKey(label);
  [label mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.offset(kStatusBarHeight + kNavigationBarHeight + 10);
    make.left.offset(10);
    make.right.offset(-10);
    make.height.mas_greaterThanOrEqualTo(50);
  }];

  RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[
    @"江户川柯南",
    @"工藤新一",
    @123

  ]];

  {
    id o = tuple[0];
    NSLog(@"o class = %@", SN.getClassName(o));
    NSLog(@"o = %@", o);
  }

  {
    id o = tuple[1];
    NSLog(@"o class = %@", SN.getClassName(o));
    NSLog(@"o = %@", o);
  }

  {
    id o = tuple[2];
    NSLog(@"o class = %@", SN.getClassName(o));
    NSLog(@"o = %@", o);
  }
}

@end
