//
//  LZBKeyBoardToolBar.m
//  LZBKeyBoardView
//
// demo地址：https://github.com/lzbgithubcode/LZBKeyBoardView.git
//  Created by zibin on 16/12/4.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "LZBKeyBoardToolBar.h"
#import "LZBTextView.h"
#import "UIView+LZBViewFrame.h"

//颜色转换
#define LZBColorRGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define LZBKeyboardBundleImage(name) [UIImage imageNamed:[NSString stringWithFormat:@"%@%@",@"Resource.bundle/",name]]

#define kKeyboardViewToolBarHeight 60  // 默认键盘输入工具条的高度
#define kKeyboardViewToolBar_TextView_Height 40  // 默认键盘输入框的高度
#define kKeyboardViewToolBar_TextView_LimitHeight 60  // 默认键盘输入框的限制高度
#define kKeyboardViewToolBar_SendBtn_Width 40  // 默认发送按钮的宽度
#define kKeyboardViewToolBar_Horizontal_DefaultMargin 10  //水平方向默认间距
#define kKeyboardViewToolBar_Vertical_DefaultMargin 8  //垂直方向默认间距
#define LZBScreenHeight [UIScreen mainScreen].bounds.size.height
#define LZBScreenWidth [UIScreen mainScreen].bounds.size.width
#define inputextViewFont [UIFont systemFontOfSize:14.0]

@interface LZBKeyBoardToolBar()
//View
@property (nonatomic, strong) LZBTextView *inputTextView;  //输入框
@property (nonatomic, strong) UIView *topLine;      // 顶部分割线
@property (nonatomic, strong) UIView *bottomLine;      // 底部分割线
@property (nonatomic, strong) UIButton *sendBtn;      // 发送按钮

//data
@property (nonatomic, copy) void(^sendTextBlock)(NSString *text);  //输入框输入字符串回调Blcok
@property (nonatomic, assign) CGFloat textHeight;   //输入文字高度
@property (nonatomic, assign) CGFloat animationDuration;  //动画时间
@property (nonatomic, strong) NSString *placeHolder;  //占位文字

@property (nonatomic, copy) void(^KeyBoardtBlock)(NSNotification *notification,BOOL isShow,CGFloat offsetMarginY,CGFloat animationDuration);

@end

@implementation LZBKeyBoardToolBar

#pragma mark - API
+ (LZBKeyBoardToolBar *)showKeyBoardWithConfigToolBarHeight:(CGFloat)toolBarHeight sendTextCompletion:(void(^)(NSString *sendText))sendTextBlock keyBoadrdCompletion:(void (^)(NSNotification *, BOOL,CGFloat,CGFloat))keyBoadrdCompletion
{
    LZBKeyBoardToolBar *toolBar = [[LZBKeyBoardToolBar alloc]init];
    toolBar.backgroundColor = LZBColorRGB(247, 248, 250);
    if(toolBarHeight < kKeyboardViewToolBarHeight)
        toolBarHeight = kKeyboardViewToolBarHeight;
    
    toolBar.frame = CGRectMake(0, ScreenHeight - toolBarHeight - HS_TabbarSafeBottomMargin, LZBScreenWidth, toolBarHeight +HS_TabbarSafeBottomMargin);

    toolBar.sendTextBlock = sendTextBlock;
    toolBar.KeyBoardtBlock = keyBoadrdCompletion;
    toolBar.hidden = YES;
    return toolBar;
    
}
- (void)setInputViewPlaceHolderText:(NSString *)placeText
{
    self.inputTextView.placeholder = placeText;
    self.placeHolder = placeText;
}
- (void)becomeFirstResponder{
    [self.inputTextView becomeFirstResponder];
    self.hidden = NO;
}

- (void)resignFirstResponder{
    self.hidden = YES;
    [self.inputTextView resignFirstResponder];
}


