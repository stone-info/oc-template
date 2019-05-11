//
//  IncrementAnnouncer.h
//  objc_template
//
//  Created by stone on 2019/5/4.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@protocol IncrementListener;

@interface IncrementAnnouncer : NSObject
- (void)increment;
- (void)addListener:(id <IncrementListener>)listener;
@end

NS_ASSUME_NONNULL_END

@protocol IncrementListener <NSObject>
@required
- (void)didIncrement:(IncrementAnnouncer *)announcer value:(NSNumber *)value;
@end


