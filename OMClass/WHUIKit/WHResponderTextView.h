//
//  WHResponderTextView.h
//  OperationsManagement
//
//  Created by 何文虎 on 2020/7/14.
//  Copyright © 2020 何文虎. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHResponderTextView : UITextView
@property (nonatomic, weak) UIResponder *overrideNextResponder;
@end

NS_ASSUME_NONNULL_END
