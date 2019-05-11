//
//  SearchSectionController.h
//  IGListKitTest
//
//  Created by stone on 2019/5/2.
//  Copyright © 2019 stone. All rights reserved.
//

#import <IGListKit/IGListSectionController.h>
// #import "IGListSectionController.h"
#import <IGListKit/IGListSectionController.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SearchSectionControllerDelegate;

@interface SearchSectionController : IGListSectionController
@property (nonatomic, weak, nullable) id <SearchSectionControllerDelegate> delegate;
@end

@protocol SearchSectionControllerDelegate <NSObject>

@required
@optional
- (void)sectionController:(SearchSectionController *)sectionController didChangeText:(NSString *)text;
@end

NS_ASSUME_NONNULL_END
