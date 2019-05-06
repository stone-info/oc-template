//
//  CommentOC.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentOC : NSObject <IGListDiffable>
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *text;

- (instancetype)initWithUsername:(NSString *)username text:(NSString *)text;


@end

NS_ASSUME_NONNULL_END
