//
//  YBProgressHUD.m
//  AlongChat
//
//  Created by yuanbo on 2017/9/4.
//  Copyright © 2017年 AlongChat. All rights reserved.
//

#import "YBProgressHUD.h"

@implementation YBProgressHUD
+(instancetype)shareinstance{
    
    static YBProgressHUD *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[YBProgressHUD alloc] init];
    });
    
    return instance;
    
}

+(void)show:(NSString *)msg inView:(UIView *)view mode:(YBProgressMode )myMode{
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    if (msg.length==0) {
        return;
    }
    [self show:msg inView:view mode:myMode customImgView:nil];
}

+(void)show:(NSString *)msg inView:(UIView *)view mode:(YBProgressMode )myMode customImgView:(UIImageView *)customImgView{
    //如果已有弹框，先消失
    if ([YBProgressHUD shareinstance].hud != nil) {
        [[YBProgressHUD shareinstance].hud hideAnimated:YES];
        [YBProgressHUD shareinstance].hud = nil;
    }
    
    //4\4s屏幕避免键盘存在时遮挡
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    [YBProgressHUD shareinstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    //这里设置是否显示遮罩层
    //[YJProgressHUD shareinstance].hud.dimBackground = YES;    //是否显示透明背景
    
    //是否设置黑色背景，这两句配合使用
    [YBProgressHUD shareinstance].hud.bezelView.color = [UIColor whiteColor];
    [YBProgressHUD shareinstance].hud.contentColor = [UIColor blackColor];
    
    [[YBProgressHUD shareinstance].hud setMargin:10];
    [[YBProgressHUD shareinstance].hud setRemoveFromSuperViewOnHide:YES];
    [YBProgressHUD shareinstance].hud.detailsLabel.text = msg;
    
    [YBProgressHUD shareinstance].hud.detailsLabel.font = [UIFont systemFontOfSize:14];
    switch ((NSInteger)myMode) {
        case YBProgressModeOnlyText:
            [YBProgressHUD shareinstance].hud.mode = MBProgressHUDModeText;
            break;
            
        case YBProgressModeLoading:
            [YBProgressHUD shareinstance].hud.mode = MBProgressHUDModeIndeterminate;
            break;
            
        case YBProgressModeCircle:{
            [YBProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loding"]];
            CABasicAnimation *animation= [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            animation.toValue = [NSNumber numberWithFloat:M_PI*2];
            animation.duration = 1.0;
            animation.repeatCount = 100;
            [img.layer addAnimation:animation forKey:nil];
            [YBProgressHUD shareinstance].hud.customView = img;
            
            
            break;
        }
        case YBProgressModeCustomerImage:
            [YBProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [YBProgressHUD shareinstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fail"]];;
            break;
            
        case YBProgressModeCustomAnimation:
            //这里设置动画的背景色
//            [YBProgressHUD shareinstance].hud.bezelView.color = [UIColor yellowColor];
            
            
            [YBProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [YBProgressHUD shareinstance].hud.customView = customImgView;
            
            break;
            
        case YBProgressModeSuccess:
            [YBProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [YBProgressHUD shareinstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            break;
            
        default:
            break;
    }
    
    
    
}


+(void)hide{
    if ([YBProgressHUD shareinstance].hud != nil) {
        [[YBProgressHUD shareinstance].hud hideAnimated:YES];
    }
}


+(void)showMessage:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:YBProgressModeOnlyText];
    [[YBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.0];
}



+(void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay{
    [self show:msg inView:view mode:YBProgressModeOnlyText];
    [[YBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:delay];
}

+(void)showSuccess:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view mode:YBProgressModeSuccess];
    [[YBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.0];

}
+(void)showSuccess:(NSString *)msg {
    UIWindow *view = [[UIApplication sharedApplication].windows firstObject];
    [self show:msg inView:view mode:YBProgressModeSuccess];
    [[YBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.0];
}

+(void)showMsgWithImage:(NSString *)msg imageName:(NSString *)imageName inview:(UIView *)view{
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    [self show:msg inView:view mode:YBProgressModeCustomerImage customImgView:img];
    [[YBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.0];
}
+(void)showMsgWithImage:(NSString *)msg imageName:(NSString *)imageName{
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    UIWindow *view = [[UIApplication sharedApplication].windows firstObject];
    [self show:msg inView:view mode:YBProgressModeCustomerImage customImgView:img];
    [[YBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.0];

}


+(void)showProgress:(NSString *)msg inView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    [self show:msg inView:view mode:YBProgressModeLoading];
}

+(MBProgressHUD *)showProgressCircle:(NSString *)msg inView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.detailsLabel.text = msg;
    return hud;
    
    
}

+(void)showProgressCircleNoValue:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:YBProgressModeCircle];
    
}

+(void)showProgressCircleNoValue:(NSString *)msg{
    UIWindow *view = [[UIApplication sharedApplication].windows firstObject];
    [self show:msg inView:view mode:YBProgressModeCircle];
}


+(void)showMsgWithoutView:(NSString *)msg{
#warning 星辰管理弹窗层级结构
    UIWindow *view = [[UIApplication sharedApplication].windows lastObject];
    [self show:msg inView:view mode:YBProgressModeOnlyText];
    [[YBProgressHUD shareinstance].hud hideAnimated:YES afterDelay:2.0];
}

+(void)showCustomAnimation:(NSString *)msg withImgArry:(NSArray *)imgArry inview:(UIView *)view{
    
    UIImageView *showImageView = [[UIImageView alloc] init];
    showImageView.animationImages = imgArry;
    [showImageView setAnimationRepeatCount:0];
    [showImageView setAnimationDuration:(imgArry.count + 1) * 0.075];
    [showImageView startAnimating];
    
    [self show:msg inView:view mode:YBProgressModeCustomAnimation customImgView:showImageView];
}
@end
