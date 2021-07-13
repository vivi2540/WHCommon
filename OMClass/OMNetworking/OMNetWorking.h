//
//  SCNetWorking.h
//  OperationsManagement
//
//  Created by 何文虎 on 2020/5/9.
//  Copyright © 2020 何文虎. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OMNetWorking : NSObject
+ (RACSignal*)postWithParameDic:(NSDictionary*)parameDic;
+ (RACSignal*)postWithUrl:(NSString*)url parameDic:(NSDictionary*)parameDic;

+ (RACSignal*)postWithUrl:(NSString*)url parameDic:(NSDictionary*)parameDic cache:(BOOL)cache;
@end

NS_ASSUME_NONNULL_END
