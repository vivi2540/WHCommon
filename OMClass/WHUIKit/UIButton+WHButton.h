//
//  UIButton+WHButton.h
//  WKMaybell
//
//  Created by 何文虎 on 2018/12/5.
//  Copyright © 2018年 何文虎. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIImage+WHImage.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WHButtonEdgeInsetsStyle) {
    WHButtonEdgeInsetsStyleTop, // image在上，label在下
    WHButtonEdgeInsetsStyleLeft, // image在左，label在右
    WHButtonEdgeInsetsStyleBottom, // image在下，label在上
    WHButtonEdgeInsetsStyleRight // image在右，label在左
};

@interface UIButton (WHButton)


/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(WHButtonEdgeInsetsStyle)style
                        imageTitleSpace:(CGFloat)space;



/**
 *  根据给定的颜色，设置按钮的颜色
 *  @param btnSize  这里要求手动设置下生成图片的大小，防止coder使用第三方layout,没有设置大小
 *  @param clrs     渐变颜色的数组
 *  @param percent  渐变颜色的占比数组
 *  @param type     渐变色的类型
 */
- (UIButton *)gradientButtonWithSize:(CGSize)btnSize colorArray:(NSArray *)clrs percentageArray:(NSArray *)percent gradientType:(GradientType)type;
@end

NS_ASSUME_NONNULL_END
