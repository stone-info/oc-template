//
//  T076TopModel.m
//  objc_template
//
//  Created by stone on 2019-05-12.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T076TopModel.h"

@interface T076TopModel ()

@property (copy, nonatomic) NSString *identifier;

@end

@implementation T076TopModel

- (id)copyWithZone:(nullable NSZone *)zone {

  T076TopModel *model = [[[self class] allocWithZone:zone] init];

  model.identifier = self.identifier;

  model.dataList = self.dataList;

  return model;
}

- (instancetype)initWithIdentifier:(NSString *)identifier dataList:(NSArray *)dataList {
  self = [super init];
  if (self) {
    self.identifier = identifier;
    self.dataList   = dataList;
  }

  return self;
}

+ (instancetype)modelWithIdentifier:(NSString *)identifier dataList:(NSArray *)dataList {
  return [[self alloc] initWithIdentifier:identifier dataList:dataList];
}

- (nonnull id <NSObject>)diffIdentifier {
  return self.identifier;
}

- (BOOL)isEqualToDiffableObject:(nullable id <IGListDiffable>)other {
  return YES;
}

@end
