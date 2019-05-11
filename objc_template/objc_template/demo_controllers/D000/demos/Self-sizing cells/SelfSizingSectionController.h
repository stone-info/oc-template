//
//  SelfSizingSectionController.h
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import <IGListKit/IGListSectionController.h>

NS_ASSUME_NONNULL_BEGIN

// @protocol SelfSizingSectionControllerDelegate;

@interface SelfSizingSectionController : IGListSectionController

// @property (nonatomic, weak, nullable) id <SelfSizingSectionControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

// @protocol SelfSizingSectionControllerDelegate <NSObject>
// @required
// - (void)sectionControllerWantsRemoved:(SelfSizingSectionController *)sectionController;
// @optional
// - (void)sectionController:(SelfSizingSectionController *)sectionController xxx:(id)xxx;
// @end


