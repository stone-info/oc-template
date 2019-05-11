//
//  User.h
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject <IGListDiffable>
@property (strong, nonatomic) NSNumber *pk;
@property (copy, nonatomic) NSString   *name;
@property (copy, nonatomic) NSString   *handle;

- (instancetype)initWithPk:(NSNumber *)pk name:(NSString *)name handle:(NSString *)handle;
@end

NS_ASSUME_NONNULL_END
