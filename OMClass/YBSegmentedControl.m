//
//  YBSegmentedControl.m
//  LearnIngDuck
//
//  Created by yuanbo on 2020/2/19.
//  Copyright © 2020 yuanbo. All rights reserved.
//

#import "YBSegmentedControl.h"

@implementation YBSegmentedControl

- (void)layoutSubviews {
    [super layoutSubviews];
    self.layer.cornerRadius = 1;
}

- (void)ensureiOS12Style {
  
//    if (@available(iOS 13, *)) {
//    }
    UIColor *tintColor = OMBlue_COLOR;
    UIImage *tintColorImage = [self imageWithColor:tintColor];

    [self setBackgroundImage:[self imageWithColor:self.backgroundColor ? self.backgroundColor : [UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:tintColorImage forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:[self imageWithColor:[tintColor colorWithAlphaComponent:0.2]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    [self setBackgroundImage:tintColorImage forState:UIControlStateSelected|UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self setDividerImage:tintColorImage forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: kTextGay9Clor, NSFontAttributeName: PFSC_RegularFont(12)} forState:UIControlStateNormal];
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName: PFSC_RegularFont(12)} forState:UIControlStateSelected];
    self.layer.masksToBounds = YES;
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = [tintColor CGColor];
}

- (UIImage *)imageWithColor: (UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
