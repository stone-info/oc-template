//
//  T071TopModel.h
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface T071TopModel : NSObject <IGListDiffable>
@property (nonatomic, copy) NSString            *title;
@property (assign, nonatomic) CGFloat           height;
@property (nullable, strong, nonatomic) NSArray *dataList;

- (instancetype)initWithTitle:(NSString *)title height:(CGFloat)height;

- (instancetype)initWithTitle:(NSString *)title height:(CGFloat)height dataList:(NSArray *)dataList;

@end

NS_ASSUME_NONNULL_END
