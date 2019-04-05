//
//  T028ViewController.m
//  objc_template
//
//  Created by stone on 2019/3/30.
//  Copyright © 2019 stone. All rights reserved.
//

#import "T028ViewController.h"

@interface T028ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *mPickerView;

@property (strong, nonatomic) NSArray<NSArray<NSString *> *> *dataList;

@end

@implementation T028ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.

  self.view.backgroundColor        = [UIColor whiteColor];
  self.mPickerView.backgroundColor = HexRGBA(@"#FFC1C1", 1.0);

  self.mPickerView.dataSource = self;
  self.mPickerView.delegate   = self;

  NSString *filePath = [[NSBundle mainBundle] pathForResource:@"foods.plist" ofType:nil];

  NSArray *array = [NSArray arrayWithContentsOfFile:filePath];

  self.dataList = array;

  [self.mPickerView selectRow:0 inComponent:0 animated:YES];

  [self pickerView:self.mPickerView didSelectRow:0 inComponent:0];
}

NSInteger count = 0;

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  [self.mPickerView selectRow:count++ inComponent:0 animated:YES];
}

#pragma mark - <UIPickerViewDataSource>

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {

  return self.dataList.count;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {

  return self.dataList[component].count;
}

#pragma mark - <UIPickerViewDelegate>

// returns width of column and height of row for each component.
// - (CGFloat)pickerView:(UIPickerView *)pickerView
//     widthForComponent:(NSInteger)component {
//   return kScreenWidth;
// }
//
// - (CGFloat)pickerView:(UIPickerView *)pickerView
// rowHeightForComponent:(NSInteger)component {
//   return 50;
// }

// these methods return either a plain NSString, a NSAttributedString, or a view (e.g UILabel) to display the row for the component.
// for the view versions, we cache any hidden and thus unused views and pass them back for reuse.
// If you return back a different object, the old one will be released. the view will be centered in the row rect
// - (nullable NSString *)pickerView:(UIPickerView *)pickerView
//                       titleForRow:(NSInteger)row
//                      forComponent:(NSInteger)component {
//
//   // return [NSString stringWithFormat:@"%d",
//   //                                   row];
//
//   return @"hello world";
// }

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {

  NSString *                 str               = self.dataList[component][row];
  NSMutableAttributedString *aAttributedString = [[NSMutableAttributedString alloc] initWithString:str];

  // NSString * str = @"hello world";
  /** 文字的属性集合 */
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];

  /** 颜色 */
  dict[NSForegroundColorAttributeName] = [UIColor blackColor];
  /** 字体 */
  dict[NSFontAttributeName] = kPingFangSCRegular(14);
  /** 空心笔的粗度 越高空心就越填充*/
  dict[NSStrokeWidthAttributeName] = @3;
  /** 描边颜色 */
  dict[NSStrokeColorAttributeName] = [UIColor blackColor];

  /** 创建阴影对象 */
  // NSShadow *shadow = [[NSShadow alloc] init];
  /** 阴影颜色 */
  // shadow.shadowColor      = [UIColor blackColor];
  /** 阴影偏移量 */
  // shadow.shadowOffset     = CGSizeMake(6, 6);
  /** 阴影模糊度 */
  // shadow.shadowBlurRadius = 3;
  // dict[NSShadowAttributeName] = shadow;

  //    [str drawInRect:self.bounds withAttributes:dict];
  //
  [aAttributedString addAttributes:dict range:NSMakeRange(0, str.length)];

  return aAttributedString;
}

// - (UIView *)pickerView:(UIPickerView *)pickerView
//             viewForRow:(NSInteger)row
//           forComponent:(NSInteger)component
//            reusingView:(nullable UIView *)view {
//
// }

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

  NSInteger row0 = [pickerView selectedRowInComponent:0];
  NSInteger row1 = [pickerView selectedRowInComponent:1];
  NSInteger row2 = [pickerView selectedRowInComponent:2];

  // self.mLabel.text = [NSString stringWithFormat:@"%@-%@-%@", self.dataList[0][row0], self.dataList[1][row1], self.dataList[2][row2]];
}

@end
