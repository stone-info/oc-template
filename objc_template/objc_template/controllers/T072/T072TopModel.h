//
// Created by stone on 2019-05-12.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface T072TopModel : NSObject <IGListDiffable>

@property (nonatomic, copy) NSString            *title;
@property (assign, nonatomic) CGFloat           height;
@property (nullable, strong, nonatomic) NSArray *dataList;

- (instancetype)initWithTitle:(NSString *)title height:(CGFloat)height;

- (instancetype)initWithTitle:(NSString *)title height:(CGFloat)height dataList:(NSArray *)dataList;

@end


NS_ASSUME_NONNULL_END