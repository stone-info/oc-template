//
//  T076DataModel.h
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface T076DataModel : NSObject <IGListDiffable>

@property (copy, nonatomic) NSString    *name;

@property (assign, nonatomic) NSInteger age;

- (instancetype)initWithName:(NSString *)name age:(NSInteger)age identifier:(NSString *)identifier;

+ (instancetype)modelWithName:(NSString *)name age:(NSInteger)age identifier:(NSString *)identifier;


@end

NS_ASSUME_NONNULL_END



