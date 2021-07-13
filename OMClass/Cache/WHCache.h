//
//  WHCache.h
//  XCSchool
//
//  Created by 何文虎 on 2019/8/31.
//  Copyright © 2019 小僵尸. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHCache : NSObject

#pragma mark - Memory Cache

+ (instancetype)sharedCache;

- (BOOL)containsObjectForKey:(NSString *)key;
- (void)containsObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key, BOOL contains))block;
- (id)objectForKey:(NSString *)key;
- (void)objectForKey:(NSString *)key withBlock:(void(^)(NSString *key, id<NSCoding> object))block;
- (void)setObject:( id<NSCoding>)object forKey:(NSString *)key;
- (void)setObject:( id<NSCoding>)object forKey:(NSString *)key withBlock:( void(^)(void))block;
- (void)removeObjectForKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key withBlock:( void(^)(NSString *key))block;
- (void)removeAllObjects;
- (void)removeAllObjectsWithBlock:(void(^)(void))block;
- (void)removeAllObjectsWithProgressBlock:( void(^)(int removedCount, int totalCount))progress
                                 endBlock:( void(^)(BOOL error))end;

@end

@interface WHDiskCache : NSObject

@property (nonatomic, strong) YYDiskCache *myDiskCache;

@property (nonatomic, readonly) NSString *path;

+ (instancetype)sharedCache;

- (BOOL)containsObjectForKey:(NSString *)key;
- (void)containsObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key, BOOL contains))block;
- (id<NSCoding>)objectForKey:(NSString *)key;
- (void)objectForKey:(NSString *)key withBlock:(void(^)(NSString *key, id<NSCoding> object))block;
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key;
- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void(^)(void))block;
- (void)removeObjectForKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key))block;
- (void)removeAllObjects;
- (void)removeAllObjectsWithBlock:(void(^)(void))block;
- (void)removeAllObjectsWithProgressBlock:(void(^)(int removedCount, int totalCount))progress
                                 endBlock:(void(^)(BOOL error))end;
- (NSInteger)totalCount;
- (void)totalCountWithBlock:(void(^)(NSInteger totalCount))block;
- (NSInteger)totalCost;
- (void)totalCostWithBlock:(void(^)(NSInteger totalCost))block;
#pragma mark - Trim
- (void)trimToCount:(NSUInteger)count;
- (void)trimToCount:(NSUInteger)count withBlock:(void(^)(void))block;
- (void)trimToCost:(NSUInteger)cost;
- (void)trimToCost:(NSUInteger)cost withBlock:(void(^)(void))block;
- (void)trimToAge:(NSTimeInterval)age;
- (void)trimToAge:(NSTimeInterval)age withBlock:(void(^)(void))block;
#pragma mark - Extended Data
+ (NSData *)getExtendedDataFromObject:(id)object;
+ (void)setExtendedData:(NSData *)extendedData toObject:(id)object;

@end

@interface WHMemoryCache : NSObject

@property (nonatomic, strong) YYMemoryCache *myMemoryCache;

+ (instancetype)sharedCache;

#pragma mark - Access Methods
- (BOOL)containsObjectForKey:(id)key;
- (id)objectForKey:(id)key;
- (void)setObject:(id)object forKey:(id)key;
- (void)setObject:(id)object forKey:(id)key withCost:(NSUInteger)cost;
- (void)removeObjectForKey:(id)key;
- (void)removeAllObjects;
#pragma mark - Trim
- (void)trimToCount:(NSUInteger)count;
- (void)trimToCost:(NSUInteger)cost;
- (void)trimToAge:(NSTimeInterval)age;

@end


NS_ASSUME_NONNULL_END
