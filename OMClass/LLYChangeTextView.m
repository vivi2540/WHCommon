//
//  LLYChangeTextView.m
//  MerChant
//
//  Created by yuanbo on 2019/9/18.
//  Copyright © 2019 YuanBo. All rights reserved.
//

#import "LLYChangeTextView.h"
//#import "NSString+ZXNSString.h"
#import "Masonry.h"

#define textViewTextChange @"textViewTextChange"
//移除字符串中的空格
//把strNeedChange中的currentStr替换成repalceStr (NSString)
#define replaceString_currentStr_To_repalceStr_For_strNeedChange(currentStr,repalceStr,strNeedChange)\
[strNeedChange stringByReplacingOccurrencesOfString:currentStr withString:repalceStr]

//字符串是否为空
#define StringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

@interface LLYChangeTextView ()<UITextViewDelegate>

@property (assign,nonatomic) CGFloat textCountLabelHeight;

@end


@implementation LLYChangeTextView

-(UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(280*ScreenWScale, 60*ScreenWScale, 50*ScreenWScale, 15*ScreenWScale)];
        _placeholderLabel.textColor = [NSString colorWithHexString:@"#D8D8D8"];
        _placeholderLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:11*ScreenWScale];
        _placeholderLabel.textAlignment = NSTextAlignmentRight;
    }
    return _placeholderLabel;
}

#pragma mark - 更新提示文字
- (void)updateplaceHolderLabel:(NSInteger)textlengh {
    self.placeholderLabel.text = [NSString stringWithFormat:@"%ld/%ld",textlengh,_maxTextCount];
    if (textlengh == _maxTextCount) {
        self.placeholderLabel.textColor = [UIColor redColor];
    }else {
        self.placeholderLabel.textColor = [NSString colorWithHexString:@"#999999"];
    }
    
}

+(LLYChangeTextView *)textViewWithPlaceHolder:(NSString *)placeHolder
{
    LLYChangeTextView *textView=[[LLYChangeTextView alloc] init];
    textView.placeHolder=placeHolder;
    textView.placeHolderTextColor=[[UIColor grayColor] colorWithAlphaComponent:0.5];
    textView.maxTextCount=200;
    return textView;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder])
    {
//        [self addSubview:self.placeholderLabel];

        [self initParamsFirst];
        [self setupSubviews];
        [self initParamsLast];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self==[super initWithFrame:frame])
    {
//        [self addSubview:self.placeholderLabel];

        [self initParamsFirst];
        [self setupSubviews];
        [self initParamsLast];
    }
    return self;
}

-(void)initParamsFirst
{
    self.backgroundColor=[UIColor whiteColor];
    self.textCountLabelHeight=13;
}

-(void)initParamsLast
{
    self.maxTextCount=200;
    self.placeHolderTextColor=[[UIColor grayColor] colorWithAlphaComponent:0.7];
}

-(void)setupSubviews
{
    self.textView=[[UITextView alloc] init];
    self.textView.font = PFSC_RegularFont(14);
    self.textView.textColor = kTextBlackClor;
    self.textView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.textView];
    self.textView.returnKeyType=UIReturnKeyDone;
    
    
    
    self.clearBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.clearBtn];
    self.clearBtn.hidden = YES;
    self.clearBtn.hidden=YES;
    [self.clearBtn setBackgroundImage:[UIImage imageNamed:@"quickPay_close"] forState:UIControlStateNormal];
    [self.clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    

    
    
//    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@6);
//        make.leading.equalTo(@12);
//        make.trailing.equalTo(self).offset(-14);
//        make.bottom.equalTo(@(-30*WIDTHSCALE));
//    }];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.insets(UIEdgeInsetsMake(12, 12, 12, 12));
    }];

    self.textView.delegate=self;
    
    [self.clearBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).offset(9);
        make.top.equalTo(self.textView).offset(-9);
        make.height.mas_equalTo(44);
        make.width.mas_equalTo(44);
    }];
}

#pragma mark - 点击事件
-(void)clearBtnClick:(UIButton *)button
{
    self.text=@"";
}


#pragma mark - 方法重写
-(void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder=placeHolder;
    self.textView.text=placeHolder;
    
    [self refreshTextUI];
}

