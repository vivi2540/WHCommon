//
//  WHUtiities.h
//  WKMaybell
//
//  Created by 何文虎 on 2018/12/5.
//  Copyright © 2018年 何文虎. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHUtiities : NSObject
//获取版本号
+(NSString*)getCFBundleVersion;
//获取uuid
+ (NSString *)getUUID;

/*MD5加密*/
+(NSString*)md5StrWithString:(NSString*)str;

//获取本地资源包的文件夹个数
+(NSArray*)getNSFileArrayWithPath:(NSString*)path;
//date转字符串
+ (NSString*)getTimeStringWithDate:(NSDate*)date;

/// 获取N年前的时间
/// @param year n年前
+ (NSString *)getLastYear:(NSInteger)year;
//根据时间戳获取时分
+ (NSString*)getTimeStrWithTimeInterval:(NSString*)time;
//是否为同一天
+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;
//该日期是周几
+(NSString*)weekdayStringFromDate:(NSDate*)inputDate;
//该日期是不是周六日
+(BOOL)isweekendFromDate:(NSDate*)inputDate;
/*获取当前时间戳*/
+(NSString *)getNowTimeTimestamp;
//根据时间戳获取日期
+(NSString*)getTimeWithDate:(NSString*)date;
/*根据日期格式获取时间戳*/
+(NSDate*)getdateWithTimeStr:(NSString*)timeStr;
/*根据日期格式获取时间戳*/
+(NSDate*)getDateWithTimeStr2:(NSString*)timeStr2;
/*根据hhmm日期格式获取时间戳*/
+(NSDate*)getdateHHMMWithTimeStr:(NSString*)timeStr;
//获取当前时间戳.毫秒
+(NSString *)getNowTimeTimestamp3;
//获取下月
+ (NSString *)getNexMonth:(NSInteger)n;
//获取当年第一天时间
+(NSString*)getNowYearFirstTime;
//获取当前时间
+(NSString*)getNowTime;
//获取当前时间..
+(NSString*)getNowTimeP;
//当月第一天和最后一天
+ (NSArray *)getMonthFirstAndLastDay;
//获取当前月第一天时间
+(NSString*)getNowMonthFirstTime;
//获取当前时间HHMM
+(NSString*)getNowTimeHHmm;
//获取当前时间指定格式
+(NSString*)getNowTime:(NSString *)formatStr;

/*比较两个时间的大小 比oneDay大返回1,比one小返回-1*/
+ (BOOL)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
/**
 *  转换为Base64编码
 */
+(NSString *)base64EncodedStringWithStr:(NSString*)str;
/**
 *  将Base64编码还原
 */
+ (NSString *)base64DecodedStringWithStr:(NSString*)str;

/**
 *  获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
 */
+ (NSString *)firstCharactor:(NSString *)aString;

//修改颜色 loc从第几个开始  len需要修改的颜色
+(NSMutableAttributedString*)setLableAttributedStringWithstr:(NSString*)str loc:(NSInteger)loc len:(NSInteger)len color:(UIColor*)color;

+ (NSAttributedString *)insertString:(NSString *)insertStr
                      InsertStrColor:(UIColor *)insertStrColor
                    intoTargetString:(NSString *)targetStr
                      TargetStrColor:(UIColor *)targetStrColor
                          OnLocation:(NSInteger)location;

//字符串转字典
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
//字典转字符串
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
//视频转base64
+ (NSString *)video2DataPath:(NSString *)videoPath;
//图片转字符串
+ (NSString *)image2DataURL:(UIImage *)image;

//计算文字的宽高
+(CGSize)sizeWithString:(NSString* )string font:(UIFont* )font constraintSize:(CGSize)constraintSize;
//获取文本的高度
+ (float) heightForString:(NSString *)value andWidth:(float)width;


+(CGRect)getTextRectWith:(NSString *)str WithMaxWidth:(CGFloat)width  WithlineSpacing:(CGFloat)LineSpacing AddLabel:(UILabel *)label;
/**
 计算Label高度
 
 @param label 要计算的label，设置了值
 @param width label的最大宽度
 
 */
+(CGSize )autoHeightOfLabel:(UILabel *)label with:(CGFloat )width;

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

+(void)poAppVersonWithAppId:(NSString*)appId Block:(void (^)(id  x))block;

//获取当前屏幕显示的viewcontroller
+ (UIViewController*)currentViewController;
//最顶层viewcontroller
+ (UIViewController *)getCurrentTopViewController;

@end


NS_ASSUME_NONNULL_END
