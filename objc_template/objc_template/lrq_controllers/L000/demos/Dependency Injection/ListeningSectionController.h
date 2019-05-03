//
//  ListeningSectionController.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import <IGListKit/IGListSectionController.h>

@class IncrementAnnouncer;

NS_ASSUME_NONNULL_BEGIN

// @protocol ListeningSectionControllerDelegate;

@interface ListeningSectionController : IGListSectionController

// @property (nonatomic, weak, nullable) id <ListeningSectionControllerDelegate> delegate;

- (instancetype)initWithAnnouncer:(IncrementAnnouncer *)announcer;

@end

NS_ASSUME_NONNULL_END

// @protocol ListeningSectionControllerDelegate <NSObject>
// @required
// - (void)sectionControllerWantsRemoved:(ListeningSectionController *)sectionController;
// @optional
// - (void)sectionController:(ListeningSectionController *)sectionController xxx:(id)xxx;
// @end


