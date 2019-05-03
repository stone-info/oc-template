//
//  UserSectionController.h
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import <IGListKit/IGListSectionController.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserSectionController : IGListSectionController
- (instancetype)initWithReorderable:(BOOL)reorderable;
@end

NS_ASSUME_NONNULL_END


