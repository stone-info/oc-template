//
// Created by stone on 2019-05-12.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SNPostModel : NSObject

@property(nonatomic, assign) NSInteger userId;
@property(nonatomic, assign) NSInteger ID;
@property(nonatomic, copy) NSString * title;
@property(nonatomic, copy) NSString * body;

@end