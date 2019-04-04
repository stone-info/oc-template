//
//  T030ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T030ViewController.h"
#import <objc/runtime.h>

@interface Animal : NSObject <NSCoding>

@property (copy, nonatomic) NSString    *name;
@property (assign, nonatomic) NSInteger age;

- (NSString *)description;
@end

@implementation Animal

//- (void)encodeWithCoder:(NSCoder *)aCoder {
//  sn.encode(self, aCoder);
//}
//
//- (instancetype)initWithCoder:(NSCoder *)aDecoder {
//  self = [super init];
//  if (self != nil) { sn.decode(self, aDecoder); }
//  return self;
//}

kEncode

kDecode

- (NSString *)description {
  NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
  [description appendFormat:@"self.name=%@", self.name];
  [description appendFormat:@", self.age=%li", self.age];
  [description appendString:@">"];
  return description;
}

@end

//sn_note:=========  ============================ stone 🐳 ===========/
@interface T030ViewController ()

@end

@implementation T030ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  // [self demo1];
  [self demo2];

  [self demo3];

  NSLog(@"sn.ivarDescription(self) = %@", sn.ivarDescription(self));
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {

  //
  {
    Animal *animal = [[Animal alloc] init];
    animal.name = @"animal";
    animal.age  = 2;

    // [NSKeyedArchiver archiveRootObject:animal toFile:kCachePathWithFileName(@"animal.data")];
    BOOL i = sn.archive(animal, @"animal1.data");

    NSLog(@"i = %d", i);
  }

  //
  {
    setTimeout(self, ^(dispatch_source_t timer) {

      // Animal *animal = [NSKeyedUnarchiver unarchiveObjectWithFile:kCachePathWithFileName(@"animal.data")];
      // NSLog(@"animal = %@", animal);
      Animal *animal = sn.unarchive(@"animal1.data");
      NSLog(@"animal = %@", animal);

    }, 2000);
  }

}

- (void)demo1 {
  NSLog(@"kDocumentPath = %@", kDocumentPath);
  NSLog(@"kLibrary = %@", kLibrary);
  NSLog(@"kHome = %@", kHome);
  NSLog(@"kTemporary = %@", kTemporary);

  NSLog(@"kDocumentPathWithFileName(%@) = ", kDocumentPathWithFileName(@"abc.txt"));
  NSLog(@"kCachePathWithFileName(%@) = ", kCachePathWithFileName(@"abc.txt"));
  NSLog(@"kLibraryWithFileName(%@) = ", kLibraryWithFileName(@"abc.txt"));
  NSLog(@"kTemporaryWithFileName(%@) = ", kTemporaryWithFileName(@"abc.txt"));

  // NSArray *array = @[@"1", @"2"];
  // NSDictionary *array = @{@"username": @"stone"};
  // sn.writeFile(@"/Users/stone/Desktop/aa.txt", array);
  NSLog(@"array 最后一个参数测试 = %@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES));
  NSLog(@"array 最后一个参数测试 = %@", NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, NO));

  id o = sn.readFile(@"/Users/stone/Desktop/aa.txt");

  NSLog(@"o = %@", o);
}

- (void)demo2 {

  NSLog(@"%@", kStringFormat(@"open %@", sn.pathJoin(kLibrary, @"Preferences")));
  // NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  // [defaults setObject:@{@"username": @"stone"} forKey:@"user-info"];
  // [defaults synchronize]; // 遗弃的方法

  sn.writeToPreferences(@{@"username": @"stone"}, @"user-info1");

}

- (void)demo3 {

}

- (void)injected {
  NSLog(@"%s", __func__);
}


@end
    
    
    
