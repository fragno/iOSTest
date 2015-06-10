//
//  CloudLocalFileHandle.m
//  WeiyunHD
//
//  Created by Rico on 13-1-17.
//  Copyright (c) 2013年 Tencent. All rights reserved.
//

#import "CloudLocalFileHandle.h"

@interface CloudLocalFileHandle ()

@property (nonatomic, strong) NSFileHandle *fileHandle;

@end

@implementation CloudLocalFileHandle

- (id)initWithPathForReading:(NSString *)path {
    self = [super init];
    
    if (self) {
        _fileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
        if (_fileHandle == nil) {
            return nil;
        }
    }
    
    return self;
}

- (id)initWithPathForWriting:(NSString *)path {
    self = [super init];
    
    if (self) {
        
        //temp handle start
        //TODO:压缩包里压缩文件里的文件下载下载失败，暂时这样处理，请rico完善
        NSString * dir = [path stringByDeletingLastPathComponent];
        
        //temp handle start
        
        
        NSError *error = nil;
        _fileHandle = [NSFileHandle fileHandleForWritingToURL:[NSURL fileURLWithPath:path] error:&error];
        if (_fileHandle == nil) {
            self.error = error;
            return nil;
        }
    }
    
    return self;
}

- (unsigned long long)offsetInFile {
    self.offset = [_fileHandle offsetInFile];
    return self.offset;
}

- (unsigned long long)seekToEndOfFile {
    self.offset = [_fileHandle seekToEndOfFile];
    return self.offset;
}

- (void)seekToFileOffset:(unsigned long long)offset {
    [super seekToFileOffset:offset];
    [_fileHandle seekToFileOffset:offset];
}

- (void)synchronizeFile {
    [_fileHandle synchronizeFile];
}

- (void)writeData:(NSData *)data {
    [_fileHandle writeData:data];
    self.offset += data.length;
}

- (NSData *)readDataOfLength:(NSUInteger)length {
    NSData *data = [_fileHandle readDataOfLength:length];
    self.offset += data.length;

    return data;
}

- (NSData *)readDataToEndOfFile {
    NSData *data = [_fileHandle readDataToEndOfFile];
    self.offset += data.length;
    
    return data;
}
@end





