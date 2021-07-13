//
//  LXSegmentScrollView.m
//  LiuXSegment
//
//  Created by liuxin on 16/5/17.
//  Copyright © 2016年 liuxin. All rights reserved.
//

//#define MainScreen_W ([UIScreen mainScreen].bounds.size.width - 24)

#import "LXSegmentScrollView.h"
#import "LiuXSegmentView.h"

@interface LXSegmentScrollView()<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView *bgScrollView;
@property (strong,nonatomic)LiuXSegmentView *segmentToolView;

@property (nonatomic, assign)CGFloat MainScreen_W;
@end

@implementation LXSegmentScrollView


-(instancetype)initWithFrame:(CGRect)frame
                  titleArray:(NSArray *)titleArray
            contentViewArray:(NSArray *)contentViewArray{
    if (self = [super initWithFrame:frame]) {
        
        self.MainScreen_W = frame.size.width;

        [self addSubview:self.bgScrollView];
        
        _segmentToolView=[[LiuXSegmentView alloc] initWithFrame:CGRectMake(0, 0, self.MainScreen_W, 44) titles:titleArray clickBlick:^void(NSInteger index) {
            NSLog(@"-----%ld",index);
            [_bgScrollView setContentOffset:CGPointMake(self.MainScreen_W*(index-1), 0)];
        }];
        [self addSubview:_segmentToolView];
        
        
        for (int i=0;i<contentViewArray.count; i++ ) {
            
            UIView *contentView = (UIView *)contentViewArray[i];
            contentView.frame=CGRectMake(self.MainScreen_W * i, _segmentToolView.bounds.size.height, self.MainScreen_W, _bgScrollView.frame.size.height-_segmentToolView.bounds.size.height);
            [_bgScrollView addSubview:contentView];
            
            
        }
        _bgScrollView.contentSize=CGSizeMake(self.MainScreen_W*contentViewArray.count, self.bounds.size.height-_segmentToolView.bounds.size.height);

        
    }
    
    return self;
}






-(UIScrollView *)bgScrollView{
    if (!_bgScrollView) {
        _bgScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, _segmentToolView.frame.size.height, self.MainScreen_W, self.bounds.size.height-_segmentToolView.bounds.size.height)];
//        _bgScrollView.backgroundColor=[UIColor brownColor];
//        _bgScrollView.backgroundColor = WHRandomColor;
        _bgScrollView.showsVerticalScrollIndicator=NO;
        _bgScrollView.showsHorizontalScrollIndicator=NO;
        _bgScrollView.delegate=self;
        _bgScrollView.bounces=NO;
        _bgScrollView.pagingEnabled=YES;
    }
    return _bgScrollView;
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView==_bgScrollView)
    {
        NSInteger p=_bgScrollView.contentOffset.x/self.MainScreen_W;
        _segmentToolView.defaultIndex=p+1;
        
    }
    
}

@end
