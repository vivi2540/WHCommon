//
//  UIImageView+WHImageView.h
//  SkinConsultation
//
//  Created by 何文虎 on 2019/12/13.
//  Copyright © 2019 何文虎. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (WHImageView)
- (void)videoImageWithvideoURL:(NSURL *)videoURL atTime:(NSTimeInterval)time;
@end

NS_ASSUME_NONNULL_END
