//
//  objc_templateTests.m
//  objc_templateTests
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SN.h"
//#import "SNRegex.h"

@interface objc_templateTests : XCTestCase

@end

@implementation objc_templateTests

- (void)setUp {
  // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
  // Put teardown code here. This method is called after the invocation of each test method in the class.


}

- (void)testExample {
  // This is an example of a functional test case.
  // Use XCTAssert and related functions to verify your tests produce the correct results.


  NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"plist"];
  NSArray  *dataList   = [NSArray arrayWithContentsOfFile:bundlePath];
  NSLog(@"class = %@", SN.getClassName(dataList[dataList.count - 1][@"xib"]));
  NSLog(@"dataList = %@", dataList[dataList.count - 1][@"xib"]);

  NSLog(@"bundlePath = %d", [dataList[dataList.count - 1][@"xib"] boolValue] == NO);

}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
