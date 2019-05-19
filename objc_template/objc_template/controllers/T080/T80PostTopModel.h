//
// Created by stone on 2019-05-18.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

@class T80Comment;

NS_ASSUME_NONNULL_BEGIN

@interface T80PostTopModel : NSObject <IGListDiffable>

@property (copy, nonatomic) NSString *username;

@property (copy, nonatomic) NSString *timestamp;

@property (strong, nonatomic) NSURL *imageURL;

// @property (strong, nonatomic) NSNumber * likes;
@property (assign, nonatomic) NSInteger  likes;

@property (strong, nonatomic) NSArray<T80Comment *> *comments;

- (instancetype)initWithUsername:(NSString *)username timestamp:(NSString *)timestamp imageURL:(NSURL *)imageURL likes:(NSInteger)likes comments:(NSArray<T80Comment *> *)comments;
@end

NS_ASSUME_NONNULL_END