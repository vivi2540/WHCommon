//
//  WHAttributedString.m
//  Therapist
//
//  Created by 何文虎 on 2017/9/23.
//  Copyright © 2017年 何文虎. All rights reserved.
//

#import "WHAttributedString.h"

@implementation WHAttributedString

+(void)setRichText:(UILabel *)lable titleString:(NSString *)titleString textFont:(UIFont *)textFont fontRang:(NSRange)fontRang textColor:(UIColor *)textColor colorRang:(NSRange)range{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSFontAttributeName value:textFont range:fontRang];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:range];
    
    [lable setAttributedText:Attributed];
    
}

+(void)setRichTwoText:(UILabel *)lable titleString:(NSString *)titleString textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang textFirstColor:(UIColor *)textFirstColor colorFirstRang:(NSRange)colorFirstRang textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang textSecondColor:(UIColor *)textSecondColor colorSecondRang:(NSRange)colorSecondRang{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSFontAttributeName value:textFirstFont range:fontFirstRang];
    
    [Attributed addAttribute:NSFontAttributeName value:textSecondFont range:fontSecondRang];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textFirstColor range:colorFirstRang];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textSecondColor range:colorSecondRang];
    
    [lable setAttributedText:Attributed];
}

+(void)setRichTextTwoTypsFontAndColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang textFirstFont:(UIFont *)textFirstFont fontFirstRang:(NSRange)fontFirstRang  textSecondFont:(UIFont *)textSecondFont fontSecondRang:(NSRange)fontSecondRang{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSFontAttributeName value:textFirstFont range:fontFirstRang];
    
    [Attributed addAttribute:NSFontAttributeName value:textSecondFont range:fontSecondRang];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:colorRang];
    
    [lable setAttributedText:Attributed];
}




+(void)setRichTextOnlyColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:colorRang];
    
    [lable setAttributedText:Attributed];
}

+(void)setRichTextThreeColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang textColor2:(UIColor *)textColor2 colorRang2:(NSRange)colorRang2 textColor3:(UIColor *)textColor3 colorRang3:(NSRange)colorRang3{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:colorRang];
     [Attributed addAttribute:NSForegroundColorAttributeName value:textColor2 range:colorRang2];
     [Attributed addAttribute:NSForegroundColorAttributeName value:textColor3 range:colorRang3];
    
    [lable setAttributedText:Attributed];
}

+(void)setRichTextOnlyFont:(UILabel *)lable titleString:(NSString *)titleString  textFont:(UIFont *)textFont fontRang:(NSRange)fontRang{
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textFont range:fontRang];
    
    [lable setAttributedText:Attributed];
}

+(void)setRichTextOnlyImage:(UILabel *)lable titleString:(NSString *)titleString  img:(NSString *)img fontIndex:(NSInteger)index iconSize:(CGSize)iconSize{
    
    if (titleString.length<=0) {
        return;
    }
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:img];
//    CGFloat paddingTop = lable.font.lineHeight - lable.font.pointSize;
    // 设置图片大小
//    attch.bounds = CGRectMake(4, -3, iconSize.width, iconSize.height);
    attch.bounds = CGRectMake(4, -2, iconSize.width-1.5, iconSize.height-1.5);
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    [Attributed insertAttributedString:string atIndex:index];
    
    [lable setAttributedText:Attributed];
    
}

+(void)setRichTextOnlyImage:(UILabel *)lable titleString:(NSString *)titleString  img:(NSString *)img fontIndex:(NSInteger)index{
    
    if (titleString.length<=0) {
        return;
    }
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:img];
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, 6.5, 8);
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    [Attributed insertAttributedString:string atIndex:index];
    
    [lable setAttributedText:Attributed];
    
}

+(void)setRichTextOnlyImage:(UILabel *)lable titleString:(NSString *)titleString  img:(NSString *)img fontIndex:(NSInteger)index sizi:(CGSize)sizi{
    
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:img];
    // 设置图片大小
    attch.bounds = CGRectMake(0, -3, sizi.width, sizi.height);
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    [Attributed insertAttributedString:string atIndex:index];
    
    [lable setAttributedText:Attributed];
    
}

