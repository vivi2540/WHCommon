//
//  WHCache.m
//  XCSchool
//
//  Created by 何文虎 on 2019/8/31.
//  Copyright © 2019 小僵尸. All rights reserved.
//

#import "WHCache.h"


@interface WHCache ()

@property (nonatomic, strong) YYCache *memoryCache;
@property (nonatomic, strong) YYDiskCache *diskCache;

@end

@implementation WHCache

+ (instancetype)sharedCache {
    static dispatch_once_t onceToken;
    static WHCache *__singleton__ = nil;
    dispatch_once(&onceToken, ^{
        __singleton__ = [[self alloc] initWithName:@"WHDiskCache"];
    });
    return __singleton__;
}

- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        self.memoryCache = [[YYCache alloc] initWithName:name];
    }
    return self;
}

- (BOOL)containsObjectForKey:(NSString *)key {
    return [self.memoryCache containsObjectForKey:key];
}

- (void)containsObjectForKey:(NSString *)key withBlock:( void(^)(NSString *key, BOOL contains))block {
    [self.memoryCache containsObjectForKey:key withBlock:block];
}

- (id)objectForKey:(NSString *)key {
    return [self.memoryCache objectForKey:key];
}

- (void)objectForKey:(NSString *)key withBlock:( void(^)(NSString *key, id<NSCoding> object))block {
    [self.memoryCache objectForKey:key withBlock:block];
}

- (void)setObject:( id<NSCoding>)object forKey:(NSString *)key {
    [self.memoryCache setObject:object forKey:key];
}

- (void)setObject:( id<NSCoding>)object forKey:(NSString *)key withBlock:( void(^)(void))block {
    [self.memoryCache setObject:object forKey:key withBlock:block];
}

- (void)removeObjectForKey:(NSString *)key {
    [self.memoryCache removeObjectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key withBlock:( void(^)(NSString *key))block {
    [self.memoryCache removeObjectForKey:key withBlock:block];
}

- (void)removeAllObjects {
    [self.memoryCache removeAllObjects];
}

- (void)removeAllObjectsWithBlock:(void(^)(void))block {
    [self.memoryCache removeAllObjectsWithBlock:block];
}

- (void)removeAllObjectsWithProgressBlock:( void(^)(int removedCount, int totalCount))progress
                                 endBlock:( void(^)(BOOL error))end {
    [self.memoryCache removeAllObjectsWithProgressBlock:progress endBlock:end];
}

@end

@interface WHDiskCache ()

@end

@implementation WHDiskCache

- (instancetype)initWithPath:(NSString *)path {
    if (self = [super init]) {
        _myDiskCache = [[YYDiskCache alloc] initWithPath:path];
    }
    return self;
}

+ (instancetype)sharedCache {
    static id cache;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"WHDiskCache"];
        cache = [[self alloc] initWithPath:cachePath];
    });
    return cache;
}

- (NSString *)path {
    return [self.myDiskCache.path stringByAppendingPathComponent:@"data"];
}

- (BOOL)containsObjectForKey:(NSString *)key {
    return [self.myDiskCache containsObjectForKey:key];
}

- (void)containsObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key, BOOL contains))block {
    [self.myDiskCache containsObjectForKey:key withBlock:block];
}

- (id<NSCoding>)objectForKey:(NSString *)key {
    return [self.myDiskCache objectForKey:key];
}

- (void)objectForKey:(NSString *)key withBlock:(void(^)(NSString *key, id<NSCoding> _Nullable object))block {
    [self.myDiskCache objectForKey:key withBlock:block];
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key {
    [self.myDiskCache setObject:object forKey:key];
}

- (void)setObject:(id<NSCoding>)object forKey:(NSString *)key withBlock:(void(^)(void))block {
    [self.myDiskCache setObject:object forKey:key withBlock:block];
}

- (void)removeObjectForKey:(NSString *)key {
    [self.myDiskCache removeObjectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key withBlock:(void(^)(NSString *key))block {
    [self.myDiskCache removeObjectForKey:key withBlock:block];
}

- (void)removeAllObjects {
    [self.myDiskCache removeAllObjects];
}

- (void)removeAllObjectsWithBlock:(void(^)(void))block {
    [self.myDiskCache removeAllObjectsWithBlock:block];
}

- (void)removeAllObjectsWithProgressBlock:(void(^)(int removedCount, int totalCount))progress
                                 endBlock:(void(^)(BOOL error))end {
    [self.myDiskCache removeAllObjectsWithProgressBlock:progress endBlock:end];
}

- (NSInteger)totalCount {
    return [self.myDiskCache totalCount];
}

- (void)totalCountWithBlock:(void(^)(NSInteger totalCount))block {
    [self.myDiskCache totalCountWithBlock:block];
}

- (NSInteger)totalCost {
    return [self.myDiskCache totalCost];
}

- (void)totalCostWithBlock:(void(^)(NSInteger totalCost))block {
    [self.myDiskCache totalCostWithBlock:block];
}

#pragma mark - Trim
- (void)trimToCount:(NSUInteger)count {
    [self.myDiskCache trimToCount:count];
}

- (void)trimToCount:(NSUInteger)count withBlock:(void(^)(void))block {
    [self.myDiskCache trimToCost:count withBlock:block];
}

- (void)trimToCost:(NSUInteger)cost {
    [self.myDiskCache trimToCost:cost];
}

- (void)trimToCost:(NSUInteger)cost withBlock:(void(^)(void))block {
    [self.myDiskCache trimToCost:cost withBlock:block];
}

- (void)trimToAge:(NSTimeInterval)age {
    [self.myDiskCache trimToAge:age];
}

- (void)trimToAge:(NSTimeInterval)age withBlock:(void(^)(void))block {
    [self.myDiskCache trimToAge:age withBlock:block];
}

#pragma mark - Extended Data
+ (NSData *)getExtendedDataFromObject:(id)object {
    return [YYDiskCache getExtendedDataFromObject:object];
}

+ (void)setExtendedData:(NSData *)extendedData toObject:(id)object {
    return [YYDiskCache setExtendedData:extendedData toObject:object];
}

@end

@interface WHMemoryCache ()

@end

@implementation WHMemoryCache

- (instancetype)init {
    if (self = [super init]) {
        _myMemoryCache = [[YYMemoryCache alloc] init];
    }
    return self;
}

+ (instancetype)sharedCache {
    static id cache;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        cache = [[self alloc] init];
    });
    return cache;
}

#pragma mark - Access Methods
- (BOOL)containsObjectForKey:(id)key {
    return [self.myMemoryCache containsObjectForKey:key];
}

- (id)objectForKey:(id)key {
    return [self.myMemoryCache objectForKey:key];
}

- (void)setObject:(id)object forKey:(id)key {
    [self.myMemoryCache setObject:object forKey:key];
}

- (void)setObject:(id)object forKey:(id)key withCost:(NSUInteger)cost {
    [self.myMemoryCache setObject:object forKey:key withCost:cost];
}

- (void)removeObjectForKey:(id)key {
    [self.myMemoryCache removeObjectForKey:key];
}

- (void)removeAllObjects {
    [self.myMemoryCache removeAllObjects];
}

#pragma mark - Trim
- (void)trimToCount:(NSUInteger)count {
    [self.myMemoryCache trimToCount:count];
}

- (void)trimToCost:(NSUInteger)cost {
    [self.myMemoryCache trimToCost:cost];
}

- (void)trimToAge:(NSTimeInterval)age {
    [self.myMemoryCache trimToAge:age];
}

@end
