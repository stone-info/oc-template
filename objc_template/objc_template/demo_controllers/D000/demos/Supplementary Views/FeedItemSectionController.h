//
//  FeedItemSectionController.h
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import <IGListKit/IGListSectionController.h>

NS_ASSUME_NONNULL_BEGIN

// @protocol FeedItemSectionControllerDelegate;

@interface FeedItemSectionController : IGListSectionController

// @property (nonatomic, weak, nullable) id <FeedItemSectionControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

// @protocol FeedItemSectionControllerDelegate <NSObject>
// @required
// - (void)sectionControllerWantsRemoved:(FeedItemSectionController *)sectionController;
// @optional
// - (void)sectionController:(FeedItemSectionController *)sectionController xxx:(id)xxx;
// @end


