//
//  OMSearchBar.h
//  OperationsManagement
//
//  Created by yuanbo on 2020/12/26.
//  Copyright © 2020 何文虎. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OMSearchBar : UISearchBar<UITextFieldDelegate>

// placeholder 和icon 和 间隙的整体宽度
@property (nonatomic, assign) CGFloat placeholderWidth;

@end

NS_ASSUME_NONNULL_END
