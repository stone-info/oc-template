//
//  Month.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface Month : NSObject <IGListDiffable>
@property (copy, nonatomic) NSString                                          *name;
@property (strong, nonatomic) NSNumber                                        *days;
@property (strong, nonatomic) NSDictionary<NSNumber *, NSArray<NSString *> *> *appointments;

- (instancetype)initWithName:(NSString *)name days:(NSNumber *)days appointments:(NSDictionary<NSNumber *, NSArray<NSString *> *> *)appointments;
@end

NS_ASSUME_NONNULL_END
