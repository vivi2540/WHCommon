//
//  OMSearchBar.m
//  OperationsManagement
//
//  Created by yuanbo on 2020/12/26.
//  Copyright © 2020 何文虎. All rights reserved.
//

#import "OMSearchBar.h"


static CGFloat const searchIconW = 20.0;
// icon与placeholder间距
static CGFloat const iconSpacing = 10.0;

@implementation OMSearchBar


- (void)drawRect:(CGRect)rect {

    self.keyboardType = UIKeyboardTypeDefault;

    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;

    self.tintColor = [NSString colorWithHexString:@"9b9b9b"];

    [self setImage:[UIImage imageNamed:@"icon_search"]
        forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    self.backgroundImage = [self imageWithColor:[NSString colorWithHexString:@"#F5F6F8"] size:self.bounds.size];


    UITextField *searchField = [self valueForKey:@"searchField"];
    if (searchField) {

        searchField.delegate = self;

        searchField.backgroundColor = [NSString colorWithHexString:@"#F5F6F8"];

        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.alignment = NSTextAlignmentCenter;

        NSString *strsss = @"搜索";
        NSAttributedString *attri = [[NSAttributedString alloc] initWithString:strsss attributes:@{NSForegroundColorAttributeName:[NSString colorWithHexString:@"9b9b9b"],NSFontAttributeName:PFSC_RegularFont(15), NSParagraphStyleAttributeName:style}];

        searchField.attributedPlaceholder = attri;

        searchField.font = PFSC_RegularFont(15);

        //修正光标颜色
        [searchField setTintColor:[UIColor blackColor]];


       [self setPositionAdjustment:UIOffsetMake((searchField.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    }

}


- (CGFloat)placeholderWidth {
    
    if (!_placeholderWidth) {
        CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
        
        _placeholderWidth = size.width + iconSpacing + searchIconW;
    }
    
    return _placeholderWidth;

}


// 开始编辑的时候重置为靠左

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
       // 继续传递代理方法
    
       if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        
               [self.delegate searchBarShouldBeginEditing:self];
        
           }
    
                   [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];

    
       return YES;
    
}

// 结束编辑的时候设置为居中

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
       if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        
               [self.delegate searchBarShouldEndEditing:self];
        
           }
    
       [self setPositionAdjustment:UIOffsetMake((textField.frame.size.width-self.placeholderWidth)/2, 0) forSearchBarIcon:UISearchBarIconSearch];
    
        return YES;
}




- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}
@end
