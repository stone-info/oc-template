//
// Created by stone on 2019-05-13.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface T078RACViewModel : NSObject
// 刷新页面的command，由控制器来调用执行。
@property (nonatomic, strong) RACCommand *reloadDataCommand;
// 取消的command，由控制器来调用执行。可以用来取消网络请求等。
@property (nonatomic, strong) RACCommand *cancelCommand;

@property (nonatomic, copy)   NSArray    *dataList;
@end