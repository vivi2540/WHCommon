//
//  UIView+WHRadius.h
//  WKMaybell
//
//  Created by 何文虎 on 2018/12/5.
//  Copyright © 2018年 何文虎. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (WHRadius)
/**
 设置视图圆角
 
 @param cornerRadius 角度
 */
- (void)wh_setViewCornerRadius:(CGFloat)cornerRadius;

/**
 设置视图上方为圆角
 
 @param radius 角度
 */
- (void)wh_topCornerWithRadius:(CGFloat)radius;


/**
 设置视图左方为圆角
 
 @param radius 角度
 */
- (void)wh_leftCornerWithRadius:(CGFloat)radius;


/**
 设置视图右方为圆角
 
 @param radius 角度
 */
- (void)wh_rightCornerWithRadius:(CGFloat)radius;

/**
 设置视图下方为圆角
 
 @param radius 角度
 */
- (void)wh_bottomCornerWithRadius:(CGFloat)radius;

/**
 设置视图圆角，并添加边缘线颜色，线条粗细
 
 @param radius 角度
 @param borderColor 线色
 @param borderWidth 线宽
 */
- (void)wh_cornerWithRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;

/**
设置视图为圆角

@param cornerRadius 角度
*/
-(void)setViewCornerRadius:(CGFloat)cornerRadius;

/**
设置视图的边框颜色和宽度

@param color 边框颜色
@param width 宽度
*/
- (void)wh_setViewborderColor:(UIColor *)color andWidth:(CGFloat)width ;

- (void)om_setViewCornerRadius:(CGFloat)cornerRadius;


+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal;
@end

NS_ASSUME_NONNULL_END
