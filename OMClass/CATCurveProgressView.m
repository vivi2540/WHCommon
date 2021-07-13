//
//  CATCurveProgressView.m
//  CATCurveProgressView
//
//  Created by catch on 16/5/25.
//  Copyright © 2016年 catch. All rights reserved.
//

#import "CATCurveProgressView.h"

//Degress to PI
#define CATDegreesToRadians(x) (M_PI*(x)/180.0)

//Defalut value
#define CATProgressLineWidth      (15)
#define CATProgressStartAngle     (-180)
#define CATProgressEndAngle       (0)
#define CATProgressCurveBgColor   [UIColor whiteColor]

@interface CATCurveProgressView()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;
@property (nonatomic, strong) CAShapeLayer *rightLayer;

@property (nonatomic, strong) CAGradientLayer *gradientLayer1;
@property (nonatomic, strong) CAGradientLayer *gradientLayer2;
@property (nonatomic, strong) CALayer *gradientLayer;
@property (nonatomic, assign) CGFloat lastProgress;

@property (nonatomic, assign)BOOL isGradientColor;
@end

@implementation CATCurveProgressView


#pragma mark --
#pragma mark -- Init &  dealloc

-(void)dealloc{
    self.curveBgColor = nil;
    self.progressColor = nil;
    self.trackLayer = nil;
    self.progressLayer = nil;
    self.rightLayer = nil;
    self.gradientLayer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInit];
    }
    return self;
}


-(void)_commonInit{
    //1.背景轨道
    _curveBgColor = CATProgressCurveBgColor;
    _trackLayer=[CAShapeLayer layer];
    _trackLayer.frame=self.bounds;
    _trackLayer.fillColor = [UIColor clearColor].CGColor;
    _trackLayer.strokeColor = _curveBgColor.CGColor;
//    _trackLayer.opacity = 0.25;//背景圆环的背景透明度
    _trackLayer.lineCap = kCALineCapRound;
    [self.layer addSublayer:_trackLayer];

    //2.进度轨道
    _progressLayer=[CAShapeLayer layer];
    _progressLayer.frame=self.bounds;
    _progressLayer.fillColor=[[UIColor clearColor] CGColor];
    _progressLayer.strokeColor=OMBlue_COLOR.CGColor;//!!!不能用clearColor
    _progressLayer.lineCap=kCALineCapRound;
    _progressLayer.strokeEnd=0.0;

    
    _startAngle = CATProgressStartAngle;
    _endAngle = CATProgressEndAngle;
    _progressLineWidth = CATProgressLineWidth;
    
    //3.是否开启渐变
    [self setEnableGradient:self.isGradientColor];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _trackLayer.frame=self.bounds;
    _progressLayer.frame=self.bounds;

    [self setProgressLineWidth:_progressLineWidth];
}

#pragma mark --
#pragma mark -- Public Methods

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    progress = progress < 0.0f ? 0.0f : progress;
    progress = progress > 1.0f ? 1.0f : progress;
    _lastProgress = _progress;
    _progress = progress;
    [CATransaction begin];
    
    if(_delegate && [_delegate respondsToSelector:@selector(progressView:progressChanged:lastProgress:)]){
        [_delegate progressView:self progressChanged:_progress lastProgress:_lastProgress];
    }
    
    if (!self.isGradientColor) {
        
        [CATransaction setCompletionBlock:^{
            
            CAShapeLayer *ressLayer=[CAShapeLayer layer];
            ressLayer.frame=self.bounds;
            ressLayer.fillColor=[[UIColor clearColor] CGColor];
            ressLayer.strokeColor=[UIColor whiteColor].CGColor;
            ressLayer.lineCap=kCALineCapButt;

            CGFloat yy = 180 - (progress / 0.0055);
            CGFloat radius = self.frame.size.width/2;
            UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height) radius:radius startAngle:CATDegreesToRadians(-yy) endAngle:CATDegreesToRadians(-yy+5) clockwise:YES];//-210到30的path
            ressLayer.path = path.CGPath;
            ressLayer.lineWidth=self.progressLineWidth;
            [self.layer addSublayer:ressLayer];

            self.trackLayer.strokeColor = [NSString colorWithHexString:@"#FFA928"].CGColor;
        }];
    }
    
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:1];
    progress = progress < 0.0 ? 0.0 : progress;
    progress = progress > 1.0 ? 1.0 : progress;
    _progressLayer.strokeEnd=progress;
    [CATransaction commit];
        
    
 
}

