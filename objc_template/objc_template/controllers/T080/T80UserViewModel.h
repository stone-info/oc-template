//
//  UserViewModel.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface T80UserViewModel : NSObject <IGListDiffable>
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *timestamp;

- (instancetype)initWithUsername:(NSString *)username timestamp:(NSString *)timestamp;


@end

NS_ASSUME_NONNULL_END
