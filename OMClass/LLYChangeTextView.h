//
//  LLYChangeTextView.h
//  MerChant
//
//  Created by yuanbo on 2019/9/18.
//  Copyright © 2019 YuanBo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLYChangeTextView;
@protocol LLYChangeTextViewDelegate <NSObject>

@optional
-(void)llyTextViewShouldBeginEditing:(LLYChangeTextView *)xbTextView;
-(void)llyTextViewShouldEndEditing:(LLYChangeTextView *)xbTextView;
-(void)llyTextViewDidChanged:(LLYChangeTextView *)xbTextView;

@end

NS_ASSUME_NONNULL_BEGIN

@interface LLYChangeTextView : UIView

@property (strong, nonatomic)  UITextView *textView;

@property (strong,nonatomic) UIButton *clearBtn;

/** 占位文字:placeHolder */
@property (copy,nonatomic) NSString *placeHolder;

/** 占位文字的颜色,默认灰色 */
@property (strong,nonatomic) UIColor *placeHolderTextColor;

/** 最大输入文字,如果未设置,默认200 */
@property (assign,nonatomic) NSUInteger maxTextCount;

/** 内容 */
@property (copy,nonatomic) NSString *text;

/** 创建textView */
+(LLYChangeTextView *)textViewWithPlaceHolder:(NSString *)placeHolder;


/**
 * 未填写内容
 */
@property (assign,nonatomic,getter=isNoContent) BOOL noContent;

@property (nonatomic,weak) id <LLYChangeTextViewDelegate> delegate;

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

NS_ASSUME_NONNULL_END
