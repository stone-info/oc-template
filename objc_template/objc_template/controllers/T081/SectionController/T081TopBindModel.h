//
//  T081TopBindModel.h
//  objc_template
//
//  Created by stone on 2019-05-19.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface T081TopBindModel : NSObject <IGListDiffable, NSCopying>

@property (strong, nonatomic) NSArray *dataList;

@property (copy, nonatomic) NSString *identifier;

- (instancetype)initWithIdentifier:(NSString *)identifier dataList:(NSArray *)dataList;

+ (instancetype)modelWithIdentifier:(NSString *)identifier dataList:(NSArray *)dataList;

@end

NS_ASSUME_NONNULL_END
