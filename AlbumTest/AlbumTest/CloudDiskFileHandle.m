//
//  CloudDiskFileHandle.m
//  WeiyunHD
//
//  Created by Rico on 13-1-17.
//  Copyright (c) 2013年 Tencent. All rights reserved.
//

#import "CloudDiskFileHandle.h"
#import <CommonCrypto/CommonDigest.h>

@implementation CloudDiskFileHandle

+ (CloudDiskFileHandle *)fileHandleForReadingAtPath:(NSString *)path {
    if (!path) {
        return nil;
    }
    
    Class handleClass = [CloudDiskFileHandle classForPath:path];
    if (handleClass) {
        return [[handleClass alloc] initWithPathForReading:path];
    }
    
    return nil;
}

+ (CloudDiskFileHandle *)fileHandleForWritingAtPath:(NSString *)path {
    if (!path) {
        return nil;
    }
    
    Class handleClass = [CloudDiskFileHandle classForPath:path];
    if (handleClass) {
        return [[handleClass alloc] initWithPathForWriting:path];
    }
    
    return nil;
}


+ (CloudDiskFileHandle *)fileHandleForReadingAtURL:(NSURL *)url {
    NSString *path = nil;
    
    if (url.isFileURL) {
        path = url.path;
    }
    else {
        path = url.absoluteString;
    }
    
    return [self fileHandleForReadingAtPath:path];
}

+ (CloudDiskFileHandle *)fileHandleForWritingAtURL:(NSURL *)url {
    NSString *path = nil;
    
    if (url.isFileURL) {
        path = url.path;
    }
    else {
        path = url.absoluteString;
    }
    
    return [self fileHandleForWritingAtPath:path];
}


+ (Class)classForPath:(NSString *)path {
    if ([path hasPrefix:@"assets-library://"]) {
        return NSClassFromString(@"CloudAssetFileHandle");
    }
    else {
        return NSClassFromString(@"CloudLocalFileHandle");
    }
}

- (id)initWithPathForReading:(NSString *)path {
    return self;
}

- (id)initWithPathForWriting:(NSString *)path {
    return self;
}

- (unsigned long long)offsetInFile {
    return _offset;
}

- (unsigned long long)seekToEndOfFile {
    return _offset;
}

- (void)seekToFileOffset:(unsigned long long)offset {
    _offset = offset;
}

- (void)synchronizeFile {
    
}

- (void)writeData:(NSData *)data {
    
}

- (NSData *)readDataOfLength:(NSUInteger)length {
    return nil;
}

- (NSData *)readDataToEndOfFile {
    return nil;
}



- (BOOL)calculateMD5:(NSString **)md5Str andSHA:(NSString **)shaStr
{
    BOOL calculateMD5 = (NULL != md5Str);
    BOOL calculateSHA = (NULL != shaStr);
    
    if (!calculateMD5 && !calculateSHA) {
        return YES;
    }
    
    unsigned long long originOffset = self.offset;
    
    [self seekToFileOffset:0];
    
    long long blockSize = BUF_SIZE_512K;
    
    CC_MD5_CTX md5;
    CC_SHA1_CTX sha;
    
    if (calculateMD5) {
        CC_MD5_Init(&md5);
    }
    
    if (calculateSHA) {
        CC_SHA1_Init(&sha);
    }
    
    BOOL done = NO;
    long long readLen = 0ll;
    while (!done) {
        @autoreleasepool {
            NSData *readData = [self readDataOfLength:blockSize];
            if (self.error) {
                [self seekToFileOffset:originOffset];
                return NO;
            }
            
            readLen += [readData length];
            if (readData.length < blockSize) {
                done = YES;
            }
            
            if (calculateMD5) {
                CC_MD5_Update(&md5, [readData bytes], [readData length]);
            }
            
            if (calculateSHA) {
                CC_SHA1_Update(&sha, [readData bytes], [readData length]);
            }
        }
    }
    
    if (calculateMD5) {
        unsigned char md5_res[CC_MD5_DIGEST_LENGTH];
        CC_MD5_Final(md5_res, &md5);
        *md5Str = [[NSString stringWithFormat: @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                    md5_res[0], md5_res[1],
                    md5_res[2], md5_res[3],
                    md5_res[4], md5_res[5],
                    md5_res[6], md5_res[7],
                    md5_res[8], md5_res[9],
                    md5_res[10], md5_res[11],
                    md5_res[12], md5_res[13],
                    md5_res[14], md5_res[15]] lowercaseString];
    }
    
    if (calculateSHA) {
        unsigned char sha_res[CC_SHA1_DIGEST_LENGTH];
        CC_SHA1_Final(sha_res, &sha);
        
        *shaStr = [[NSString stringWithFormat:
                    @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
                    sha_res[0], sha_res[1], sha_res[2], sha_res[3],
                    sha_res[4], sha_res[5], sha_res[6], sha_res[7],
                    sha_res[8], sha_res[9], sha_res[10], sha_res[11],
                    sha_res[12], sha_res[13], sha_res[14], sha_res[15],
                    sha_res[16], sha_res[17], sha_res[18], sha_res[19]
                    ] lowercaseString];
    }
    
    //返回到原来的offset
    [self seekToFileOffset:originOffset];
    
    return YES;
}

@end
