//
//  UIView+WHRadius.m
//  WKMaybell
//
//  Created by 何文虎 on 2018/12/5.
//  Copyright © 2018年 何文虎. All rights reserved.
//

#import "UIView+WHRadius.h"

static NSString *KCornerLayerName = @"KCornerShapeLayer";

typedef NS_OPTIONS(NSUInteger, KRoundCorner) {
    KRoundCornerTop = (UIRectCornerTopLeft | UIRectCornerTopRight),
    KRoundCornerBottom = (UIRectCornerBottomLeft | UIRectCornerBottomRight),
    KRoundCornerLeft = (UIRectCornerTopLeft | UIRectCornerBottomLeft),
    KRoundCornerRight = (UIRectCornerTopRight | UIRectCornerBottomRight),
    KRoundCornerAll = UIRectCornerAllCorners
};

@implementation UIView (WHRadius)




- (void)k_roundingCorner:(KRoundCorner)roundCorner radius:(CGFloat)radius{
    
    [self removeCorner];
    CGRect cornerBounds =  self.bounds;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.name = KCornerLayerName;
    UIRectCorner sysCorner = (UIRectCorner)roundCorner;
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:cornerBounds byRoundingCorners:sysCorner cornerRadii:CGSizeMake(radius, radius)];
    
    shapeLayer.path = cornerPath.CGPath;
    /*
     字面意思是“奇偶”。按该规则，要判断一个点是否在图形内，从该点作任意方向的一条射线，然后检测射线与图形路径的交点的数量。如果结果是奇数则认为点在内部，是偶数则认为点在外部
     */
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    
    if ([self isKindOfClass:[UILabel class]]) {
        //UILabel 机制不一样的  UILabel 设置 text 为 中文 也会造成图层混合 (iOS8 之后UILabel的layer层改成了 _UILabelLayer 具体可阅读 http://www.jianshu.com/p/db6602413fa3 )
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.layer setMask:shapeLayer];
        });
        return;
    }
    [self.layer setMask:shapeLayer];
    
}
- (void)k_roundingCorner:(KRoundCorner)roundCorner radius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    
    [self removeCorner];
    CGRect cornerBounds =  self.bounds;
    CGFloat width = CGRectGetWidth(cornerBounds);
    CGFloat height = CGRectGetHeight(cornerBounds);
    UIBezierPath * path= [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, width, height)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.name = KCornerLayerName;
    UIRectCorner sysCorner = (UIRectCorner)roundCorner;
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:cornerBounds byRoundingCorners:sysCorner cornerRadii:CGSizeMake(radius, radius)];
    [path  appendPath:cornerPath];
    //    [path setUsesEvenOddFillRule:YES];
    
    shapeLayer.path = path.CGPath;
    /*
     字面意思是“奇偶”。按该规则，要判断一个点是否在图形内，从该点作任意方向的一条射线，然后检测射线与图形路径的交点的数量。如果结果是奇数则认为点在内部，是偶数则认为点在外部
     */
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    CAShapeLayer *borderLayer=[CAShapeLayer layer];
    borderLayer.path = cornerPath.CGPath;
    self.layer.mask = borderLayer;
    
    //CGPathApply
    CGFloat cornerPathLength = lengthOfCGPath(roundCorner,radius,cornerBounds.size);
    CGFloat totolPathLength = 2*(CGRectGetHeight(cornerBounds)+CGRectGetWidth(cornerBounds))+cornerPathLength;
    shapeLayer.strokeStart = (totolPathLength-cornerPathLength)/totolPathLength;
    shapeLayer.strokeEnd = 1.0;
    shapeLayer.lineWidth = borderWidth;
    shapeLayer.strokeColor = borderColor.CGColor; //线的颜色
    
    
    if ([self isKindOfClass:[UILabel class]]) {
        //UILabel 机制不一样的  UILabel 设置 text 为 中文 也会造成图层混合 (iOS8 之后UILabel的layer层改成了 _UILabelLayer 具体可阅读 http://www.jianshu.com/p/db6602413fa3 )
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.layer addSublayer:shapeLayer];
        });
        return;
    }
    
    
    
    [self.layer addSublayer:shapeLayer];
    
}
float lengthOfCGPath (KRoundCorner roundingCorner,CGFloat radius,CGSize size) {
    CGFloat totolLength = 0.0;
    switch (roundingCorner) {
        case KRoundCornerTop:
        case KRoundCornerBottom:
            totolLength = 2*(size.width + size.height) - 4*radius + (M_PI * radius);
            break;
        case KRoundCornerAll:
            totolLength = 2*(size.width + size.height) - 8*radius + (M_PI * radius)*2;
        default:
            break;
    }
    return totolLength;
}



