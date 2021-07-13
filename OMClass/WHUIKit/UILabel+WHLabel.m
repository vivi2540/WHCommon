//
//  UILabel+WHLabel.m
//  WKMaybell
//
//  Created by 何文虎 on 2018/12/5.
//  Copyright © 2018年 何文虎. All rights reserved.
//

#import "UILabel+WHLabel.h"
#import <objc/runtime.h>
#import <CoreText/CoreText.h>
#import <Foundation/Foundation.h>


@interface NHAttributeModel : NSObject
@property (nonatomic, copy) NSString *str;
@property (nonatomic, assign) NSRange range;
@end

@implementation NHAttributeModel

@end


@implementation UILabel (AttributeTextTapAction)

- (NSMutableArray *)attributeStrings
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAttributeStrings:(NSMutableArray *)attributeStrings
{
    objc_setAssociatedObject(self, @selector(attributeStrings), attributeStrings, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)effectDic
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEffectDic:(NSMutableDictionary *)effectDic
{
    objc_setAssociatedObject(self, @selector(effectDic), effectDic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isTapAction
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsTapAction:(BOOL)isTapAction
{
    objc_setAssociatedObject(self, @selector(isTapAction), @(isTapAction), OBJC_ASSOCIATION_ASSIGN);
}

- (void (^)(NSString *, NSRange, NSInteger))tapBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTapBlock:(void (^)(NSString *, NSRange, NSInteger))tapBlock
{
    objc_setAssociatedObject(self, @selector(tapBlock), tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(NSString *,NSString *,NSInteger))clickBlock
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setClickBlock:(void (^)(NSString *,NSString *,NSInteger))clickBlock
{
    objc_setAssociatedObject(self, @selector(clickBlock), clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (id<NHAttributeTapActionDelegate>)delegate
{
    return objc_getAssociatedObject(self, _cmd);
}

- (BOOL)enabledTapEffect
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setEnabledTapEffect:(BOOL)enabledTapEffect
{
    objc_setAssociatedObject(self, @selector(enabledTapEffect), @(enabledTapEffect), OBJC_ASSOCIATION_ASSIGN);
    self.isTapEffect = enabledTapEffect;
}

- (BOOL)isTapEffect
{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setIsTapEffect:(BOOL)isTapEffect
{
    objc_setAssociatedObject(self, @selector(isTapEffect), @(isTapEffect), OBJC_ASSOCIATION_ASSIGN);
}

- (void)setDelegate:(id<NHAttributeTapActionDelegate>)delegate
{
    objc_setAssociatedObject(self, @selector(delegate), delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSMutableArray *)hideArray{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHideArray:(NSMutableArray *)hideArray
{
    objc_setAssociatedObject(self, @selector(hideArray), hideArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - mainFunction
- (void)wh_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick
{
    [self wh_getRangesWithStrings:strings];
    
    if (self.tapBlock != tapClick) {
        self.tapBlock = tapClick;
    }
}

- (void)addAttributeTapActionWithStrings:(NSArray<NSString *> *)strings
                          andHideStrings:(NSArray<NSString *> *)hideString
                              tapClicked:(void (^)(NSString *, NSString *, NSInteger))tapClick
{
    
    [self wh_getRangesWithStrings:strings];
    [self wh_getWithHideArray:hideString];
    if (self.clickBlock != tapClick) {
        self.clickBlock = tapClick;
    }
    
}

- (void)wh_addAttributeTapActionWithStrings:(NSArray <NSString *> *)strings
                                   delegate:(id <NHAttributeTapActionDelegate> )delegate
{
    [self wh_getRangesWithStrings:strings];
    
    if (self.delegate != delegate) {
        self.delegate = delegate;
    }
}

#pragma mark - touchAction
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (!self.isTapAction) {
        return;
    }
    
    if (objc_getAssociatedObject(self, @selector(enabledTapEffect))) {
        self.isTapEffect = self.enabledTapEffect;
    }
    
    UITouch *touch = [touches anyObject];
    
    CGPoint point = [touch locationInView:self];
    
    __weak typeof(self) weakSelf = self;
    
    [self wh_getTapFrameWithTouchPoint:point result:^(NSString *string, NSRange range, NSInteger index) {
        
        if (weakSelf.tapBlock) {
            weakSelf.tapBlock (string , range , index);
        }
        
        if (weakSelf.clickBlock) {
            if (weakSelf.hideArray == nil) {
                return ;
            }
            weakSelf.clickBlock (string , [weakSelf.hideArray objectAtIndex:index], index);
        }
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(wh_attributeTapReturnString:range:index:)]) {
            [weakSelf.delegate wh_attributeTapReturnString:string range:range index:index];
        }
        
        if (self.isTapEffect) {
            
            [self wh_saveEffectDicWithRange:range];
            
            [self wh_tapEffectWithStatus:YES];
        }
        
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (self.isTapAction) {
        if ([self wh_getTapFrameWithTouchPoint:point result:nil]) {
            return self;
        }
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark - getTapFrame
- (BOOL)wh_getTapFrameWithTouchPoint:(CGPoint)point result:(void (^) (NSString *string , NSRange range , NSInteger index))resultBlock
{
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributedText);
    
    CGMutablePathRef Path = CGPathCreateMutable();
    
    CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    
    CFRange range = CTFrameGetVisibleStringRange(frame);
    
    if (self.attributedText.length > range.length) {
        
        UIFont *font ;
        
        if ([self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:nil]) {
            
            font = [self.attributedText attribute:NSFontAttributeName atIndex:0 effectiveRange:nil];
            
        }else if (self.font){
            font = self.font;
            
        }else {
            font = [UIFont systemFontOfSize:17];
        }
        
        CGPathRelease(Path);
        
        Path = CGPathCreateMutable();
        
        CGPathAddRect(Path, NULL, CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height + font.lineHeight));
        
        frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), Path, NULL);
    }
    
    CFArrayRef lines = CTFrameGetLines(frame);
    
    if (!lines) {
        CFRelease(frame);
        CFRelease(framesetter);
        CGPathRelease(Path);
        return NO;
    }
     
    CFIndex count = CFArrayGetCount(lines);
    
    CGPoint origins[count];
    
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    
    CGAffineTransform transform = [self nh_transformForCoreText];
    
    CGFloat verticalOffset = 0;
    
    for (CFIndex i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        
        CGRect flippedRect = [self wh_getLineBounds:line point:linePoint];
        
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transform);
        
        rect = CGRectInset(rect, 0, 0);
        
        rect = CGRectOffset(rect, 0, verticalOffset);
        
        NSParagraphStyle *style = [self.attributedText attribute:NSParagraphStyleAttributeName atIndex:0 effectiveRange:nil];
        
        CGFloat lineSpace;
        
        if (style) {
            lineSpace = style.lineSpacing;
        }else {
            lineSpace = 0;
        }
        
        CGFloat lineOutSpace = (self.bounds.size.height - lineSpace * (count - 1) -rect.size.height * count) / 2;
        
        rect.origin.y = lineOutSpace + rect.size.height * i + lineSpace * i;
        
        if (CGRectContainsPoint(rect, point)) {
            
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            
            CFIndex index = CTLineGetStringIndexForPosition(line, relativePoint);
            
            CGFloat offset;
            
            CTLineGetOffsetForStringIndex(line, index, &offset);
            
            if (offset > relativePoint.x) {
                index = index - 1;
            }
            
            NSInteger link_count = self.attributeStrings.count;
            
            for (int j = 0; j < link_count; j++) {
                
                NHAttributeModel *model = self.attributeStrings[j];
                
                NSRange link_range = model.range;
                if (NSLocationInRange(index, link_range)) {
                    if (resultBlock) {
                        resultBlock (model.str , model.range , (NSInteger)j);
                    }
                    CFRelease(frame);
                    CFRelease(framesetter);
                    CGPathRelease(Path);
                    return YES;
                }
            }
        }
    }
    CFRelease(frame);
    CFRelease(framesetter);
    CGPathRelease(Path);
    return NO;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isTapEffect) {
        
        [self performSelectorOnMainThread:@selector(wh_tapEffectWithStatus:) withObject:nil waitUntilDone:NO];
        
    }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.isTapEffect) {
        
        [self performSelectorOnMainThread:@selector(wh_tapEffectWithStatus:) withObject:nil waitUntilDone:NO];
        
    }
}

- (CGAffineTransform)nh_transformForCoreText
{
    return CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f);
}

- (CGRect)wh_getLineBounds:(CTLineRef)line point:(CGPoint)point
{
    CGFloat ascent = 0.0f;
    CGFloat descent = 0.0f;
    CGFloat leading = 0.0f;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + fabs(descent) + leading;
    
    return CGRectMake(point.x, point.y , width, height);
}

#pragma mark - tapEffect
- (void)wh_tapEffectWithStatus:(BOOL)status
{
    if (self.isTapEffect) {
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
        
        NSMutableAttributedString *subAtt = [[NSMutableAttributedString alloc] initWithAttributedString:[[self.effectDic allValues] firstObject]];
        
        NSRange range = NSRangeFromString([[self.effectDic allKeys] firstObject]);
        
        if (status) {
            [subAtt addAttribute:NSBackgroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, subAtt.string.length)];
            
            [attStr replaceCharactersInRange:range withAttributedString:subAtt];
        }else {
            
            [attStr replaceCharactersInRange:range withAttributedString:subAtt];
        }
        self.attributedText = attStr;
    }
}

- (void)wh_saveEffectDicWithRange:(NSRange)range
{
    self.effectDic = [NSMutableDictionary dictionary];
    
    NSAttributedString *subAttribute = [self.attributedText attributedSubstringFromRange:range];
    
    [self.effectDic setObject:subAttribute forKey:NSStringFromRange(range)];
}

#pragma mark - getRange
- (void)wh_getRangesWithStrings:(NSArray <NSString *>  *)strings
{
    if (self.attributedText == nil) {
        self.isTapAction = NO;
        return;
    }
    
    self.isTapAction = YES;
    
    self.isTapEffect = YES;
    
    __block  NSString *totalStr = self.attributedText.string;
    
    self.attributeStrings = [NSMutableArray array];
    
    __weak typeof(self) weakSelf = self;
    
    [strings enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSRange range = [totalStr rangeOfString:obj];
        
        if (range.length != 0) {
            
            totalStr = [totalStr stringByReplacingCharactersInRange:range withString:[weakSelf wh_getStringWithRange:range]];
            
            NHAttributeModel *model = [NHAttributeModel new];
            model.range = range;
            model.str = obj;
            
            [weakSelf.attributeStrings addObject:model];
            
        }
        
    }];
}

- (void)wh_getWithHideArray:(NSArray <NSString *>  *)hideArr{
    if (self.attributedText == nil) {
        return;
    }
    self.hideArray = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    NSLog(@"hideArr   %@",hideArr);
    [hideArr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"hideArr   obj   %@",obj);
        [weakSelf.hideArray addObject:obj];
        NSLog(@"hideArray   %@",weakSelf.hideArray);
    }];
    
}

