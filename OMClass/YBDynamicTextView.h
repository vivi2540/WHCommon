//
//  YBDynamicTextView.h
//  AlongChat
//
//  Created by yuanbo on 2017/9/16.
//  Copyright © 2017年 AlongChat. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YB_textHeightChangedBlock)(NSString *text,CGFloat textHeight);

@interface YBDynamicTextView : UITextView


/**
 *  占位文字
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 *  占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 *  占位符字体大小
 */
@property (nonatomic,strong) UIFont *placeholderFont;

/**
 *  textView最大行数
 */
@property (nonatomic, assign) NSUInteger maxNumberOfLines;

/**
 *  文字高度改变block → 文字高度改变会自动调用
 *  block参数(text) → 文字内容
 *  block参数(textHeight) → 文字高度
 */
@property (nonatomic, strong) YB_textHeightChangedBlock textChangedBlock;
/**
 *  设置圆角
 */
@property (nonatomic, assign) NSUInteger cornerRadius;

- (void)textValueDidChanged:(YB_textHeightChangedBlock)block;
@end
