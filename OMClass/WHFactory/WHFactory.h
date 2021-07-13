//
//  WHFactory.h
//  HomeOfAcne
//
//  Created by 何文虎 on 2017/3/30.
//  Copyright © 2017年 hewenhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHFactory : NSObject
+(UILabel*)initLabelWithtextColor:(UIColor*)textColor font:(UIFont*)font;
+(UIImageView*)addLineWithFrame:(CGRect)frame color:(UIColor*)color;
+(UIImageView*)addLineWithFrame:(CGRect)frame;
+(UIButton*)initButtonWithFrame:(CGRect)frame text:(NSString*)text textcolor:(UIColor*)textcolor font:(UIFont*)font;
+(UIImageView*)initImageViewWithFrame:(CGRect)frame image:(UIImage*)image;
+(UILabel*)initLabelWithFrame:(CGRect)frame textColor:(UIColor*)textColor font:(CGFloat)font;
//小圆点
+(UIView*)addPointWithFrame:(CGRect)frame color:(UIColor*)color;
//画虚线
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
@end
