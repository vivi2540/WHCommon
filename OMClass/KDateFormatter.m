//
//  KDateFormatter.m
//  HeadManage
//
//  Created by tenghu on 2017/12/8.
//  Copyright © 2017年 Tenghu. All rights reserved.
//

#import "KDateFormatter.h"

@implementation KDateFormatter

+ (instancetype)sharedDateFormatter{
    
    static KDateFormatter *_instanceType = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[KDateFormatter alloc]init];
    });
    
    return _instanceType;
}


@end
