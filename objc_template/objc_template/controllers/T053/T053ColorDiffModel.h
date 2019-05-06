//
//  T053ColorDiffModel.h
//  objc_template
//
//  Created by stone on 2019-05-05.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface T053ColorDiffModel : NSObject <IGListDiffable>
@property (strong, nonatomic) UIColor   *color;
@property (assign, nonatomic) NSInteger index;
@property (copy, nonatomic) NSString    *title;

- (instancetype)initWithColor:(UIColor *)color index:(NSInteger)index;

+ (instancetype)modelWithColor:(UIColor *)color index:(NSInteger)index;


@end

NS_ASSUME_NONNULL_END
