//
//  PrefixedLabelSectionController.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <IGListKit/IGListKit.h>
#import <IGListKit/IGListSectionController.h>

NS_ASSUME_NONNULL_BEGIN

// @protocol PrefixedLabelSectionControllerDelegate;

@interface PrefixedLabelSectionController : IGListSectionController

// @property (nonatomic, weak, nullable) id <PrefixedLabelSectionControllerDelegate> delegate;

@property (copy, nonatomic) NSString   *prefix;
@property (strong, nonatomic) NSNumber *group;

- (instancetype)initWithPrefix:(NSString *)prefix group:(NSNumber *)group;

@end

NS_ASSUME_NONNULL_END

// @protocol PrefixedLabelSectionControllerDelegate <NSObject>
// @required
// - (void)sectionControllerWantsRemoved:(PrefixedLabelSectionController *)sectionController;
// @optional
// - (void)sectionController:(PrefixedLabelSectionController *)sectionController xxx:(id)xxx;
// @end


