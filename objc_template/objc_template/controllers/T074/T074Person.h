//
// Created by stone on 2019-05-12.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IGListKit/IGListDiffable.h>

@interface T074Person : NSObject <IGListDiffable>

@property (copy, nonatomic) NSString *name;

- (instancetype)initWithPk:(NSNumber *)pk name:(NSString *)name;


@end