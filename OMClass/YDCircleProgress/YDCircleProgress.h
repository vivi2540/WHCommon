//
//  YDCircleProgress.h
//  Jumper
//
//  Created by 司亚冰 on 2017/5/13.
//  Copyright © 2017年 SP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YDCircleProgress : UIView

- (instancetype)initWithFrame:(CGRect)frame isManJi:(BOOL)isManJi num:(CGFloat )num;

@property (nonatomic,assign) CGFloat progress;  //进度 0 ~ 100

@property (nonatomic, assign)CGFloat num;
@property (nonatomic, assign)BOOL isManji; //15
@end
