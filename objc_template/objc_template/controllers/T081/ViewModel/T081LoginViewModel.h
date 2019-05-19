//
// Created by stone on 2019-05-19.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Account.h"

@interface T081LoginViewModel : NSObject
/** 账号 */
@property (nonatomic, strong) Account *account;

/** 允许登陆的信号 */
@property (nonatomic, strong) RACSignal *enableLoginSignal;

/** 登陆命令 */
@property (nonatomic, strong) RACCommand *loginCommand;

@end