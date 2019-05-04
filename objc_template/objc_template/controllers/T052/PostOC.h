//
//  PostOC.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

@class CommentOC;

NS_ASSUME_NONNULL_BEGIN

@interface PostOC : NSObject <IGListDiffable>

@property (copy, nonatomic) NSString *username;

@property (copy, nonatomic) NSString *timestamp;

@property (strong, nonatomic) NSURL *imageURL;

// @property (strong, nonatomic) NSNumber * likes;
@property (assign, nonatomic) NSInteger  likes;

@property (strong, nonatomic) NSArray<CommentOC *> *comments;

// - (instancetype)initWithUsername:(NSString *)username timestamp:(NSString *)timestamp imageURL:(NSURL *)imageURL likes:(NSNumber*)likes comments:(NSArray<CommentOC *> *)comments;
- (instancetype)initWithUsername:(NSString *)username timestamp:(NSString *)timestamp imageURL:(NSURL *)imageURL likes:(NSInteger)likes comments:(NSArray<CommentOC *> *)comments;
@end

NS_ASSUME_NONNULL_END