#pragma mark --
#pragma mark -- Setters && Getters

-(void)setCurveBgColor:(UIColor *)curveBgColor{
    _curveBgColor = curveBgColor;
    _trackLayer.strokeColor = _curveBgColor.CGColor;
    //set opacity
    CGFloat opacity = CGColorGetAlpha(_curveBgColor.CGColor);
    _trackLayer.opacity = opacity;
}

-(void)setEnableGradient:(CGFloat)enableGradient{
    _enableGradient = enableGradient;
    if (_enableGradient) {
        if (_progressLayer) {
            [_progressLayer removeFromSuperlayer];
        }
        if (![self.layer.sublayers containsObject:self.gradientLayer]) {
            [self.layer addSublayer:self.gradientLayer];
        }
    }else{
        if (_gradientLayer) {
            [_gradientLayer removeFromSuperlayer];
            _gradientLayer = nil;
        }
        if (![self.layer.sublayers containsObject:_progressLayer]) {
            [self.layer addSublayer:_progressLayer];
        }
    }
}

-(NSArray *)arrayFromColorArray:(NSArray *)colorArray{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:colorArray.count];
    for (UIColor* color in colorArray) {
        [array addObject:(id)color.CGColor];
    }
    return array;
}


-(void)setProgressColor:(UIColor *)progressColor{
    if (!progressColor) return;
    _progressColor = progressColor;
    _progressLayer.strokeColor= _progressColor.CGColor;
}

-(void)setProgressLineWidth:(CGFloat)progressLineWidth{
    if (progressLineWidth < 0.5f) return;
    _progressLineWidth = progressLineWidth;
    
    if (!self.isGradientColor) {
        
        CGFloat radius = self.frame.size.width/2;
        
        UIBezierPath *path=[UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height) radius:radius startAngle:CATDegreesToRadians(_startAngle) endAngle:CATDegreesToRadians(_endAngle) clockwise:YES];//-210到30的path
        _trackLayer.path=path.CGPath;
        _progressLayer.path = path.CGPath;
        
        _trackLayer.lineWidth = _progressLineWidth;
        _progressLayer.lineWidth=_progressLineWidth;
    }else {
        UIBezierPath *linePath = [UIBezierPath bezierPath];
        [linePath moveToPoint:CGPointMake(0, 0)];
        [linePath addLineToPoint:CGPointMake(self.frame.size.width, 0)];
        
        _trackLayer.path=linePath.CGPath;
        _progressLayer.path = linePath.CGPath;
        
        _trackLayer.lineWidth = _progressLineWidth;
        _progressLayer.lineWidth=_progressLineWidth;
    }
}

-(void)setStartAngle:(int)startAngle{
    _startAngle = startAngle;
    [self setProgressLineWidth:_progressLineWidth];
}

-(void)setEndAngle:(int)endAngle{
    _endAngle = endAngle;
    [self setProgressLineWidth:_progressLineWidth];
}

-(void)setProgress:(CGFloat)progress{
    [self setProgress:progress animated:YES];
}
//#FFA928
- (CALayer *)gradientLayer {
    if(_gradientLayer == nil) {
        _gradientLayer=[CALayer layer];

        _gradientLayer1=[CAGradientLayer layer];
        _gradientLayer1.frame=self.bounds;
        [_gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[UIColor yellowColor].CGColor,(id)[UIColor purpleColor].CGColor, nil]];
        [_gradientLayer1 setStartPoint:CGPointMake(0, 0.5)];//颜色比例（0－1之间）
        [_gradientLayer1 setEndPoint:CGPointMake(1, 0.5)];
        [_gradientLayer addSublayer:_gradientLayer1];
    

        [_gradientLayer setMask:_progressLayer];
    }
    return _gradientLayer;
}

@end



#pragma mark  - OMGradientProgressView
@interface OMGradientProgressView()

@property (nonatomic, strong) CAShapeLayer *trackLayer;
@property (nonatomic, strong) CAShapeLayer *progressLayer;

@property (nonatomic, assign) CGFloat lastProgress;

@end

