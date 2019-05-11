//
//  DayViewModel.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface DayViewModel : NSObject <IGListDiffable>
@property (strong, nonatomic) NSNumber *day;
@property (assign, nonatomic) BOOL     today;
@property (assign, nonatomic) BOOL     selected;
@property (strong, nonatomic) NSNumber *appointments;


- (instancetype)initWithDay:(NSNumber *)day today:(BOOL)today selected:(BOOL)selected appointments:(NSNumber *)appointments;
@end

NS_ASSUME_NONNULL_END