- (NSString *)wh_getStringWithRange:(NSRange)range
{
    NSMutableString *string = [NSMutableString string];
    
    for (int i = 0; i < range.length ; i++) {
        
        [string appendString:@" "];
    }
    return string;
}

@end


@implementation UILabel (WHLabel)

- (void)textAlignmentTop {
    self.numberOfLines = 0;
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    double finalWidth = self.frame.size.width;
    double finalHeight = self.frame.size.height;
    finalHeight = finalHeight == 0 ? fontSize.height : finalHeight;
    finalWidth = finalWidth == 0 ? self.preferredMaxLayoutWidth : finalWidth;
    CGSize maximumSize = CGSizeMake(finalWidth, CGFLOAT_MAX);
    CGRect stringSize = [self.text boundingRectWithSize:maximumSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil];
    int lines = (finalHeight - stringSize.size.height) / fontSize.height;
    for (int i = 0; i < lines; i++) {
        self.text = [self.text stringByAppendingString:@"\n"];
    }
}

- (void)textAlignmentBottom {
    self.numberOfLines = 0;
    CGSize fontSize = [self.text sizeWithAttributes:@{NSFontAttributeName:self.font}];
    double finalWidth = self.frame.size.width;
    CGSize maximumSize = CGSizeMake(finalWidth, CGFLOAT_MAX);
    CGRect stringSize = [self.text boundingRectWithSize:maximumSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil];
    int lines = (self.frame.size.height - stringSize.size.height) / fontSize.height;
    for (int i = 0; i < lines; i++) {
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
    }
}

- (void)setLableText:(NSString*)text lineSpacing:(CGFloat)lineSpacing{
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5.0; // 设置行间距
    paragraphStyle.alignment = NSTextAlignmentJustified; //设置两端对齐显示
    [attributedStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attributedStr.length)];
    self.attributedText = attributedStr;
}

+(UILabel *)supView:(UIView *)superView text:(NSString *)text color:(UIColor *)color font:(UIFont *)font{
    UILabel *label = [[UILabel alloc]init];
    label.text = text;
    label.textColor = color;
    label.font = font;
    [superView addSubview:label];
    return label;
}


@end
