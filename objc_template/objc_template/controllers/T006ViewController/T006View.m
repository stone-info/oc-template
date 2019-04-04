//
//  T006View.m
//  objc_template
//
//  Created by stone on 2019/3/28.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T006View.h"

@interface T006View ()

@property(weak, nonatomic) IBOutlet UIButton* bigButton;
@property(weak, nonatomic) IBOutlet UIButton* smallButton;
@end

@implementation T006View

// 觉醒 一 一 |||
- (void)awakeFromNib {
  [super awakeFromNib];

  [self.bigButton addTarget:self
                     action:@selector(bigButtonClicked:)
           forControlEvents:UIControlEventTouchUpInside];
  [self.smallButton addTarget:self
                       action:@selector(smallButtonClicked:)
             forControlEvents:UIControlEventTouchUpInside];
}

- (void)bigButtonClicked:(UIButton*)sender {
  !self.bigButtonClickedBlock ?: self.bigButtonClickedBlock(sender);
}

- (void)smallButtonClicked:(UIButton*)sender {
  !self.smallButtonClickedBlock ?: self.smallButtonClickedBlock(sender);
}
@end
