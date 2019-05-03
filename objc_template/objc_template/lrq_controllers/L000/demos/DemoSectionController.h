//
//  DemoSectionController.h
//  objc_template
//
//  Created by stone on 2019/5/3.
//  Copyright © 2019 stone. All rights reserved.
//

#import <IGListKit/IGListKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoItem : NSObject <IGListDiffable>

@property (copy, nonatomic) NSString *name;
@property (strong, nonatomic) Class  controllerClass;
@property (copy, nonatomic) NSString *controllerIdentifier;

- (instancetype)initWithName:(NSString *)name controllerClass:(Class)controllerClass;
- (instancetype)initWithName:(NSString *)name controllerClass:(Class)controllerClass controllerIdentifier:(NSString *)controllerIdentifier;
@end


//sn_note:=========  ============================ stone 🐳 ===========/

@interface DemoSectionController : IGListSectionController

@end

NS_ASSUME_NONNULL_END
