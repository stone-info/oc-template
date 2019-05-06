//
// Created by Maskkkk on 2019-05-06.
// Copyright (c) 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListKit.h>

@interface ChapterViewModel: NSObject <IGListDiffable>
@property (nonatomic, strong) NSString *chapterName;
@property (nonatomic, assign) NSInteger chapterNo;
- (instancetype)initWithNo:(NSInteger)no name:(NSString *)name;

- (NSString *)description;
@end

@interface ChapterSectionController : IGListSectionController
@end