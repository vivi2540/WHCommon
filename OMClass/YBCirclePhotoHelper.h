//
//  YBCirclePhotoHelper.h
//  DrofAcne
//
//  Created by yuanbo on 2020/7/2.
//  Copyright © 2020 YB. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kGAP 10

NS_ASSUME_NONNULL_BEGIN

typedef void (^TapBlcok)(NSInteger index,NSArray *dataSource,UIImageView *img);

@interface YBCirclePhotoHelper : UIView

@property (nonatomic, retain)NSArray * dataSource;

@property (nonatomic, copy)TapBlcok  tapBlock;

@end

NS_ASSUME_NONNULL_END