+(void)setRichTextTwoImage:(UILabel *)lable titleString:(NSString *)titleString  img1:(NSString *)img1 fontIndex1:(NSInteger)index1 img2:(NSString *)img2{
    
   
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:img1];
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, 16,16);
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    // 添加表情
    NSTextAttachment *attch2 = [[NSTextAttachment alloc] init];
    // 表情图片
    attch2.image = [UIImage imageNamed:img2];
    // 设置图片大小
    attch2.bounds = CGRectMake(0, 0, 16, 16);
    // 创建带有图片的富文本
    NSAttributedString *string2 = [NSAttributedString attributedStringWithAttachment:attch2];
    
    [Attributed insertAttributedString:string atIndex:index1];
     [Attributed appendAttributedString:string2];
    
    [lable setAttributedText:Attributed];
    
}

+(void)setRichTextOnlyColor:(UILabel *)lable titleString:(NSString *)titleString  textColor:(UIColor *)textColor colorRang:(NSRange)colorRang img:(NSString *)img fontIndex:(NSInteger)index{
   
    
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:colorRang];
    

    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:img];
    attch.bounds = CGRectMake(0, -3, 13, 13);
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    [Attributed insertAttributedString:string atIndex:index];

    [lable setAttributedText:Attributed];
}

+(void)setRichTextTwoImage:(UILabel *)lable titleString:(NSString *)titleString  img1:(NSString *)img1 sizi1:(CGSize)sizi1 fontIndex1:(NSInteger)index1 img2:(NSString *)img2 sizi2:(CGSize)sizi2{
    
   
    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    // 添加表情
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    // 表情图片
    attch.image = [UIImage imageNamed:img1];
    // 设置图片大小
    attch.bounds = CGRectMake(0, 0, sizi1.width,sizi1.height);
    // 创建带有图片的富文本
    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
    
    // 添加表情
    NSTextAttachment *attch2 = [[NSTextAttachment alloc] init];
    // 表情图片
    attch2.image = [UIImage imageNamed:img2];
    // 设置图片大小
    attch2.bounds = CGRectMake(0, 0, sizi2.width, sizi2.height);
    // 创建带有图片的富文本
    NSAttributedString *string2 = [NSAttributedString attributedStringWithAttachment:attch2];
    
    [Attributed insertAttributedString:string atIndex:index1];
     [Attributed appendAttributedString:string2];
    
    [lable setAttributedText:Attributed];
    
}


+(void)setRichUnderLineText:(UILabel *)lable titleString:(NSString *)titleString textColor:(UIColor *)textColor colorRang:(NSRange)colorRang{

    NSMutableAttributedString *Attributed = [[NSMutableAttributedString alloc] initWithString:titleString];
    
    [Attributed addAttribute:NSForegroundColorAttributeName value:textColor range:colorRang];
    [Attributed addAttributes:@{
    NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
    NSStrikethroughColorAttributeName : OMRed_COLOR,
    NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(0, titleString.length)];
//    [Attributed addAttribute:NSStrikethroughStyleAttributeName
//    value:@(NSUnderlineStyleSingle)
//    range:NSMakeRange(0, titleString.length)];
    [Attributed addAttribute:NSUnderlineColorAttributeName value:OMRed_COLOR range:NSMakeRange(0, titleString.length)];
    [lable setAttributedText:Attributed];
    
}

+(void)setRichUnderLineText:(UILabel *)lable titleString:(NSString *)titleString{

    if (titleString.length<=0) {
        return;
    }
    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                           initWithString:titleString attributes:@{
                                                 NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                                                 NSStrikethroughColorAttributeName : OMRed_COLOR,
                                                 NSBaselineOffsetAttributeName:@(0)}];
   
    
    [lable setAttributedText:attributedString];
}

+(void)setRichUnderLineText:(UILabel *)lable titleString:(NSString *)titleString underLineColor:(UIColor*)underLineColor{


    NSAttributedString *attributedString = [[NSAttributedString alloc]
                                           initWithString:titleString attributes:@{
                                                 NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle),
                                                 NSStrikethroughColorAttributeName : underLineColor,
                                                 NSBaselineOffsetAttributeName:@(0)}];
   
    
    [lable setAttributedText:attributedString];
}
@end
