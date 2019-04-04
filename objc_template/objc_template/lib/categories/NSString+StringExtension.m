//
//  NSString+SNNormalString.m
//  005_UITableView
//
//  Created by stone on 2018/7/27.
//  Copyright © 2018年 stone. All rights reserved.
//

#import "NSString+StringExtension.h"

@implementation NSString (StringExtension)
/*.m文件内容*/
/*****************************************************************************************/
- (CGFloat)stringHeightWithMaxWidth:(CGFloat)maxWidth font:(UIFont *)font {
  // 文字的最大尺寸
  CGSize  maxSize    = CGSizeMake(maxWidth, MAXFLOAT);
  // 计算文字的高度
  CGFloat textHeight = [self boundingRectWithSize:maxSize
                                          options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                       attributes:@{NSFontAttributeName: font}
                                          context:nil].size.height;
  return textHeight;
}
@end

@implementation NSString (SNAttributedString)

/**
 *  设置段落样式
 *
 *  @param lineSpacing 行高
 *  @param textcolor   字体颜色
 *  @param font        字体
 *
 *  @return 富文本
 */
- (NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing textColor:(UIColor *)textcolor textFont:(UIFont *)font {
  // 设置段落
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
  paragraphStyle.lineSpacing = lineSpacing;
  // NSKernAttributeName字体间距
  NSDictionary              *attributes = @{
    NSParagraphStyleAttributeName: paragraphStyle,
    NSKernAttributeName          : @1.5f
  };
  NSMutableAttributedString *attriStr   = [[NSMutableAttributedString alloc] initWithString:self attributes:attributes];
  // 创建文字属性
  NSDictionary              *attriBute  = @{
    NSForegroundColorAttributeName: textcolor,
    NSFontAttributeName           : font
  };
  [attriStr addAttributes:attriBute range:NSMakeRange(0, self.length)];
  return attriStr;
}

/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
- (CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont *)font withWidth:(CGFloat)width {
  NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
  //    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
  /** 行高 */
  paraStyle.lineSpacing = lineSpeace;
  // NSKernAttributeName字体间距 ,0表示已禁用Kerning。
  NSDictionary *dic = @{
    NSFontAttributeName          : font,
    NSParagraphStyleAttributeName: paraStyle,
    NSKernAttributeName          : @1.5f
  };
  CGSize       size = [self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
  return size.height;

}

@end


@implementation NSString (YCI)

+ (NSString *)JoinedWithSubStrings:(NSString *)firstStr,...NS_REQUIRES_NIL_TERMINATION{

  NSMutableArray *array = [NSMutableArray new];

  va_list args;

  if(firstStr){

    [array addObject:firstStr];

    va_start(args, firstStr);

    id obj;

    while ((obj = va_arg(args, NSString* ))) {
      [array addObject:obj];
    }

    va_end(args);
  }


  return [array componentsJoinedByString:@""];

}

@end