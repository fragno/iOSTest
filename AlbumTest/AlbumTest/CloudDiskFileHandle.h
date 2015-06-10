//
//  CloudDiskFileHandle.h
//  WeiyunHD
//
//  Created by Rico on 13-1-17.
//  Copyright (c) 2013年 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BUF_SIZE_1K (1024)
#define BUF_SIZE_32K (BUF_SIZE_1K * 32)
#define BUF_SIZE_64K (BUF_SIZE_1K * 64)
#define BUF_SIZE_128K (BUF_SIZE_1K * 128)
#define BUF_SIZE_512K (BUF_SIZE_1K * 512)
#define BUF_SIZE_1M (BUF_SIZE_1K * BUF_SIZE_1K)
#define BUF_SIZE_2M (BUF_SIZE_1K * BUF_SIZE_1K * 2)

@interface CloudDiskFileHandle : NSObject

@property (nonatomic, assign) unsigned long long offset;

@property (nonatomic, strong) NSError *error;

+ (CloudDiskFileHandle *)fileHandleForReadingAtPath:(NSString *)path;
+ (CloudDiskFileHandle *)fileHandleForWritingAtPath:(NSString *)path;

+ (CloudDiskFileHandle *)fileHandleForReadingAtURL:(NSURL *)url;
+ (CloudDiskFileHandle *)fileHandleForWritingAtURL:(NSURL *)url;

- (id)initWithPathForReading:(NSString *)path;
- (id)initWithPathForWriting:(NSString *)path;

- (unsigned long long)offsetInFile;
- (unsigned long long)seekToEndOfFile;
- (void)seekToFileOffset:(unsigned long long)offset;
- (void)synchronizeFile;
- (void)writeData:(NSData *)data;
- (NSData *)readDataOfLength:(NSUInteger)length;
- (NSData *)readDataToEndOfFile;

- (BOOL)calculateMD5:(NSString **)md5 andSHA:(NSString **)sha;

@end
