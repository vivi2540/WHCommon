//
//  WHAttributedString.h
//  Therapist
//
//  Created by 何文虎 on 2017/9/23.
//  Copyright © 2017年 何文虎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface WHAttributedString : NSObject
/**
 适用于一个字符串中有两种颜色的 并且字体大小不一样的
 @param lable Lable
 @param titleString 内容
 @param textFont 设置需要的字体大小
 @param fontRang 字体大小的位置
 @param textColor 字体颜色
 @param range 字体颜色的位置
 */
+(void)setRichText:(UILabel *)lable titleString:(NSString *)titleString textFont:(UIFont *)textFont fontRang:(NSRange)fontRang textColor:(UIColor *)textColor colorRang:(NSRange)range;


/**
 适用于一个字符串中有两种颜色的但是不是在一个位置的中间有被叉开  并且字体大小不一样的
 比如 今天我花了¥100元 在路上捡了¥50元 数字变颜色 其实这样写比较麻烦  可以直接用第一种 自己去计算下第二个数字的下标就可以了
 @param lable Lable
 @param titleString 内容
 @param textFirstFont 设置需要的字体大小 第一个
 @param fontFirstRang 字体大小的位置
 @param textFirstColor 字体颜色
 @param colorFirstRang 字体颜色的位置
 @param textSecondFont 设置需要的字体大小 第二个
 @param fontSecondRang 字体大小的位置
 @param textSecondColor 字体颜色
 @param colorSecondRang 字体颜色的位置
 */
+(void)setRichTwoText:(UILabel *)lable titleString:(NSString *)titleString textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang textFirstColor:(UIColor *)textFirstColor colorFirstRang:(NSRange)colorFirstRang textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang textSecondColor:(UIColor *)textSecondColor colorSecondRang:(NSRange)colorSecondRang;


/**
 适用于两种字体大小 一种颜色 比如 原价¥100  ¥字体为12号 100位18号, 原价14号
 
 @param lable Lable
 @param titleString 内容
 @param textColor 字体颜色
 @param colorRang 字体颜色的位置
 @param textFirstFont 字体大小(¥的)
 @param fontFirstRang 字体大小的位置
 @param textSecondFont 字体大小(100的)
 @param fontSecondRang 字体大小的位置
 */
+(void)setRichTextTwoTypsFontAndColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang  textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang;


/**
 只设置颜色的不同
 
 @param lable Lable
 @param titleString 内容
 @param textColor 字体颜色
 @param colorRang 字体颜色的位置
 */
+(void)setRichTextOnlyColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang;
/**
 只设置字体的不同  这个方法不能用
 
 @param lable Lable
 @param titleString 内容
 @param textFont 字体大小
 @param fontRang 字体大小的位置
 */
+(void)setRichTextOnlyFont:(UILabel *)lable titleString:(NSString *)titleString  textFont:(UIFont *)textFont fontRang:(NSRange)fontRang;

/**
 设置一张那图片可定位置和大小的图片

@param lable Lable
@param titleString 内容
@param img 字体大小
@param index 位置
@param iconSize 图片大小
*/
+(void)setRichTextOnlyImage:(UILabel *)lable titleString:(NSString *)titleString  img:(NSString *)img fontIndex:(NSInteger)index iconSize:(CGSize)iconSize;



/**
 设置一张那图片

 @param lable Lable
 @param titleString 内容
 @param img 图
 @param index 图片位置
 */
+(void)setRichTextOnlyImage:(UILabel *)lable titleString:(NSString *)titleString  img:(NSString *)img fontIndex:(NSInteger)index;

/**
 设置两张图

 @param lable Lbable
 @param titleString 内容
 @param img1 图片
 @param index1 位置
 @param img2 图片2
 */
+(void)setRichTextTwoImage:(UILabel *)lable titleString:(NSString *)titleString  img1:(NSString *)img1 fontIndex1:(NSInteger)index1 img2:(NSString *)img2;


/**
 设置颜色并插入图片

 @param lable Lable
 @param titleString 内容
 @param textColor 文字颜色
 @param colorRang 字体颜色的位置
 @param img 图片
 @param index 图片位置
 */
+(void)setRichTextOnlyColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang img:(NSString *)img fontIndex:(NSInteger)index;


/// <#Description#>
/// @param lable <#lable description#>
/// @param titleString <#titleString description#>
/// @param img <#img description#>
/// @param index <#index description#>
/// @param sizi <#sizi description#>
+(void)setRichTextOnlyImage:(UILabel *)lable titleString:(NSString *)titleString  img:(NSString *)img fontIndex:(NSInteger)index sizi:(CGSize)sizi;



/// 设置颜色并插入两张图片
/// @param lable Lable
/// @param titleString 内容
/// @param img1 <#img1 description#>
/// @param sizi1 <#sizi1 description#>
/// @param index1 <#index1 description#>
/// @param img2 <#img2 description#>
/// @param sizi2 <#sizi2 description#>
+(void)setRichTextTwoImage:(UILabel *)lable titleString:(NSString *)titleString  img1:(NSString *)img1 sizi1:(CGSize)sizi1 fontIndex1:(NSInteger)index1 img2:(NSString *)img2 sizi2:(CGSize)sizi2;


/// 设置颜色和横线
/// @param lable lable
/// @param titleString 内容
/// @param textColor 文字颜色
/// @param colorRang 范围
+(void)setRichUnderLineText:(UILabel *)lable titleString:(NSString *)titleString textColor:(UIColor *)textColor colorRang:(NSRange)colorRang;


/// 设置横线
/// @param lable lable
/// @param titleString 内容
+(void)setRichUnderLineText:(UILabel *)lable titleString:(NSString *)titleString;


/// 设置横线
/// @param lable lable
/// @param titleString 内容
/// @param underLineColor 线的颜色
+(void)setRichUnderLineText:(UILabel *)lable titleString:(NSString *)titleString underLineColor:(UIColor*)underLineColor;


/// 字体大小一样,三种颜色
/// @param lable lable
/// @param titleString titleString
/// @param textColor textColor
/// @param colorRang colorRang
/// @param textColor2 textColor2
/// @param colorRang2 colorRang2
/// @param textColor3 textColor3
/// @param colorRang3 colorRang3
+(void)setRichTextThreeColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang textColor2:(UIColor *)textColor2 colorRang2:(NSRange)colorRang2 textColor3:(UIColor *)textColor3 colorRang3:(NSRange)colorRang3;
@end
