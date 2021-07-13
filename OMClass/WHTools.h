//
//  WHTools.h
//  LocationSay
//
//  Created by 何文虎 on 2019/7/27.
//  Copyright © 2019 何文虎. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHTools : NSObject

+ (double)scaleInView;


/**
 验证是否为手机号
 */
+ (BOOL)isPhoneNumber:(NSString *)number;

/** 密码有效性 */
+ (BOOL)isValidPassword:(NSString *)str;

/** 验证码有效性 */
+ (BOOL)isValidCheckCode:(NSString *)str;

/** 邮箱 */
+ (BOOL)isEmail:(NSString*)email;

/**
 *  身份证号验证(粗略验证)
 */
+ (BOOL)isValidateIdentityCard:(NSString *)identityCard;

/**
 字符串判空
 */
+ (BOOL)isEmpty:(NSString *)string;

/**
四舍五入
*/
+(float)roundFloat:(float)price;

+ (BOOL)isPositive:(NSString*)string;

/**
*  判断是否为正整数，
*/
+ (BOOL)isPureInt:(NSString *)string;

//判断字符串是否为浮点数
+ (BOOL)isPureFloat:(NSString*)string;

/**
 获取星座
 
 @param month 月份
 @param day 天
 @return 星座
 */
+ (NSString *)getConstellationWithMonth:(int )month day:(int)day;

/**
 汉字2个字符  字母一个字符
 */

+ (int)convertStringLengthToInt:(NSString *)strtemp;

+ (NSString *)substringOfLengthWithBytesLength:(int)bytes text:(NSString *)text;

+ (BOOL)isChinese:(NSString*)str;

/**
 *  字符串是否包含emoji
 */
+ (BOOL)isStringContainsEmoji:(NSString *)string;

+ (NSUInteger)utf8LengthWithText:(NSString *)string;



/**
 *  获取字符串中的数字
 */
+ (NSString *)getStringInsideNumberWithString:(NSString *)string;

/**
 *  移除多余的空白字符
 */
+ (NSString *)removeInvalidWhitespaceWithText:(NSString *)text;


/**
 判断字符串中 是否为纯数字
 */
+ (BOOL)isPureNumandCharacters:(NSString *)string;

+ (NSString *)getImageNameBaseCurrentTime;

/**
 json转字典
 
 @param jsonString json串
 @return 字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

/**
 字典转json串
 
 @param dict 字典
 @return json串
 */
+(NSString *)convertToJsonData:(NSDictionary *)dict;


/**
 时间戳转时间格式

 @param beTime 时间戳
 @return 时间格式字符串
 */
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime;

+ (BOOL) isBlankString:(NSString *)string;

+(BOOL)isBlankArr:(NSArray *)array;
+ (BOOL)isBlankDictionary:(NSDictionary *)dic;

+(void)removeSubViews:(UIView*)superView;
+ (UITableView *)findTableView:(UITableViewCell *)cell;
+ (UICollectionView *)findCollectionView:(UICollectionViewCell *)cell;

+ (UIViewController *)findVC:(UIView *)view;
+ (UIWindow*)getWindow;
+(void)makePhoneCall:(NSString*)mobile;
/**
 * 两个nsdate差距几天
 */
+ (NSInteger)getDifferenceByDate:(NSDate *)oldDate;

+ (NSInteger)timeSwitchTimestamp:(NSString *)formatTime;


/// 是否是模拟器
+(BOOL)isSimuLator;

/**
 设置特定文字的颜色

 @param color 搜索到的文字显示的颜色
 @param label 显示所有文字的控件
 @param font 搜索到的文字显示的大小
 @param text 搜索到的文字
 */
+(void)setColor:(UIColor *)color
          label:(UILabel *)label
           font:(UIFont *)font
           text:(NSString *)text;


/**
 *  从fromString中搜索是否包含searchString
 *
 *  @param searchString 要搜索的字串
 *  @param fromString   从哪个字符串搜索
 *
 *  @return 是否包含字串
 */
+ (BOOL)realtimeSearchString:(NSString *)searchString fromString:(NSString *)fromString;

@end

NS_ASSUME_NONNULL_END
