//
//  UIViewController+PLPlaceholderView.m
//  ParkingLot
//
//  Created by LittleShrimp on 2019/7/6.
//  Copyright © 2019 FaceBook. All rights reserved.
//

#import "UIViewController+PLPlaceholderView.h"
#import <objc/runtime.h>
#import "UIView+Toast.h"

@implementation UIViewController (PLPlaceholderView)

-(void)setPlaceholderView:(UIView *)placeholderView{
    objc_setAssociatedObject(self, @selector(placeholderView), placeholderView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView *)placeholderView{
    return objc_getAssociatedObject(self, _cmd);
}
#pragma mark  刷新
-(void)reloadDataSoucre{
    
    
}
-(void)emptyWithView:(UIView*)view {
    [self createPlaceholderView:nil message:@"" image:[UIImage imageNamed:@"default_image_record"] withView:view];
}
-(void)networkErrorWithView:(UIView*)view  target:(id)target action:(SEL)action {
    [self createPlaceholderView:nil message:@"网络开小差啦~" image:[UIImage imageNamed:@"default_image_nonetwork"] withView:view action:YES target:target action:action];
}
-(void)networkErrorWithView:(UIView*)view  {
    [self createPlaceholderView:nil message:@"网络开小差啦~" image:[UIImage imageNamed:@"default_image_nonetwork"] withView:view action:YES target:self action:@selector(reloadDataSoucre)];
}
#pragma mark
- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self createPlaceholderView:title message:message image:image withView:superView action:NO ];
    });
}
- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView action:(BOOL)reloadAction {
    [self createPlaceholderView:title message:message image:image withView:superView action:reloadAction target:nil action:nil];
}

- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView  target:(id)target action:(SEL)action{
    [self createPlaceholderView:title message:message image:image withView:superView action:YES target:target action:action];
}
- (void)createPlaceholderView:(NSString *) title
                      message:(NSString *)message
                        image:(UIImage *)image
                     withView:(UIView *)superView action:(BOOL)reloadAction  target:(id)target action:(SEL)action {
    
    if (self.placeholderView) {
        [self.placeholderView removeFromSuperview];
        self.placeholderView = nil;
    }
    if(superView==nil){
        superView=self.view;
    }
    self.placeholderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, superView.bounds.size.width, superView.bounds.size.height)];
    [self.placeholderView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
    [self.placeholderView setAutoresizesSubviews:YES];
    [self.placeholderView setBackgroundColor:[UIColor clearColor]];
    [superView addSubview:self.placeholderView];
    CGRect pf = CGRectMake(0, 0, superView.bounds.size.width, 0);
    UIImageView *icon = [[UIImageView alloc]init];
    if(image){
        [icon setImage:image];
    }
    [icon setContentMode:UIViewContentModeScaleAspectFit];
    [icon setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    icon.frame = CGRectMake(0,0, pf.size.width, image.size.height);
    [self.placeholderView addSubview:icon];
    CGFloat y = icon.frame.size.height+20;
    if(title){
        
        CGFloat height=[WHUtiities sizeWithString:title font:PFSC_RegularFont(16) constraintSize:CGSizeMake(pf.size.width, MAXFLOAT)].height;
        UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, y, pf.size.width, height)];
        [lblTitle setText:title];
        [lblTitle setFont:PFSC_RegularFont(18)];
        [lblTitle setTextColor:UIColorFromRGB(0x666666)];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lblTitle setNumberOfLines:0];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [self.placeholderView addSubview:lblTitle];
        y = y +height + 5;
    }
    
    if(message){
        UILabel *lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(0, y, pf.size.width, 20)];
        [lblTitle setText:message];
        [lblTitle setFont:PFSC_RegularFont(14)];
        [lblTitle setTextColor:UIColorFromRGB(0x7A7A7A)];
        [lblTitle setTextAlignment:NSTextAlignmentCenter];
        [lblTitle setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lblTitle setAutoresizesSubviews:YES];
        [lblTitle setBackgroundColor:[UIColor clearColor]];
        [self.placeholderView addSubview:lblTitle];
        y=y+25;
    }
    if(reloadAction){
        UIButton *reButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [reButton setFrame:CGRectMake(pf.size.width/2-114/2, y+5, 114, 30)];
        [reButton setBackgroundImage:[UIImage imageWithColor:OMBlue_COLOR] forState:UIControlStateNormal];
        [reButton setBackgroundImage:[UIImage imageWithColor:OMBlue_COLOR] forState:UIControlStateDisabled];
        [reButton setBackgroundImage:[UIImage imageWithColor:OMBlue_COLOR] forState:UIControlStateHighlighted];
        [reButton setTitle:@"重新加载" forState:UIControlStateNormal];
        [reButton setTitle:@"      加载中..." forState:UIControlStateDisabled];
        [reButton setTitleColor:OMWhite_COLOR forState:UIControlStateNormal];
        [reButton setTitleColor:OMWhite_COLOR forState:UIControlStateDisabled];
        [reButton.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [reButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
        [reButton setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin];
        reButton.layer.cornerRadius  =15;
        reButton.layer.masksToBounds = YES;
        reButton.layer.borderColor =OMWhite_COLOR.CGColor;
        reButton.layer.borderWidth = 0.5;
        [self.placeholderView addSubview:reButton];
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        activityIndicator.tag=10;
        [activityIndicator setFrame:CGRectMake(192/2-45, 15, 20, 20)];
        [reButton addSubview:activityIndicator];
        y=y+60;
    }
    pf.size.height= y;
    [self.placeholderView setFrame:pf];
    [self.placeholderView setCenter:CGPointMake(superView.width * 0.5 , superView.height * 0.5-50)];
}
- (void)removePlaceholderView{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.placeholderView && self.placeholderView!=nil) {
            [self.placeholderView removeFromSuperview];
            self.placeholderView = nil;
        }
    });
}


- (void)makeToast:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToast:message duration:1.0f position:CSToastPositionCenter];
    });
    
}

- (void)makeaBottomToast:(NSString *)message{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToast:message duration:1.0f position:CSToastPositionBottom];
    });
}


- (void)makeToast:(NSString *)message duration:(NSTimeInterval)duration position:(ToastPositionType)position{
    NSString *positionType =@"CSToastPositionTop";
    switch (position) {
        case ToastPositionTypeTop:
            positionType =@"CSToastPositionTop";
            break;
        case ToastPositionTypeBottom:
            positionType =@"CSToastPositionBottom";
            break;
        case ToastPositionTypeCenter:
            positionType =@"CSToastPositionCenter";
            break;
        default:
            break;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.view makeToast:message duration:duration position:positionType];
    });
}

-(void)makeToast:(NSString *)message backImageView:(NSString *)image {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.view makeToast:message duration:1.0f position:CSToastPositionCenter title:nil image:[UIImage imageNamed:image] style:nil completion:nil];
    });
}

@end
