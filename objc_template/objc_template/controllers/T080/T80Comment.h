//
// Created by stone on 2019-05-18.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface T80Comment : NSObject <IGListDiffable, NSCopying>
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *text;

- (instancetype)initWithUsername:(NSString *)username text:(NSString *)text;

@end

NS_ASSUME_NONNULL_END
