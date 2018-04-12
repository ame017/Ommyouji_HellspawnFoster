//
//  NSString+AMEString.h
//  TagViewTest
//
//  Created by Vino－lgc on 16/9/19.
//  Copyright © 2016年 AME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (AMEString)
/**
 *  按照前缀和后缀提取字符串,多用于提取html中的图片
 *
 *  @param fromString 前字符串,注意转义字符
 *  @param toString   后字符串,注意转义字符
 *
 *  @return 返回一个数组
 */
- (NSArray *)componentsSeparatedFromString:(NSString *)fromString toString:(NSString *)toString;
/**
 *  转成UTF8
 *
 *  @return 返回一个string
 */
- (NSString *)stringToUTF8;
/**
 *  字符串直接运算(要求字符串是纯数字) 支持精确位数(-1精确到有数字的位数)
 *
 *  @param calculate 一步运算 加减乘除
 *  @param breviary 小数点精确位数 输入-1精确到有数字的位数
 *
 *  @return 返回新的数字字符串
 */
- (NSString *)stringCalculate:(NSString *)calculate breviary:(NSInteger)breviary;
@end