#pragma mark - 设置视图圆角
- (void)wh_setViewCornerRadius:(CGFloat)cornerRadius{
    [self k_roundingCorner:KRoundCornerAll radius:cornerRadius];
}

#pragma mark 设置视图上方为圆角
- (void)wh_topCornerWithRadius:(CGFloat)radius{
    [self k_roundingCorner:KRoundCornerTop radius:radius];
}

#pragma mark 设置视图左方为圆角
- (void)wh_leftCornerWithRadius:(CGFloat)radius{
    [self k_roundingCorner:KRoundCornerLeft radius:radius];
}

#pragma mark 设置视图右方为圆角
- (void)wh_rightCornerWithRadius:(CGFloat)radius{
    [self k_roundingCorner:KRoundCornerRight radius:radius];
}


#pragma mark  设置视图下方为圆角
- (void)wh_bottomCornerWithRadius:(CGFloat)radius{
    [self k_roundingCorner:KRoundCornerBottom radius:radius];
}

#pragma mark 设置视图圆角，并添加边缘线颜色，线条粗细
- (void)wh_cornerWithRadius:(CGFloat)radius borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    [self k_roundingCorner:KRoundCornerAll radius:radius borderColor:borderColor borderWidth:borderWidth];
}

#pragma mark 移除视图圆角
-(void)removeCorner {
    if ([self hasCornered]) {
        CALayer *layer = nil;
        for (CALayer *subLayer in self.layer.sublayers) {
            if ([subLayer.name isEqualToString:KCornerLayerName]) {
                layer = subLayer;
            }
        }
        [layer removeFromSuperlayer];
    }
}
#pragma mark 判断视图是否有圆角设置
- (BOOL)hasCornered {
    for (CALayer *subLayer in self.layer.sublayers) {
        if ([subLayer isKindOfClass:[CAShapeLayer class]] && [subLayer.name isEqualToString:KCornerLayerName]) {
            return YES;
        }
    }
    return NO;
}
#pragma mark - 设置视图为圆角
- (void)setViewCornerRadius:(CGFloat)cornerRadius{
    
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

- (void)om_setViewCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = YES;
}

#pragma mark - 设置视图的边框颜色和宽度
- (void)wh_setViewborderColor:(UIColor *)color andWidth:(CGFloat)width {
    
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}


/**
 *  通过 CAShapeLayer 方式绘制虚线
 *
 *  param lineView:       需要绘制成虚线的view
 *  param lineLength:     虚线的宽度
 *  param lineSpacing:    虚线的间距
 *  param lineColor:      虚线的颜色
 *  param lineDirection   虚线的方向  YES 为水平方向， NO 为垂直方向
 **/
+ (void)drawLineOfDashByCAShapeLayer:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor lineDirection:(BOOL)isHorizonal {

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];

    [shapeLayer setBounds:lineView.bounds];

    if (isHorizonal) {

        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];

    } else{
        [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame)/2)];
    }

    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    if (isHorizonal) {
        [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    } else {

        [shapeLayer setLineWidth:CGRectGetWidth(lineView.frame)];
    }
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);

    if (isHorizonal) {
        CGPathAddLineToPoint(path, NULL,CGRectGetWidth(lineView.frame), 0);
    } else {
        CGPathAddLineToPoint(path, NULL, 0, CGRectGetHeight(lineView.frame));
    }

    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}


@end
