//
//  T081TopModel.h
//  objc_template
//
//  Created by stone on 2019-05-19.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface T081TopModel : NSObject <IGListDiffable>

@property (copy, nonatomic) NSString *identifier;

- (instancetype)initWithIdentifier:(NSString *)identifier;

+ (instancetype)modelWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
