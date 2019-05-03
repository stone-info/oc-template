//
//  SelectionModel.h
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

typedef NS_ENUM(NSInteger, SelectionModelType) {
  SelectionModelTypeNone = 0,
  SelectionModelTypeFullWidth,
  SelectionModelTypeNib
};

NS_ASSUME_NONNULL_BEGIN

@interface SelectionModel : NSObject <IGListDiffable>

@property (strong, nonatomic) NSArray<NSString *> *options;
@property (assign, nonatomic) SelectionModelType type;

- (instancetype)initWithOptions:(NSArray<NSString *> *)options;
- (instancetype)initWithOptions:(NSArray<NSString *> *)options type:(SelectionModelType)type;
@end

NS_ASSUME_NONNULL_END
