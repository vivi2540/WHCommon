//
//  WHStorageCache.h
//  XCSchool
//
//  Created by 何文虎 on 2019/8/31.
//  Copyright © 2019 小僵尸. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WHStorageCache : NSObject

+ (instancetype)sharedCache;


- (NSString *)fileCachePath;

- (BOOL)fileExistsWithName:(NSString *)fileName;

- (NSString *)saveFile:(NSData *)fileData withName:(NSString *)fileName;

- (NSString *)filePathWithName:(NSString *)fileName;

- (NSData *)fileDataWithFileName:(NSString *)fileName;

- (BOOL)deleteFileWithFileName:(NSString *)fileName;

- (BOOL)deleteFileWithFilePath:(NSString *)filePath;

- (void)deleteFileWithFilePathArray:(NSArray *)fileArray;

- (void)removeAllFiles;

- (long long)cacheFileSize;

@end



NS_ASSUME_NONNULL_END
