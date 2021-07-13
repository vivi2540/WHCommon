//
//  OMYBSlider.h
//  OperationsManagement
//
//  Created by yuanbo on 2020/12/19.
//  Copyright © 2020 何文虎. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//title显示在滑块的上方或下方
typedef enum : NSUInteger{
    TopTitleStyle,
    BottomTitleStyle
}TitleStyle;

@interface OMYBSlider : UISlider

//是否显示百分比
@property (nonatomic,assign) BOOL isShowTitle;
@property (nonatomic,assign) TitleStyle titleStyle;

@end

NS_ASSUME_NONNULL_END