@implementation OMGradientProgressView

#pragma mark --
#pragma mark -- Init &  dealloc

-(void)dealloc{
    self.curveBgColor = nil;
    self.progressColor = nil;
    self.trackLayer = nil;
    self.progressLayer = nil;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self _commonInit];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self _commonInit];
    }
    return self;
}


-(void)_commonInit{
    
    _curveBgColor = LINEBACK_COLOR;
    //1.背景轨道
    _trackLayer=[CAShapeLayer layer];
    _trackLayer.strokeColor = _curveBgColor.CGColor;
    //    _trackLayer.opacity = 0.25;//背景圆环的背景透明度
    [self.layer addSublayer:_trackLayer];

    //2.进度轨道
    _progressLayer=[CAShapeLayer layer];
    _progressLayer.fillColor = [UIColor whiteColor].CGColor;
    _progressLayer.strokeColor=[UIColor whiteColor].CGColor;//!!!不能用clearColor
    _progressLayer.lineCap=kCALineCapRound;
    _progressLayer.strokeEnd=0.0;

    _startAngle = CATProgressStartAngle;
    _endAngle = CATProgressEndAngle;
    _progressLineWidth = 8;

    CAGradientLayer *gradientLayer1=[CAGradientLayer layer];
    gradientLayer1.frame=self.bounds;
    [gradientLayer1 setColors:[NSArray arrayWithObjects:(id)[NSString colorWithHexString:@"#89D3FF"].CGColor,(id)[NSString colorWithHexString:@"#2E7FFF"].CGColor, nil]];
    [gradientLayer1 setStartPoint:CGPointMake(0, 0.5)];//颜色比例（0－1之间）
    [gradientLayer1 setEndPoint:CGPointMake(1, 0.5)];
    gradientLayer1.mask = _progressLayer;
    [self.layer addSublayer:gradientLayer1];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    _trackLayer.frame=self.bounds;
    _progressLayer.frame=self.bounds;
    
    [self setProgressLineWidth:_progressLineWidth];
}

#pragma mark --
#pragma mark -- Public Methods

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated{
    progress = progress < 0.0f ? 0.0f : progress;
    progress = progress > 1.0f ? 1.0f : progress;
    _lastProgress = _progress;
    _progress = progress;
    [CATransaction begin];
    
    if(_delegate && [_delegate respondsToSelector:@selector(progressView:progressChanged:lastProgress:)]){
        [_delegate gradientProgressView:self progressChanged:_progress lastProgress:_lastProgress];
    }
    
    [CATransaction setDisableActions:!animated];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [CATransaction setAnimationDuration:1];
    progress = progress < 0.0 ? 0.0 : progress;
    progress = progress > 1.0 ? 1.0 : progress;
    _progressLayer.strokeEnd=progress;
    [CATransaction commit];
    

}

#pragma mark --
#pragma mark -- Setters && Getters

-(void)setCurveBgColor:(UIColor *)curveBgColor{
    _curveBgColor = curveBgColor;
    _trackLayer.strokeColor = _curveBgColor.CGColor;
    CGFloat opacity = CGColorGetAlpha(_curveBgColor.CGColor);
    _trackLayer.opacity = opacity;
}

-(void)setProgressColor:(UIColor *)progressColor{
    if (!progressColor) return;
    _progressColor = progressColor;
    _progressLayer.strokeColor= _progressColor.CGColor;
}

-(void)setProgressLineWidth:(CGFloat)progressLineWidth{
    if (progressLineWidth < 0.5f) return;
    _progressLineWidth = progressLineWidth;
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(0, self.frame.size.height/2)];
    [linePath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height/2)];
    
    _trackLayer.path=linePath.CGPath;
    _progressLayer.path = linePath.CGPath;
    
    _trackLayer.lineWidth = _progressLineWidth;
    _progressLayer.lineWidth=_progressLineWidth;
    
}

-(void)setStartAngle:(int)startAngle{
    _startAngle = startAngle;
    [self setProgressLineWidth:_progressLineWidth];
}

-(void)setEndAngle:(int)endAngle{
    _endAngle = endAngle;
    [self setProgressLineWidth:_progressLineWidth];
}

-(void)setProgress:(CGFloat)progress{
    [self setProgress:progress animated:YES];
}




@end
