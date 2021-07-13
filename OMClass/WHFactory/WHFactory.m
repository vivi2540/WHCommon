//
//  WHFactory.m
//  HomeOfAcne
//
//  Created by 何文虎 on 2017/3/30.
//  Copyright © 2017年 hewenhu. All rights reserved.
//

#import "WHFactory.h"

@implementation WHFactory

+(UIImageView*)addLineWithFrame:(CGRect)frame color:(UIColor*)color{
    UIImageView *lineV = [[UIImageView alloc]init];
    lineV.frame =frame;
    lineV.backgroundColor = color;
    return lineV;
}

+(UIImageView*)addLineWithFrame:(CGRect)frame{
    UIImageView *lineV = [[UIImageView alloc]init];
    lineV.frame =frame;
    lineV.backgroundColor = LINEBACK_COLOR;
    return lineV;
    
}

+(UIImageView*)initImageViewWithFrame:(CGRect)frame image:(UIImage*)image{
    UIImageView *imageV = [[UIImageView alloc]init];
    imageV.frame =frame;
    imageV.image = image;
    return imageV;
}

+(UILabel*)initLabelWithtextColor:(UIColor*)textColor font:(UIFont*)font{
    UILabel *label = [[UILabel alloc]init];
    label.textColor = textColor;
    label.font = font;
    return label;
}

+(UILabel*)initLabelWithFrame:(CGRect)frame textColor:(UIColor*)textColor font:(CGFloat)font{
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:font];
    return label;
}

+(UIView*)addPointWithFrame:(CGRect)frame color:(UIColor*)color{
    UIView *view = [[UIView alloc]initWithFrame:frame];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = frame.size.width/2;
    return view;
}

+(UIButton*)initButtonWithFrame:(CGRect)frame text:(NSString*)text textcolor:(UIColor*)textcolor font:(UIFont*)font{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setTitle:text forState:UIControlStateNormal];
    [btn setTitleColor:textcolor forState:UIControlStateNormal];
    btn.titleLabel.font = font;
//    [btn addTarget:self action:aSelector forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end
