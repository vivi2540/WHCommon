//
//  WHResponderTextView.m
//  OperationsManagement
//
//  Created by 何文虎 on 2020/7/14.
//  Copyright © 2020 何文虎. All rights reserved.
//

#import "WHResponderTextView.h"

@implementation WHResponderTextView
- (UIResponder *)nextResponder
{
    if(_overrideNextResponder == nil){
        return [super nextResponder];
    }
    else{
        return _overrideNextResponder;
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (_overrideNextResponder != nil)
        return NO;
    else
        return [super canPerformAction:action withSender:sender];
}

@end
