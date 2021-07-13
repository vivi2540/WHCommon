//
//  WHPlayVideoView.m
//  SkinConsultation
//
//  Created by 何文虎 on 2019/12/13.
//  Copyright © 2019 何文虎. All rights reserved.
//

#import "WHPlayVideoView.h"

@interface WHPlayVideoView ()<WMPlayerDelegate>
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)WMPlayer * wmPlayer;
@end

@implementation WHPlayVideoView

+ (void)showPlayVideoViewWithUrl:(NSString*)url title:(NSString*)title{
    WHPlayVideoView *videoView = [[WHPlayVideoView alloc]initWithUrl:url title:@""];
    [videoView show];
}


- (instancetype)initWithUrl:(NSString*)url title:(NSString*)title{
    if (self == [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        
        self.contentView = [[UIView alloc]initWithFrame:self.bounds];
        [self addSubview:self.contentView];
        WMPlayerModel *playerModel = [WMPlayerModel new];
        playerModel.title = title;
        playerModel.videoURL = [NSURL URLWithString:url];
        self.wmPlayer = [[WMPlayer alloc]initPlayerModel:playerModel];
        [self.contentView addSubview:self.wmPlayer];
        [self.wmPlayer mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.leading.trailing.top.equalTo(self.contentView);
//            make.height.mas_equalTo(wmPlayer.mas_width).multipliedBy(9.0/16);
            make.edges.mas_equalTo(self.contentView);
        }];
        self.wmPlayer.delegate = self;
        [self.wmPlayer play];
    }
    
    return self;
}

- (void)show{

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    keyWindow.backgroundColor = [UIColor clearColor];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [keyWindow addSubview:self];
    NSArray *view_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    NSArray *view_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[self]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(self)];
    [keyWindow addConstraints:view_H];
    [keyWindow addConstraints:view_V];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden)];
//    [self addGestureRecognizer:tap];
    
//   self.contentView.transform = CGAffineTransformMakeScale(0.1,0.1);
    [UIView animateWithDuration:0.1f animations:^{
        
//        self.contentView.transform = CGAffineTransformMakeScale(1.0,1.0);
        
    }];
    
}

#pragma mark - WMPlayerDelegate
//点击播放暂停按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedPlayOrPauseButton:(UIButton *)playOrPauseBtn{
    
}
//点击关闭按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedCloseButton:(UIButton *)backBtn{
    [self hidden];
}
//点击全屏按钮代理方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedFullScreenButton:(UIButton *)fullScreenBtn{
    
}
//点击锁定🔒按钮的方法
-(void)wmplayer:(WMPlayer *)wmplayer clickedLockButton:(UIButton *)lockBtn{
    
}
//单击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer singleTaped:(UITapGestureRecognizer *)singleTap{
    
}
//双击WMPlayer的代理方法
-(void)wmplayer:(WMPlayer *)wmplayer doubleTaped:(UITapGestureRecognizer *)doubleTap{
    
}
//WMPlayer的的操作栏隐藏和显示
-(void)wmplayer:(WMPlayer *)wmplayer isHiddenTopAndBottomView:(BOOL )isHidden{
    
}
//播放失败的代理方法
-(void)wmplayerFailedPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    
}
//准备播放的代理方法
-(void)wmplayerReadyToPlay:(WMPlayer *)wmplayer WMPlayerStatus:(WMPlayerState)state{
    
}
//播放器已经拿到视频的尺寸大小
-(void)wmplayerGotVideoSize:(WMPlayer *)wmplayer videoSize:(CGSize )presentationSize{
    
}
//播放完毕的代理方法
-(void)wmplayerFinishedPlay:(WMPlayer *)wmplayer{
    [self hidden];
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isDescendantOfView:self.contentView]) {
           return NO;
    }
    return YES;
}



- (void)hidden{
    
    [_wmPlayer pause];
    [_wmPlayer resetWMPlayer];
    [UIView animateWithDuration:0.2f animations:^{
//        self.contentView.transform = CGAffineTransformMakeScale(0.1,0.1);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }];
}


@end
