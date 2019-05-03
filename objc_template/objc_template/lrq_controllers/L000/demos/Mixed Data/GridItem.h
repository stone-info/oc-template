//
//  GridItem.h
//  objc_template
//
//  Created by stone on 2019/5/3.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GridItem : NSObject
@property (assign, nonatomic) NSInteger           itemCount;
@property (strong, nonatomic) NSArray<NSString *> *items;
@property (strong, nonatomic) UIColor             *color;
- (instancetype)initWithColor:(UIColor *)color itemCount:(NSInteger)itemCount;
@end

NS_ASSUME_NONNULL_END

