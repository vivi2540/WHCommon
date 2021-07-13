//
//  UITextView+WHTextView.h
//  WKMaybell
//
//  Created by 何文虎 on 2018/12/5.
//  Copyright © 2018年 何文虎. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (WHTextView)
/** 注意先设置textView的字体 */
@property (nonatomic,copy) NSString *placeholder;
@end

NS_ASSUME_NONNULL_END
