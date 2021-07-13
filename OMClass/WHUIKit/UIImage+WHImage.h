//
//  UIImage+WHImage.h
//  WKMaybell
//
//  Created by 何文虎 on 2018/12/5.
//  Copyright © 2018年 何文虎. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, GradientType) {
    GradientFromTopToBottom = 1,            //从上到下
    GradientFromLeftToRight,                //从做到右
    GradientFromLeftTopToRightBottom,       //从上到下
    GradientFromLeftBottomToRightTop        //从上到下
};


@interface UIImage (WHImage)
/**
 *  通过RGB颜色生成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  图片压缩，data为空时返回一张默认图片
 *
 *  @param data 图片的data
 *  @param size 压缩后图片尺寸
 *
 *  @return 返回一张新的图片
 */
+ (UIImage *)imageWithData:(NSData *)data scaledToSize:(CGSize)size;

/** 对图片大小进行压缩(100kb左右) */
+ (NSData *)imageJPEGRepresentationData:(UIImage *)myimage;

/**
 *  图片压缩
 *
 *  @param image   要压缩的图片
 *  @param newSize 压缩后图片尺寸
 *
 *  @return 返回一张新的图片
 */
+ (UIImage*)imageWithChangeImage:(UIImage*)image scaledToSize:(CGSize)newSize;


/**
 *  按固定宽度对图片压缩
 *
 *  @param sourceImage 图片资源
 *  @param defineWidth 设置固定宽度
 *
 */
+ (UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;


/**
 *  返回一张可以随意拉伸不变形的图片
 *
 *  @param name 图片名字
 */
+ (UIImage *)resizableImage:(NSString *)name;

/**
 高撕模糊效果
 @param image 原图
 @param blur 模糊度
 */
+ (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;

/**
 高撕模糊效果
 @param image 原图
 @param blur 模糊度
 */
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;

/**
 *  根据给定的颜色，生成渐变色的图片
 *  @param imageSize        要生成的图片的大小
 *  @param colorArr         渐变颜色的数组
 *  @param percents          渐变颜色的占比数组
 *  @param gradientType     渐变色的类型
 */
- (UIImage *)createImageWithSize:(CGSize)imageSize gradientColors:(NSArray *)colorArr percentage:(NSArray *)percents gradientType:(GradientType)gradientType;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
