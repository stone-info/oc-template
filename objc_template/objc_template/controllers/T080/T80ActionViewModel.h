//
//  ActionViewModel.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface T80ActionViewModel : NSObject <IGListDiffable>
// @property (strong, nonatomic) NSNumber * likes;
@property (assign, nonatomic) NSInteger likes;

// - (instancetype)initWithLikes:(NSNumber *)likes;
- (instancetype)initWithLikes:(NSInteger)likes;


@end

NS_ASSUME_NONNULL_END
