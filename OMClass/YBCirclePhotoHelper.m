//
//  YBCirclePhotoHelper.m
//  DrofAcne
//
//  Created by yuanbo on 2020/7/2.
//  Copyright © 2020 YB. All rights reserved.
//

#import "YBCirclePhotoHelper.h"
#import "JJDataModel.h"

@implementation YBCirclePhotoHelper

-(void)tapImageAction:(UITapGestureRecognizer *)tap{
    UIImageView *tapView = (UIImageView *)tap.view;
    NSMutableArray *models = [NSMutableArray array];
    for (NSString *img in self.dataSource) {
        JJDataModel *model = [[JJDataModel alloc]init];
        model.imgUrl = img;
        [models addObject:model];
    }
    NSLog(@"~~~~~~~~~~~%ld",tapView.tag);

    if (self.tapBlock) {
        self.tapBlock(tapView.tag,models,tapView);
    }
}

-(void)setDataSource:(NSArray *)dataSource{
    _dataSource = dataSource;
    //单张图片的大小
//    CGFloat jgg_width = ScreenWidth-24 - 34;
    CGFloat jgg_width = ScreenWidth-24 - 34;
    if (dataSource.count == 1) {
        jgg_width = ScreenWidth-24 - 34;
    };

    CGFloat imageWidth =  (jgg_width-2*kGAP)/3;
    CGFloat imageHeight =  imageWidth;
    for (NSUInteger i=0; i<dataSource.count; i++) {
//        YYAnimatedImageView *iv = [[YYAnimatedImageView alloc]initWithFrame:CGRectMake(0+(imageWidth+kGAP)*(i%3),floorf(i/3.0)*(imageHeight+kGAP),imageWidth, imageHeight)];
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(0+(imageWidth+kGAP)*(i%3),floorf(i/3.0)*(imageHeight+kGAP),imageWidth, imageHeight)];

        iv.layer.cornerRadius = 5;
        iv.contentMode = UIViewContentModeScaleAspectFill;
        iv.layer.masksToBounds = YES;
            if ([dataSource[i] isKindOfClass:[UIImage class]]) {
            iv.image = dataSource[i];
        }else if ([dataSource[i] isKindOfClass:[NSString class]]){
            [iv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dataSource[i]]] placeholderImage:ImageNamed(@"user_avatar_nor")];
            
        }else if ([dataSource[i] isKindOfClass:[NSURL class]]){
            [iv sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",dataSource[i]]] placeholderImage:ImageNamed(@"user_avatar_nor")];
            
        }
        iv.userInteractionEnabled = YES;//默认关闭NO，打开就可以接受点击事件
        iv.tag = i;
        NSLog(@"~~~~~~~~~~~%ld",iv.tag);
//        iv.autoPlayAnimatedImage = YES;
        [self addSubview:iv];
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageAction:)];
        [iv addGestureRecognizer:singleTap];
    }
}


@end
