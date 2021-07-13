//
//  WHDashLineView.h
//  OperationsManagement
//
//  Created by 何文虎 on 2020/6/8.
//  Copyright © 2020 何文虎. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHDashLineView : UIView
- (void)addDashLineWithFrame:(CGRect)frame withLineLength:(NSInteger)lineLength withLineSpacing:(NSInteger)lineSpacing withLineColor:(UIColor *)lineColor;
//- (instancetype)initWithFrame:(CGRect)frame withLineLength:(NSInteger)lineLength withLineSpacing:(NSInteger)lineSpacing withLineColor:(UIColor *)lineColor;
@end

NS_ASSUME_NONNULL_END
