//
//  CommentCellOC.h
//  objc_template
//
//  Created by stone on 2019-05-05.
//  Copyright © 2019 stone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <IGListKit/IGListBindable.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommentCellOC : UICollectionViewCell<IGListBindable>
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@end

NS_ASSUME_NONNULL_END
