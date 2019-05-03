//
//  StoryboardLabelSectionController.h
//  objc_template
//
//  Created by stone on 2019-05-03.
//  Copyright © 2019 stone. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import <IGListKit/IGListSectionController.h>

NS_ASSUME_NONNULL_BEGIN

@protocol StoryboardLabelSectionControllerDelegate;

@interface StoryboardLabelSectionController : IGListSectionController

@property (nonatomic, weak, nullable) id <StoryboardLabelSectionControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END

@protocol StoryboardLabelSectionControllerDelegate <NSObject>
@required
- (void)removeSectionControllerWantsRemoved:(StoryboardLabelSectionController *)sectionController;
@end


