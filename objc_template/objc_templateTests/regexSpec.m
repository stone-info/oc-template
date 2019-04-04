//
//  regexSpec.m
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright 2019 stone. All rights reserved.
//

#import <Kiwi/Kiwi.h>


SPEC_BEGIN(regexSpec)

describe(@"regex", ^{
  context(@"when assigned to 'Hello world'", ^{
    NSString *greeting = @"Hello world";
    it(@"should exist", ^{
      [[greeting shouldNot] beNil];
    });
    
    it(@"should equal to 'Hello world'", ^{
      [[greeting should] equal:@"Hello world"];
    });
  });
});

SPEC_END
