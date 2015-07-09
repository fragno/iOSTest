
#import <AssetsLibrary/AssetsLibrary.h>
#import "CloudAssetFileHandle.h"

@interface CloudAssetFileHandle ()

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, strong) ALAssetRepresentation *representation;
@property (nonatomic, strong) ALAssetsLibrary *library;

@property (atomic, assign) BOOL lock;
@property (nonatomic, strong) dispatch_semaphore_t sema;

@end

@implementation CloudAssetFileHandle

- (id)initWithPathForReading:(NSString *)path {
    self = [super init];
    
    if (self) {
        _sema = dispatch_semaphore_create(0);
        [self assetForPath:path];
    }
    
    return self;
}

- (id)initWithPathForWriting:(NSString *)path {
//    self = [super init];

    // Assets 不支持写入
    
    return nil;
}

- (void)dealloc {
    _sema = NULL;
}

- (ALAssetRepresentation *)representation {
    if (_representation == nil) {
        _representation = self.asset.defaultRepresentation;
    }
    
    return _representation;
}

- (unsigned long long)offsetInFile {
    return self.offset;
}

- (unsigned long long)seekToEndOfFile {
    [self waitForAsset];
    if (self.error) {
        return self.offset;
    }
    
    self.offset = [self.asset.defaultRepresentation size];
    return self.offset;
}

- (NSData *)readDataOfLength:(NSUInteger)length {
    [self waitForAsset];
    if (self.error) {
        return nil;
    }
    
    NSMutableData* data = [[NSMutableData alloc] initWithCapacity:length];
    void* buffer = malloc(length);
    if (!buffer) {
        return nil;
    }
    
    NSError *error = nil;
    if (self.representation == nil) {
        self.error = [NSError errorWithDomain:ALAssetsLibraryErrorDomain code:ALAssetsLibraryDataUnavailableError userInfo:nil];
        free(buffer);
        return nil;
    }
    
    NSUInteger readLen = [self.representation getBytes:buffer fromOffset:self.offset length:length error:&error];
    if (!readLen || error != nil) {
        if (error) {
            self.error = error;
        }
        else {
            self.error = [NSError errorWithDomain:ALAssetsLibraryErrorDomain code:ALAssetsLibraryDataUnavailableError userInfo:nil];
        }


    } else if (readLen > length) {
        self.error = [NSError errorWithDomain:ALAssetsLibraryErrorDomain code:ALAssetsLibraryDataUnavailableError userInfo:nil];
    }
    else {
        // 规避这个NSMallocException crash
        // -[NSConcreteMutableData appendBytes:length:]: unable to allocate memory for length (4294967295)
        @try {
            [data appendBytes:buffer length:readLen];
            self.offset += readLen;
        }
        @catch (NSException *exception) {
            self.error = [NSError errorWithDomain:ALAssetsLibraryErrorDomain code:ALAssetsLibraryDataUnavailableError userInfo:nil];
        }
    }
    
    free(buffer);
    return data;
}

#pragma mark Internal Functions
- (void)assetForPath:(NSString *)path;
{
    self.lock = YES;
    self.library = [[ALAssetsLibrary alloc] init];
    [self.library assetForURL:[NSURL URLWithString:path]
                  resultBlock:^(ALAsset *asset) {
                      self.asset = asset;
                      self.lock = NO;
                      
                      if (_sema) {
                          dispatch_semaphore_signal(self.sema);
                      }
                  }
                 failureBlock:^(NSError *error) {
                     self.asset = nil;
                     self.lock = NO;
                     self.error = error;
                     
                     if (_sema) {
                         dispatch_semaphore_signal(self.sema);
                     }
                 }];
}

- (void)waitForAsset {
    // 成功取得锁，说明 asset 获取已经完成。先释放锁，然后继续任务
    // 否则上锁等待，得到锁之后，立刻释放锁，然后继续
    if (self.lock == YES) {
        dispatch_semaphore_wait(self.sema, DISPATCH_TIME_FOREVER);
    }
}
@end




















