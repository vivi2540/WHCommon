//
//  WHStorageCache.m
//  XCSchool
//
//  Created by 何文虎 on 2019/8/31.
//  Copyright © 2019 小僵尸. All rights reserved.
//

#import "WHStorageCache.h"

@interface WHStorageCache ()

@property (nonatomic, strong) NSString *cachePath;

@end

@implementation WHStorageCache

+ (instancetype)sharedCache {
    static dispatch_once_t onceToken;
    static WHStorageCache *__singleton__ = nil;
    dispatch_once(&onceToken, ^{
        __singleton__ = [[self alloc] initWithName:@"WHDiskCache/WHCacheDatas"];
    });
    return __singleton__;
}

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:name];
        if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        self.cachePath = cachePath;
    }
    return self;
}

- (NSString *)cachePath {
    NSString *cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"WHDiskCache/WHCacheDatas"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return cachePath;
}

- (NSString *)fileCachePath {
    return [WHStorageCache sharedCache].cachePath;
}

- (NSString *)saveFile:(NSData *)fileData withName:(NSString *)fileName {
    NSString *filePath = [self.cachePath stringByAppendingPathComponent:fileName];
    [fileData writeToFile:filePath atomically:YES];
    return filePath;
}

- (BOOL)fileExistsWithName:(NSString *)fileName {
    NSString *filePath = [self.cachePath stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return YES;
    }
    return NO;
}

- (NSString *)filePathWithName:(NSString *)fileName {
    NSString *filePath = [self.cachePath stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return filePath;
    }
    return nil;
}

- (NSData *)fileDataWithFileName:(NSString *)fileName {
    NSString *filePath = [self.cachePath stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [[NSFileManager defaultManager] contentsAtPath:filePath];
    }
    return nil;
}

- (BOOL)deleteFileWithFileName:(NSString *)fileName {
    NSString *filePath = [self.cachePath stringByAppendingPathComponent:fileName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    return YES;
}

- (BOOL)deleteFileWithFilePath:(NSString *)filePath {
    if (filePath.length<=0) {
        return YES;
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        return [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    return YES;
}

- (void)deleteFileWithFilePathArray:(NSArray *)fileArray {
    if (fileArray.count == 0) {
        return;
    }
    for (NSString *filePath in fileArray) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        }
    }
}

- (void)removeAllFiles {
    NSLog(@"removeAllFiles");
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:[self fileCachePath] error:nil];
}

- (unsigned long long)fileSizeAtPath:(NSString *)filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

- (long long)cacheFileSize {
    NSFileManager* manager = [NSFileManager defaultManager];
    BOOL isDirectory;
    //    if (![manager fileExistsAtPath:[self fileCachePath]]) return 0;
    BOOL isDirExist = [manager fileExistsAtPath:[self fileCachePath] isDirectory:&isDirectory];
    if (!(isDirExist && isDirectory)){
        return 0;
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:[self fileCachePath]] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [[self fileCachePath] stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize;
}

@end