#pragma mark - private
- (instancetype)initWithFrame:(CGRect)frame
{
  if(self = [super initWithFrame:frame])
  {
      [self setupUI];
  }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

- (void)setupUI
{
    [self addSubview:self.inputTextView];
    [self addSubview:self.topLine];
    [self addSubview:self.bottomLine];
    [self addSubview:self.sendBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self.inputTextView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
     __weak typeof(self) weakSelf = self;
    
    CGFloat height = (self.textHeight + kKeyboardViewToolBar_TextView_Height +HS_TabbarSafeBottomMargin)> kKeyboardViewToolBarHeight +HS_TabbarSafeBottomMargin ? (self.textHeight + kKeyboardViewToolBar_TextView_Height + HS_TabbarSafeBottomMargin) : kKeyboardViewToolBarHeight +HS_TabbarSafeBottomMargin;
    CGFloat offsetY = self.LZB_heigth - height;
    [UIView animateWithDuration:self.animationDuration animations:^{
        weakSelf.LZB_y  += offsetY;
        weakSelf.LZB_heigth = height;
    }];
    
    self.topLine.LZB_width = self.LZB_width;
    self.bottomLine.LZB_width = self.LZB_width;
    
    
    self.sendBtn.LZB_width = 50*ScreenWScale;
    self.sendBtn.LZB_heigth = 40*ScreenWScale;
    self.sendBtn.LZB_x = self.LZB_width - 50*ScreenWScale - kKeyboardViewToolBar_Horizontal_DefaultMargin;
    
    
    self.inputTextView.LZB_width = self.LZB_width - 50*ScreenWScale - 3 *kKeyboardViewToolBar_Horizontal_DefaultMargin;
    self.inputTextView.LZB_x = kKeyboardViewToolBar_Horizontal_DefaultMargin;

    
    [UIView animateWithDuration:self.animationDuration animations:^{
        weakSelf.inputTextView.LZB_heigth = weakSelf.LZB_heigth - 2 *kKeyboardViewToolBar_Vertical_DefaultMargin - HS_TabbarSafeBottomMargin;
        weakSelf.inputTextView.LZB_y = 10;
        weakSelf.sendBtn.LZB_y = weakSelf.LZB_heigth - 40*ScreenWScale -kKeyboardViewToolBar_Vertical_DefaultMargin - HS_TabbarSafeBottomMargin;
        weakSelf.bottomLine.LZB_y = weakSelf.LZB_heigth - weakSelf.bottomLine.LZB_heigth;
    }];
    
    [self.inputTextView setNeedsUpdateConstraints];
}



#pragma mark - handle

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
     CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
     CGFloat keyboardHeight = keyboardFrame.size.height;
     CGFloat keyboardAnimaitonDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
     self.animationDuration = keyboardAnimaitonDuration;
     NSInteger option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    //判断键盘是否出现
    BOOL isKeyBoardHidden = LZBScreenHeight == keyboardFrame.origin.y;
    NSLog(@"-------%f--------%f------%d",keyboardFrame.origin.y,LZBScreenHeight,isKeyBoardHidden);

    
//    CGFloat offsetMarginY = isKeyBoardHidden ? LZBScreenHeight - self.LZB_heigth :LZBScreenHeight - self.LZB_heigth - keyboardHeight + HS_TabbarSafeBottomMargin;
    
    
    CGFloat offsetMarginY = isKeyBoardHidden ? LZBScreenHeight - self.LZB_heigth :LZBScreenHeight - self.LZB_heigth - keyboardHeight + HS_TabbarSafeBottomMargin;
    
    
    if (self.KeyBoardtBlock) {
        self.KeyBoardtBlock(notification,isKeyBoardHidden,offsetMarginY,self.animationDuration);
    }
    
    [UIView animateKeyframesWithDuration:self.animationDuration delay:0 options:option animations:^{
//        self.LZB_y = offsetMarginY;
    } completion:nil];
    
    if (isKeyBoardHidden) {
        self.hidden = YES;
    }
}

- (void)textDidChange
{
   if([self.inputTextView.text containsString:@"\n"])
   {
       self.inputTextView.text = [self.inputTextView.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
       [self sendBtnClick];
       return;
   }
    
    CGFloat margin = self.inputTextView.textContainerInset.left + self.inputTextView.textContainerInset.right;
    
    CGFloat height = [self.inputTextView.text boundingRectWithSize:CGSizeMake(self.inputTextView.LZB_width - margin, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.inputTextView.font} context:nil].size.height;
    
    if(height == self.textHeight) return;
    
    // 确保输入框不会无限增高，控制在显示4行
    if (height > kKeyboardViewToolBar_TextView_LimitHeight) {
        return;
    }
    self.textHeight = height;
    
    [self setNeedsLayout];
}

- (void)sendBtnClick
{
   if(self.sendTextBlock)
       self.sendTextBlock(self.inputTextView.text);
    self.textHeight = 0;
    [self resetInputView];
}

- (void)resetInputView
{
    self.inputTextView.text = @"";
    [self setInputViewPlaceHolderText:self.placeHolder.length > 0 ? self.placeHolder : @""];
    [self.inputTextView resignFirstResponder];
     self.inputTextView.placeHolderHidden = self.inputTextView.hasText;
}


#pragma mark - lazy
- (UIButton *)sendBtn {
  if(_sendBtn == nil) {
      _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
      [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
      [_sendBtn setTitleColor:UIColorFromHex(0x2E7FFF) forState:UIControlStateNormal];
      _sendBtn.titleLabel.font = PFSC_RegularFont(14);
      [_sendBtn addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
  }
    return _sendBtn;
}
- (LZBTextView *)inputTextView
{
  if(_inputTextView == nil)
  {
      _inputTextView = [[LZBTextView alloc]init];
      _inputTextView.layer.cornerRadius = 4;
      _inputTextView.layer.masksToBounds = YES;
//      _inputTextView.layer.borderWidth = 1;
//      _inputTextView.layer.borderColor = LZBColorRGB(221, 221, 221).CGColor;
      _inputTextView.font = inputextViewFont;
      _inputTextView.textColor = LZBColorRGB(102, 102, 102);
      _inputTextView.tintColor = _inputTextView.textColor;
      _inputTextView.enablesReturnKeyAutomatically = YES;
      _inputTextView.returnKeyType = UIReturnKeySend;
      _inputTextView.placeholderColor = LZBColorRGB(150, 150, 150);
       _inputTextView.inputAccessoryView = [UIView new];
  }
    return _inputTextView;
}

- (UIView *)topLine{
    if (_topLine == nil) {
        _topLine = [[UIView alloc] init];
        _topLine.LZB_heigth = 0.5;
        _topLine.backgroundColor = LZBColorRGB(214, 214, 214);
    }
    return _topLine;
}

- (UIView *)bottomLine{
    if (_bottomLine == nil) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = LZBColorRGB(214, 214, 214);
        _bottomLine.LZB_heigth = 0.5;
        _bottomLine.hidden = YES;
    }
    return _bottomLine;
}
@end
