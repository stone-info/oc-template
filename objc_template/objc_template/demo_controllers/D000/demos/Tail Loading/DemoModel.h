//
//  DemoModel.h
//  IGListKitTest
//
//  Created by stone on 2019/5/2.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>
NS_ASSUME_NONNULL_BEGIN

@interface DemoModel : NSObject<IGListDiffable>
@property (nonatomic, copy) NSString *title;
@end

NS_ASSUME_NONNULL_END
