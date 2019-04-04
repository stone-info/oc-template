//
//  NSAttributedStringSpec.m
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright 2019 stone. All rights reserved.
//

#import <Kiwi/Kiwi.h>


SPEC_BEGIN(NSAttributedStringSpec)

describe(@"NSAttributedString", ^{
  context(@"when assigned to 'Hello world'", ^{
    NSString *greeting = @"Hello world";
    it(@"should exist", ^{

      NSString* name = @"张三";

      NSMutableDictionary *paramters = [[NSMutableDictionary alloc] init];
      [paramters setObject:name forKey:@"userName"]; // 不会奔溃

      NSLog(@"paramters = %@", paramters);

    });

    it(@"should equal to 'Hello world'", ^{
      [[greeting should] equal:@"Hello world"];
    });
  });
});

SPEC_END
