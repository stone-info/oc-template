//
//  T057ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T057ViewController.h"

@interface T057ViewController ()
// @property (weak, nonatomic) IBOutlet UISlider    *redSliderBar;
// @property (weak, nonatomic) IBOutlet UISlider    *greenSliderBar;
// @property (weak, nonatomic) IBOutlet UISlider    *blueSliderBar;
// @property (weak, nonatomic) IBOutlet UITextField *redInput;
// @property (weak, nonatomic) IBOutlet UITextField *greenInput;
// @property (weak, nonatomic) IBOutlet UITextField *blueInput;
// @property (weak, nonatomic) IBOutlet UIView      *showView;

@end

@implementation T057ViewController {
  __weak IBOutlet UISlider    *_redSliderBar;
  __weak IBOutlet UISlider    *_greenSliderBar;
  __weak IBOutlet UISlider    *_blueSliderBar;
  __weak IBOutlet UITextField *_redInput;
  __weak IBOutlet UITextField *_greenInput;
  __weak IBOutlet UITextField *_blueInput;
  __weak IBOutlet UIView      *_showView;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  _redInput.text = _greenInput.text = _blueInput.text = @"0.5";

  RACSignal *redSignal   = [self bindSlider:_redSliderBar textField:_redInput];
  RACSignal *greenSignal = [self bindSlider:_greenSliderBar textField:_greenInput];
  RACSignal *blueSignal  = [self bindSlider:_blueSliderBar textField:_blueInput];

  // 写法1:
  // 捆绑..., 好像和底下的 merge 一样嘛??  combine 需要 所有信号 都有新的值时 才触发
  // [[[RACSignal combineLatest:@[redSignal, greenSignal, blueSignal]] map:^id(RACTuple *value) {
  //   return [UIColor colorWithRed:[value[0] floatValue] green:[value[1] floatValue] blue:[value[2] floatValue] alpha:1.0];
  // }] subscribeNext:^(id x) {
  //   dispatch_async(dispatch_get_main_queue(), ^{
  //     _showView.backgroundColor = x;
  //   });
  // }];

  // 写法2:
  RACSignal *changeValuesSignal = [[RACSignal combineLatest:@[redSignal, greenSignal, blueSignal]] map:^id(RACTuple *value) {
    return [UIColor colorWithRed:[value[0] floatValue] green:[value[1] floatValue] blue:[value[2] floatValue] alpha:1.0];
  }];

  RAC(_showView, backgroundColor) = changeValuesSignal;

}

- (RACSignal *)bindSlider:(UISlider *)slider textField:(UITextField *)textField {

  RACSignal<NSString *> *textSignal = [[textField rac_textSignal] take:1];

  RACChannelTerminal *sliderChannelTerminal    = [slider rac_newValueChannelWithNilValue:nil];
  RACChannelTerminal *textFieldChannelTerminal = [textField rac_newTextChannel];

  [textFieldChannelTerminal subscribe:sliderChannelTerminal];
  [[sliderChannelTerminal map:^id(id value) {
    return kStringFormat(@"%.2f", [value floatValue]);
  }] subscribe:textFieldChannelTerminal];

  // 合并 , 带个小尾巴??
  return [[textFieldChannelTerminal merge:sliderChannelTerminal] merge:textSignal];
}


@end
    
