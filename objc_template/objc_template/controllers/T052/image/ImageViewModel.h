//
//  ImageViewModel.h
//  objc_template
//
//  Created by stone on 2019-05-04.
//  Copyright © 2019 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IGListKit/IGListDiffable.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageViewModel : NSObject <IGListDiffable>
@property (strong, nonatomic) NSURL *url;

- (instancetype)initWithUrl:(NSURL *)url;


@end

NS_ASSUME_NONNULL_END
