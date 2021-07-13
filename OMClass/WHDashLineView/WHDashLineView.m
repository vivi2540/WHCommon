//
//  WHDashLineView.m
//  OperationsManagement
//
//  Created by 何文虎 on 2020/6/8.
//  Copyright © 2020 何文虎. All rights reserved.
//

#import "WHDashLineView.h"

@interface WHDashLineView ()
{
    CGFloat  _lineLength;
    CGFloat  _lineSpacing;
    UIColor  *_lineColor;
    CGFloat _height;
}
@end

@implementation WHDashLineView

//- (instancetype)initWithFrame:(CGRect)frame withLineLength:(NSInteger)lineLength withLineSpacing:(NSInteger)lineSpacing withLineColor:(UIColor *)lineColor{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
//        _lineLength = lineLength;
//        _lineSpacing = lineSpacing;
//        _lineColor = lineColor;
//        _height = frame.size.height;
//    }
//
//    return self;
//}

- (void)addDashLineWithFrame:(CGRect)frame withLineLength:(NSInteger)lineLength withLineSpacing:(NSInteger)lineSpacing withLineColor:(UIColor *)lineColor{
    _lineLength = lineLength;
    _lineSpacing = lineSpacing;
    _lineColor = lineColor;
    _height = frame.size.height;
    [self drawRect:frame];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context,1);
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    CGFloat lengths[] = {_lineLength,_lineSpacing};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0,_height);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

@end
