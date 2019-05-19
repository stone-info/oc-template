//
// Created by stone on 2019-05-19.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

/** 账号 */
@property (nonatomic, copy) NSString *username;

/** 密码 */
@property (nonatomic, copy) NSString *password;

@end