//
//  UILabel+WHLabel.h
//  WKMaybell
//
//  Created by 何文虎 on 2018/12/5.
//  Copyright © 2018年 何文虎. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol NHAttributeTapActionDelegate <NSObject>
@optional
/**
 *  NHAttributeTapActionDelegate
 *
 *  @param string  点击的字符串
 *  @param range   点击的字符串range
 *  @param index 点击的字符在数组中的index
 */
- (void)wh_attributeTapReturnString:(NSString *)string
                              range:(NSRange)range
                              index:(NSInteger)index;
@end


@interface UILabel (AttributeTextTapAction)

/**
 *  是否打开点击效果，默认是打开
 */
@property (nonatomic, assign) BOOL enabledTapEffect;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)wh_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                 tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;

/**
 *
 *
 */
- (void)addAttributeTapActionWithStrings:(NSArray<NSString *> *)strings
                          andHideStrings:(NSArray<NSString *>*)hideString
                              tapClicked:(void (^)(NSString *string, NSString *hideString, NSInteger index))tapClick;

/**
 *  给文本添加点击事件delegate回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param delegate delegate
 */
- (void)wh_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                   delegate:(id <NHAttributeTapActionDelegate> )delegate;

@end

@interface UILabel (WHLabel)
/** 文字顶部对齐 */
- (void)textAlignmentTop;

/** 文字底部对齐 */
- (void)textAlignmentBottom;

/**
*  赋值带行间距的
*
*  @param text  文本
*  @param lineSpacing 行间距
*/
- (void)setLableText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

+(UILabel *)supView:(UIView *)superView text:(NSString *)text color:(UIColor *)color font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
