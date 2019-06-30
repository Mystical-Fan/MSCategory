//
//  NSString+expanded.h
//  com.westar.linfenOA
//
//  Created by apple on 2017/7/13.
//  Copyright © 2017年 westar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (expanded)
/*
 * 判断是否为邮箱地址
 */
- (BOOL)isEmailAddress;

/*
 * 判断是否含有汉字
 */
- (BOOL)includeChinese;

/*
 * 判断是否为身份证号码
 */
- (BOOL)isCardId;

/*
 * 判断是否为手机号码
 */
- (BOOL)isPhoneNum;

/*
 * 6-16位密码 不包含特殊符号
 */
- (BOOL)isPassWord;

/*
 * jsonString -> Array
 */

- (id)jsonStrToArray;

/*
 * 字符串size计算
 */
- (CGSize)stringSizeWithFont:(CGFloat)font width:(CGFloat)width;

/**
 *  计算富文本字体高度
 *
 *  @param lineSpeace 行高
 *  @param font       字体
 *  @param width      字体所占宽度
 *
 *  @return 富文本高度
 */
- (CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(CGFloat)font withWidth:(CGFloat)width;

/*
 * 转16进制字符串
 */
- (NSString *)hexString;



@end
