//
//  UIViewController+WHExtension.h
//  WKMaybell
//
//  Created by 何文虎 on 2018/12/5.
//  Copyright © 2018年 何文虎. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (WHExtension)


/** 获取当前显示的控制器 */
- (__kindof UIViewController*)topViewControllerWithRootViewController:(__kindof UIViewController*)rootViewController;

/** 获取当前window最上层的控件器 */
- (UIViewController *)getCurrentTopViewController;

/** 返回上一层控制器 */
- (void)backController;

/** present多层控制器后，返回到最底层控制器 */
- (void)dismissViewControllerClass:(Class)cla;

@end

NS_ASSUME_NONNULL_END
