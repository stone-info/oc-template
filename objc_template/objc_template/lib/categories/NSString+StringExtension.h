//
//  NSString+SNNormalString.h
//  005_UITableView
//
//  Created by stone on 2018/7/27.
//  Copyright © 2018年 stone. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (StringExtension)
/*
 * 计算字符串的高度
 */
- (CGFloat)stringHeightWithMaxWidth:(CGFloat)maxWidth font:(UIFont*)font;
@end

@interface NSString (SNAttributedString)
/**
 *  设置段落样式
 *
 *  @param lineSpacing 行高
 *  @param textcolor   字体颜色
 *  @param font        字体
 *
 *  @return 富文本
 */
- (NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing textColor:(UIColor *)textcolor textFont:(UIFont *)font;

/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
- (CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont *)font withWidth:(CGFloat)width;
@end


// 没有设置Frma，我们要根据他的自身的大小来设置
// UILabel *label=[[UILabel alloc]init];
// label.backgroundColor=[UIColor grayColor];
// label.numberOfLines=0;
// [self.view addSubview:label];
// NSString * conts = @"公元前3000年，印度河流域的居民的数字使用就已经比较普遍，居民们采用了十进位制的计算法。到吠陀时代（公元前1500～公元前500年），雅利安人已意识到数字在生产活动和日常生活中的作用，创造了一些简单的、不完全的数字。\n\n公元前3世纪，印度出现了整套的数字，但各地的写法不一，其中最典型的是婆罗门式，它的独到之处就是从1～9每个数都有专用符号，现代数字就是从它们中脱胎而来的。\n当时，“0”还没有出现。到了笈多时代（300～500年）才有了“0”，叫“舜若”（shunya），表示方式是一个黑点“●”，后来衍变成“0”。\n这样，一套完整的数字便产生了。这项劳动创作也对世界文化做出了巨大的贡献。lll";

//设置富文本显示，
// label.attributedText = [conts stringWithParagraphlineSpeace:6 textColor:[UIColor redColor] textFont:[UIFont systemFontOfSize:15]];

// 计算富文本的高度
// CGFloat contHeight = [conts getSpaceLabelHeightwithSpeace:6 withFont:[UIFont systemFontOfSize:15] withWidth:300];
// label.frame = CGRectMake(0, 50, 300, contHeight);

@interface NSString (YCI)

+ (NSString *)JoinedWithSubStrings:(NSString *)firstStr,...NS_REQUIRES_NIL_TERMINATION;

@end