-(void)setPlaceHolderTextColor:(UIColor *)placeHolderTextColor
{
    _placeHolderTextColor=placeHolderTextColor;
    self.textView.textColor=placeHolderTextColor;
}

-(void)setMaxTextCount:(NSUInteger)maxTextCount
{
    _maxTextCount=maxTextCount;
    [self refreshTextUI];
}

-(void)setText:(NSString *)text
{
    self.textView.text=text;
    self.textView.textColor=[NSString colorWithHexString:@"#333333"];
    
    if (StringIsEmpty(text))
    {
        [self setClearBtnStateHidden];
    }
    
    [self refreshTextUI];
}

-(NSString *)text
{
    NSString *content = self.textView.text;
    if ([content isEqualToString:self.placeHolder])
    {
        return @"";
    }
    return content;
}

#pragma mark - 其他方法
-(void)refreshTextUI
{
    //    if ([self.textView.text isEqualToString:self.placeHolder])
    //    {
    //        self.textCountLabel.text=[NSString stringWithFormat:@"  最多可输入250字"];
    //    }
    //    else
    //    {
    //        self.textCountLabel.text=[NSString stringWithFormat:@"%ld/%ld",(unsigned long)self.textView.text.length,(unsigned long)self.maxTextCount];
    //    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    //得到输入框的内容
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
 
    NSString * toBeString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    if (self.textView == textView)  //判断是否时想要限定的那个输入框
    {
        [self updateplaceHolderLabel:toBeString.length];
        if (toBeString.length >_maxTextCount) {
            //其实输入的字符串为toBeString
            //            [self settingTextView:textView fromText:[toBeString substringToIndex:_maxTextCount]];
            NSLog(@"%@,%ld",textView.text,textView.text.length);
            if (textView.text.length < _maxTextCount) {
                textView.text = [textView.text substringToIndex:textView.text.length];
                [YBProgressHUD showMsgWithoutView:@"粘贴内容超限,请删减后重新输入"];
                [self updateplaceHolderLabel:textView.text.length];
            }else {
                textView.text = [textView.text substringToIndex:_maxTextCount];
                [self updateplaceHolderLabel:_maxTextCount];
            }
            return NO;
        }
    }
//    if ([NSString isContainsTwoEmoji:text]) {
//        [YBProgressHUD showMsgWithoutView:@"不允许输入支持此表情"];
//        return NO;
//    }
    [textView scrollRangeToVisible:range];
    
    return YES;
}


#pragma mark - textViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(llyTextViewShouldBeginEditing:)])
    {
        [self.delegate llyTextViewShouldBeginEditing:self];
    }
    
    if ([self.textView.text isEqualToString:self.placeHolder])
    {
        textView.text=@"";
        textView.textColor=[NSString colorWithHexString:@"#333333"];
    }
    
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector(llyTextViewShouldEndEditing:)])
    {
        [self.delegate llyTextViewShouldEndEditing:self];
    }
    
    if (self.textView.text.length<1)
    {
        textView.text=self.placeHolder;
        textView.textColor=self.placeHolderTextColor;
    }
    
    if (StringIsEmpty(self.textView.text) || [self.textView.text isEqualToString:self.placeHolder]) {
        [self setClearBtnStateHidden];
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length>=self.maxTextCount) {
        textView.text=[textView.text substringToIndex:self.maxTextCount];
    }
    
    if (StringIsEmpty(self.textView.text)) {
        [self setClearBtnStateHidden];
    }
    else
    {
        [self setClearBtnStateShow];
    }
    
    [self refreshTextUI];
    if ([self.delegate respondsToSelector:@selector(llyTextViewDidChanged:)]) {
        [self.delegate llyTextViewDidChanged:self.textView];
    }
}



#pragma mark - 其他方法
-(BOOL)isNoContent
{
    //去除空格
    //    NSString *textViewText=[self.textView.text removeEmptyStr];
    NSString *textViewText=replaceString_currentStr_To_repalceStr_For_strNeedChange(@" ", @"", self.textView.text);
    
    if ([textViewText isEqualToString:self.placeHolder] || [textViewText isEqualToString:@""] || textViewText.length<1)
    {
        return YES;
    }
    return NO;
}

-(void)setClearBtnStateHidden
{
    self.clearBtn.hidden=YES;
}
-(void)setClearBtnStateShow
{
    self.clearBtn.hidden=YES;
}


@end
