//
// Created by stone on 2019-05-12.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewModel : NSObject
@property (strong, nonatomic) RACSignal  *loginEnableSignal;
@property (copy, nonatomic) NSString     *username;
@property (copy, nonatomic) NSString     *password;
@property (strong, nonatomic) RACCommand *loginCommand;
@end