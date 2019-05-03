//
//  PersonOC.h
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PersonOC : NSObject

@property (copy, nonatomic) NSString *name;

- (instancetype)initWithPk:(NSNumber *)pk name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
