//
//  SCNetWorking.m
//  OperationsManagement
//
//  Created by 何文虎 on 2020/5/9.
//  Copyright © 2020 何文虎. All rights reserved.
//

#import "OMNetWorking.h"

@implementation OMNetWorking
+ (RACSignal*)postWithParameDic:(NSDictionary*)parameDic{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    if (LOGINUSER.e_id.length>0) {
        [parmas setObject:@"" forKey:@"secret_key"];
        [parmas setObject:BLANKSTRING(LOGINUSER.e_id) forKey:@"token_key"];
    }
    [parmas addEntriesFromDictionary:parameDic];
    
    RACSubject *subject = [RACSubject subject];
    [WHNetworking cacheGetRequest:NO shoulCachePost:NO];
    NSString *rsUrl = [NSString stringWithFormat:@"%@interface.php",LOGINUSER.url];
    [WHNetworking postWithUrl:rsUrl refreshCache:NO params:parmas success:^(id response) {
        if (AFSTATUS(response)==50 || AFSTATUS(response)==51) {
            [OMClass forceUserLogoutWithMessage:AFERRORMSG(response)];
        }else{
            [subject sendNext:response];
            [subject sendCompleted];
        }
    } fail:^(NSError *error) {
        [subject sendError:error];
        [subject sendCompleted];
    }];
    return subject;
}


+ (RACSignal*)postWithUrl:(NSString*)url parameDic:(NSDictionary*)parameDic{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    if (LOGINUSER.e_id.length>0) {
        [parmas setObject:@"" forKey:@"secret_key"];
        [parmas setObject:BLANKSTRING(LOGINUSER.e_id) forKey:@"token_key"];
    }
    [parmas addEntriesFromDictionary:parameDic];
    
    RACSubject *subject = [RACSubject subject];
    [WHNetworking cacheGetRequest:NO shoulCachePost:NO];
    NSString *rsUrl = [NSString stringWithFormat:@"%@%@",LOGINUSER.url,url];
    [WHNetworking postWithUrl:rsUrl refreshCache:NO params:parmas success:^(id response) {
       
        if (AFSTATUS(response)==50 || AFSTATUS(response)==51) {
            [OMClass forceUserLogoutWithMessage:AFERRORMSG(response)];
        }else{
            [subject sendNext:response];
            [subject sendCompleted];
        }
    } fail:^(NSError *error) {
        [subject sendError:error];
        [subject sendCompleted];
    }];
    return subject;
}

+ (RACSignal*)postWithUrl:(NSString*)url parameDic:(NSDictionary*)parameDic cache:(BOOL)cache{
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    if (LOGINUSER.e_id.length>0) {
        [parmas setObject:@"" forKey:@"secret_key"];
        [parmas setObject:BLANKSTRING(LOGINUSER.e_id) forKey:@"token_key"];
    }
    [parmas addEntriesFromDictionary:parameDic];
    
    RACSubject *subject = [RACSubject subject];
    NSString *rsUrl = [NSString stringWithFormat:@"%@%@",LOGINUSER.url,url];
    [WHNetworking postWithUrl:rsUrl refreshCache:cache params:parmas success:^(id response) {
        if (AFSTATUS(response)==50 || AFSTATUS(response)==51) {
            [OMClass forceUserLogoutWithMessage:AFERRORMSG(response)];
        }else{
            [subject sendNext:response];
            [subject sendCompleted];
        }
    } fail:^(NSError *error) {
        [subject sendError:error];
        [subject sendCompleted];
    }];
    return subject;
}


@end
