//
//  LabelsItem.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface LabelsItem : NSObject <IGListDiffable>

@property (strong, nonatomic) UIColor             *color;
@property (strong, nonatomic) NSArray<NSString *> *labels1;
@property (strong, nonatomic) NSArray<NSString *> *labels2;

- (instancetype)initWithColor:(UIColor *)color labels1:(NSArray<NSString *> *)labels1 labels2:(NSArray<NSString *> *)labels2;
@end

NS_ASSUME_NONNULL_END
