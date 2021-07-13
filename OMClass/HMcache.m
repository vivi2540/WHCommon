//
//  HMcache.m
//  HeadManage
//
//  Created by a111 on 17/1/16.
//  Copyright © 2017年 Tenghu. All rights reserved.
//

#import "HMcache.h"

@implementation HMcache

+ (id)objectForKey:(NSString *)key {
    
    if (!key) {
        return nil;
    }
    
    return [[NSUserDefaults standardUserDefaults]  objectForKey:key];
}


+ (id)objectOwnerUser{
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"hmuser.plist"];
    // 解档
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    return arr;

}

+ (void)setOwnerUserValue:(id)value {
    if (!value) {
        return ;
    }
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"hmuser.plist"];
    [value writeToFile:filePath atomically:YES];
}

+ (void)setObjectValue:(id)value forKey:(NSString *)key {
    
    if (!value || !key) {
        return ;
    }
    if ([value isEqual:[NSNull class]]|| [value isEqual:[NSNull null]] ) {
        value = @"";
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

+ (void)removeObjectForKey:(NSString *)key {
    
    if (!key) {
        return;
    }
   [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

//保存int
+(void)setInt:(NSInteger)i key:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setInteger:i forKey:key];
    
    //立即同步
    [defaults synchronize];
    
}

//读取
+(NSInteger)intForKey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    NSInteger i=[defaults integerForKey:key];
    
    return i;
}

//保存float
+(void)setFloat:(CGFloat)floatValue key:(NSString *)key{
    
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setFloat:floatValue forKey:key];
    
    //立即同步
    [defaults synchronize];
    
}
//读取
+(CGFloat)floatForKey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    CGFloat floatValue=[defaults floatForKey:key];
    
    return floatValue;
}


//保存bool
+(void)setBool:(BOOL)boolValue key:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存
    [defaults setBool:boolValue forKey:key];
    
    //立即同步
    [defaults synchronize];
    
}
//读取
+(BOOL)boolForKey:(NSString *)key{
    //获取preference
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //读取
    BOOL boolValue=[defaults boolForKey:key];
    
    return boolValue;
}




#pragma mark - 文件归档
//归档
+(BOOL)archiveRootObject:(id)obj toFile:(NSString *)path{
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:path];
    
    return [NSKeyedArchiver archiveRootObject:obj toFile:file];
}
//删除
+(BOOL)removeRootObjectWithFile:(NSString *)path{
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:path];

    return [self archiveRootObject:nil toFile:file];
}
//解档
+(id)unarchiveObjectWithFile:(NSString *)path{
    NSString *file = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:path];

    return [NSKeyedUnarchiver unarchiveObjectWithFile:file];
}




@end
