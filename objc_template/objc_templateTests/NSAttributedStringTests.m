//
//  NSAttributedStringTests.m
//  objc_templateTests
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SN.h"

@interface NSAttributedStringTests : XCTestCase

@end

@implementation NSAttributedStringTests

- (void)setUp {
  // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
  // This is an example of a functional test case.
  // Use XCTAssert and related functions to verify your tests produce the correct results.
  // NSString* name = @"张三";
  //
  // NSMutableDictionary *paramters = [[NSMutableDictionary alloc] init];
  // paramters[@"userName"] = name; // 不会奔溃

  // NSLog(@"paramters = %@", paramters);

  // NSString *string = SN.randomString;

  // NSLog(@"string = %@", string);

  NSMutableArray *arrM = [NSMutableArray array];

  [arrM addObject:UIView.new];

  NSLog(@"arrM = %@", arrM);

}

- (void)testPerformanceExample {
  // This is an example of a performance test case.
  [self measureBlock:^{
    // Put the code you want to measure the time of here.
  }];
}

@end
