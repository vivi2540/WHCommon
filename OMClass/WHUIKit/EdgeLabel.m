//
//  EdgeLabel.m
//  OperationsManagement
//
//  Created by 杨东 on 2020/6/11.
//  Copyright © 2020 何文虎. All rights reserved.
//

#import "EdgeLabel.h"

@implementation EdgeLabel
- (instancetype)init{
    if (self = [super init]) {
        self.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);

    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);

    }
    return self;
}
- (void)awakeFromNib
{
   [super awakeFromNib];
    self.edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);

}
// 修改绘制文字的区域，edgeInsets增加bounds
-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines
{

    /*
    调用父类该方法
    注意传入的UIEdgeInsetsInsetRect(bounds, self.edgeInsets),bounds是真正的绘图区域
    */
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds,
     self.edgeInsets) limitedToNumberOfLines:numberOfLines];
    //根据edgeInsets，修改绘制文字的bounds
    rect.origin.x -= self.edgeInsets.left;
    rect.origin.y -= self.edgeInsets.top;
    rect.size.width += self.edgeInsets.left + self.edgeInsets.right;
    rect.size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return rect;
}
//绘制文字
- (void)drawTextInRect:(CGRect)rect
{
    //令绘制区域为原始区域，增加的内边距区域不绘制
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
