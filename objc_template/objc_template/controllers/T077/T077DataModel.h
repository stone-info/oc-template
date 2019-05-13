//
//  T077DataModel.h
//  objc_template
//
//  Created by stone on 2019-05-13.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface T077DataModel : NSObject <IGListDiffable>

- (instancetype)initWithIdentifier:(NSString *)identifier;

+ (instancetype)modelWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END