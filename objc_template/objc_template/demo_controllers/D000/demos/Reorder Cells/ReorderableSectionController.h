//
//  ReorderableSectionController.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import <IGListKit/IGListSectionController.h>

NS_ASSUME_NONNULL_BEGIN

// @protocol ReorderableSectionControllerDelegate;

@interface ReorderableSectionController : IGListSectionController

// @property (nonatomic, weak, nullable) id <ReorderableSectionControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

// @protocol ReorderableSectionControllerDelegate <NSObject>
// @required
// - (void)sectionControllerWantsRemoved:(ReorderableSectionController *)sectionController;
// @optional
// - (void)sectionController:(ReorderableSectionController *)sectionController xxx:(id)xxx;
// @end


