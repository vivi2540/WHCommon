//
//  YXYSearchBar.m
//  HsusueSearchBarDemo
//
//  Created by Hsusue on 2018/5/17.
//  Copyright © 2018年 Hsusue. All rights reserved.
//

#import "YDsearchBar.h"

@interface YDsearchBar () <UITextFieldDelegate>

// placeholder 和icon 和 间隙的整体宽度
@property (nonatomic, assign) CGFloat placeholderWidth;

@end

// icon宽度
static CGFloat const searchIconW = 15.0f;
// icon与textField间距
static CGFloat const iconSpacing = 4.0f;
// 默认系统占位文字的字体大小 用于设置间距


@implementation YDsearchBar
@synthesize textField = _textField;


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _placeHolderFont = 15;
         self.keyboardAppearance= UIKeyboardAppearanceLight; //键盘颜色
           [self setBackgroundColor:OMTableview_BGCOLOR];//设置背景色
           UIImage* searchBarBg = [UIImage imageWithColor:[UIColor clearColor] size:self.size];//设置背景图片
        
           [self setBackgroundImage:searchBarBg];
           [self setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];//设置文本框背景
           self.layer.masksToBounds = YES;
           self.layer.cornerRadius = 4;
           self.layer.borderColor = [UIColor clearColor].CGColor;
        //
          self.textField = [self getTextField];
        self.textField.layer.cornerRadius = 4.0f;
        self.textField.layer.masksToBounds = YES;


    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
//     先默认居中placeholder
    // 顺便设置Icon 与 textField 的间距
    if (@available(iOS 11.0, *)) {
    self.searchTextPositionAdjustment = UIOffsetMake(iconSpacing, 0);
        float w = self.placeholderWidth;
        [self setPositionAdjustment:UIOffsetMake((self.width- self.placeholderWidth) / 2-16, 0) forSearchBarIcon:UISearchBarIconSearch];
         
    }
}

// 开始编辑的时候重置为靠左
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // 继续传递代理方法
    if ([self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        [self.delegate searchBarShouldBeginEditing:self];
    }
    if (@available(iOS 11.0, *)) {
        [self setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
    }
    return YES;
}
    
// 结束编辑的时候设置为居中
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        [self.delegate searchBarShouldEndEditing:self];
    }
    // 没输入文字时占位符居中
    if (textField.text.length == 0) {
        if (@available(iOS 11.0, *)) {
            [self setPositionAdjustment:UIOffsetMake((self.width- self.placeholderWidth) / 2-16, 0) forSearchBarIcon:UISearchBarIconSearch];
        }
    }
    return YES;
}
    
- (void)cleanOtherSubViews {
        for (UIView *subView in self.subviews) {
            if ([subView isKindOfClass:[UIView  class]]) {
                [[subView.subviews objectAtIndex:0] removeFromSuperview];
            }
        }
}

#pragma mark - setter & getter
// 计算placeholder、icon、icon和placeholder间距的总宽度
- (CGFloat)placeholderWidth {
    if (!_placeholderWidth) {
        CGSize size = [self.placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_placeHolderFont]} context:nil].size;
        _placeholderWidth = size.width + iconSpacing + searchIconW;
    }
    return _placeholderWidth;
}
- (void)setTextField:(UITextField *)textField{
    _textField = textField;
}
- (UITextField *)getTextField {
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 13.0) {
        UITextField *searchTextField = self.searchTextField;
        searchTextField.delegate = self;
           return searchTextField;
       }else{
           
           UITextField *searchTextField =  [self valueForKey:@"_searchField"];
            searchTextField.delegate = self;
           return searchTextField;
       }
}
   
- (void)setSearchIcon:(UIImage *)searchIcon{
    if ([searchIcon isKindOfClass:[UIImage class]]) {
        _searchIcon = searchIcon;
        [self setImage:searchIcon forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    }
}



//- (void)createKeyTool{
//    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
//    [topView setBackgroundColor:BOTTOMCOLOR];
//    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
//    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(doneAction)];
//    [doneButton setTintColor:mainTextColor];
//    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
//    [topView setItems:buttonsArray];
//    [self setInputAccessoryView:topView];
//}






@end
