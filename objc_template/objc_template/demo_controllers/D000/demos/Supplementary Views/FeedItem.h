//
//  FeedItem.h
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class User;

@interface FeedItem : NSObject

@property (strong, nonatomic) User              *user;
@property (copy, nonatomic) NSArray<NSString *> *comments;

- (instancetype)initWithPk:(NSNumber *)pk user:(User *)user comments:(NSArray<NSString *> *)comments;
@end

NS_ASSUME_NONNULL_END

