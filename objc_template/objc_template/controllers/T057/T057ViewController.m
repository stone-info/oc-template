//
//  T057ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T057ViewController.h"

@interface T057ViewController ()
@property (weak, nonatomic) IBOutlet UISlider    *redSliderBar;
@property (weak, nonatomic) IBOutlet UISlider    *greenSliderBar;
@property (weak, nonatomic) IBOutlet UISlider    *blueSliderBar;
@property (weak, nonatomic) IBOutlet UITextField *redInput;
@property (weak, nonatomic) IBOutlet UITextField *greenInput;
@property (weak, nonatomic) IBOutlet UITextField *blueInput;
@property (weak, nonatomic) IBOutlet UIView      *showView;

@end

@implementation T057ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.



}

- (void)bindSlider:(UISlider *)slider textField:(UITextField *)textField {

  RACChannelTerminal *sliderChannelTerminal    = [slider rac_newValueChannelWithNilValue:nil];
  RACChannelTerminal *textFieldChannelTerminal = [textField rac_newTextChannel];

  [sliderChannelTerminal subscribe:textFieldChannelTerminal];
  [textFieldChannelTerminal subscribe:sliderChannelTerminal];


}


@end
    
