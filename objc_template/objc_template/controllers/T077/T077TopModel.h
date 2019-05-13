//
//  T077TopModel.h
//  objc_template
//
//  Created by stone on 2019-05-13.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface T077TopModel : NSObject <IGListDiffable, NSCopying>

@property (strong, nonatomic) NSArray *dataList;

- (instancetype)initWithIdentifier:(NSString *)identifier dataList:(NSArray *)dataList;

+ (instancetype)modelWithIdentifier:(NSString *)identifier dataList:(NSArray *)dataList;

@end

NS_ASSUME_NONNULL_END
