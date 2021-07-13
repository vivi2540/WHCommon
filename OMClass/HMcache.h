//
//  HMcache.h
//  HeadManage
//
//  Created by a111 on 17/1/16.
//  Copyright © 2017年 Tenghu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMcache : NSObject

// 读出
+ (id)objectForKey:(NSString *)key;
// 读出 hmuser
+ (id)objectOwnerUser;
// 写入
+ (void)setObjectValue:(id)value forKey:(NSString *)key;

// 写入hmuser
+ (void)setOwnerUserValue:(id)value ;

// 删除
+ (void)removeObjectForKey:(NSString *)key;

/**
 *  保存int
 */
+(void)setInt:(NSInteger)i key:(NSString *)key;

/**
 *  读取int
 */
+(NSInteger)intForKey:(NSString *)key;



/**
 *  保存float
 */
+(void)setFloat:(CGFloat)floatValue key:(NSString *)key;

/**
 *  读取float
 */
+(CGFloat)floatForKey:(NSString *)key;



/**
 *  保存bool
 */
+(void)setBool:(BOOL)boolValue key:(NSString *)key;

/**
 *  读取bool
 */
+(BOOL)boolForKey:(NSString *)key;


#pragma mark - 文件归档

/**
 *  归档
 */
+(BOOL)archiveRootObject:(id)obj toFile:(NSString *)path;
/**
 *  删除
 */
+(BOOL)removeRootObjectWithFile:(NSString *)path;

/**
 *  解档
 */
+(id)unarchiveObjectWithFile:(NSString *)path;



@end
