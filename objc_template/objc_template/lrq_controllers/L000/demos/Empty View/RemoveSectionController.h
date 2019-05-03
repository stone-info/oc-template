//
//  RemoveSectionController.h
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import <IGListKit/IGListSectionController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RemoveSectionControllerDelegate;

@interface RemoveSectionController : IGListSectionController
@property (nonatomic, weak, nullable) id <RemoveSectionControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END


@protocol RemoveSectionControllerDelegate <NSObject>
@required
- (void)removeSectionControllerWantsRemoved:(RemoveSectionController *)sectionController;
@end

