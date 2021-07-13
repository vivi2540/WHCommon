//
//  NSString+WHString.h
//  WKMaybell
//
//  Created by 何文虎 on 2018/12/5.
//  Copyright © 2018年 何文虎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (WHString)


NSString *decimalNumberWithDouble(double conversionValue);
/**
 *  转化字符串
 *
 */
NSString *convertToString(id object);

- (BOOL)isEmoji;

/**
 * md5加密
 */
- (NSString *)md5StrWithString:(NSString *)string;

- (NSString *)dencode:(NSString *)base64String;

/**
 * 计算文字高度，可以处理计算带行间距的等属性
 */
- (CGSize)boundingRectWithSize:(CGSize)size paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle font:(UIFont*)font;
/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;
/**
 * 计算最大行数文字高度，可以处理计算带行间距的
 */
- (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines;

/**
 *  计算是否超过一行
 */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing;

/** 是否为空或者为纯(null)、null string */
- (BOOL)isEmptyOrNull:(NSString *)string;

/** 判断是否含有表情 */
- (BOOL)stringContainsEmoji:(NSString *)string;

/** 精确的身份证号有效性检测 */
- (BOOL)accurateVerifyIDCardNumber:(NSString *)value;


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

- (NSMutableAttributedString *)modifyDigitalColor:(UIColor *)color normalColor:(UIColor *)normalColor;

+(void)setColor:(UIColor *)color
          label:(UILabel *)label
           font:(UIFont *)font
           text:(NSString *)text;

+(void)setBtnColor:(UIColor *)color norColor:(UIColor *)norColor label:(UIButton *)btn font:(UIFont *)font text:(NSString *)text lineSpacing:(CGFloat)lineSpac;

// 转换成时天分秒
+ (NSString *)timeFormatted:(int)totalSeconds;


/**
 根据字体的大小和限制的大小获取对应的字符串size
 
 @param font 字体大小
 @param constrainedSize 约束的范围
 @param lineBreakMode 截取字符串的方式
 @return CGSize
 */
- (CGSize)fl_sizeForFont:(nonnull UIFont *)font constrainedSize:(CGSize)constrainedSize mode:(NSLineBreakMode)lineBreakMode;

/**
 根据字体大小获取获取对应字符串的size
 
 @param font 字体大小
 @return CGSize
 */
- (CGSize)fl_sizeForFont:(nonnull UIFont *)font;

/**
 根据字体的大小获取宽度
 
 @param font 字体大小
 @return CGFloat
 */
- (CGFloat)fl_widthForFont:(nonnull UIFont *)font;

/**
 根据字体的大小和约束的宽度来获取高度
 
 @param font 字体大小
 @param width 宽度
 @return CGFloat
 */
- (CGFloat)fl_heightForFont:(nonnull UIFont *)font width:(CGFloat)width;



@end

NS_ASSUME_NONNULL_END
