
#import "CloudLRUCache.h"
#import "CloudRWLock.h"

#pragma mark - CloudLRUCacheEntry
@implementation CloudLRUCacheEntry

@end




#pragma mark - CloudLRUCache 
@interface CloudLRUCache ()

@property (nonatomic, strong) NSMutableArray *LRUArray;
@property (nonatomic, strong) NSMutableDictionary *cacheDict;

@property (nonatomic, strong) CloudRWLock *lock;

@end

@implementation CloudLRUCache
- (id)initWithCapacity:(NSInteger)capacity {
    self = [super init];
    
    _capacity = capacity;
    _burst = 4;
    
    _LRUArray = [[NSMutableArray alloc] init];
    _cacheDict = [[NSMutableDictionary alloc] init];
    
    _lock = [[CloudRWLock alloc] init];
    
    _defaultEntryTTL = -1;
    
    return self;
}


#pragma mark - API
- (void)setCapacity:(NSInteger)capacity {
    _capacity = capacity;
    
    [self evictEntry];
}

- (void)setBurst:(NSInteger)burst {
    _burst = burst;
    
    [self evictEntry];
}

- (void)cacheObject:(id)obj forKey:(id)key {
    assert(obj);
    assert(key);
    
    if (!obj
        || !key) {
        return;
    }
    
    [self.lock lockWrite];

    {
        if ([_cacheDict objectForKey:key]) {
            [self.lock unLockWrite];
            return;
        }
    }

    // 存在两种情况：
    // 1 obj 是 CloudLRUCacheEntry 的子类，将obj.key 设置后直接缓存
    // 2 obj 是 NSObject 的子类，需要新建 CloudLRUCacheEntry 后置入，才能缓存
    CloudLRUCacheEntry *entry = nil;
    if ([obj isKindOfClass:[CloudLRUCacheEntry class]]) {
        entry = obj;
        entry.key = key;
        entry.time = time(NULL);
        entry.bornTime = entry.time;
    }
    else {
        entry = [self encapEntryForObject:obj key:key];
    }
    
    // 正式缓存
    [_cacheDict setObject:entry forKey:entry.key];
    
    [self.lock unLockWrite];
    
    // 淘汰
    [self evictEntry];
}


- (id)objectForKey:(id)key {
    assert(key);
    
    [_lock lockRead];
    
    CloudLRUCacheEntry *entry = [_cacheDict objectForKey:key];
    
    // 调整 LRU
    time_t now = time(NULL);
    entry.time = now;

    [_lock unLockRead];
    
    if (self.defaultEntryTTL > 0
        && (entry.bornTime - now) > self.defaultEntryTTL) {
        [self removeObjectForKey:key];
        return nil;
    }
    else {
        return entry.value;
    }
}

- (void)removeObjectForKey:(id)key {
    [_lock lockWrite];
    CloudLRUCacheEntry *entry = [_cacheDict objectForKey:key];
    if (entry) {
        [_cacheDict removeObjectForKey:key];
        [_LRUArray removeObject:entry];
    }
    [_lock unLockWrite];
}

- (void)clear {
    [_lock lockWrite];
    [_cacheDict removeAllObjects];
    [_LRUArray removeAllObjects];
    [_lock unLockWrite];
}

#pragma mark - Internal Functions 
- (CloudLRUCacheEntry *)encapEntryForObject:(id)obj key:(id)key {
    CloudLRUCacheEntry *entry = [[CloudLRUCacheEntry alloc] init];
    entry.key = key;
    entry.value = obj;
    entry.time = time(NULL);
    entry.bornTime = entry.time;
    
    return entry;
}


/**
 * evictEntry
 * @brief 开始淘汰策略，目前淘汰所有超出能力范围的内容
 */
- (void)evictEntry {
    NSInteger burstCount = _capacity + (_capacity / _burst);
    if (_cacheDict.count <= burstCount) {
        return;
    }
    
    [_lock lockWrite];
    
    NSArray *valueArray = [_cacheDict allValues];
    NSArray *sortedArray = [valueArray sortedArrayUsingComparator:^NSComparisonResult(CloudLRUCacheEntry *entry1, CloudLRUCacheEntry *entry2) {
        if (entry1.time > entry2.time) {
            return NSOrderedAscending;
        }
        else {
            return NSOrderedDescending;
        }
    }];
    
    NSRange evictRange = {_capacity, sortedArray.count - _capacity};
    NSArray *evictArray = [sortedArray subarrayWithRange:evictRange];
    [_LRUArray removeObjectsInArray:evictArray];
    
    for (CloudLRUCacheEntry *entry in evictArray) {
        assert(entry.key);
        
        [_cacheDict removeObjectForKey:entry.key];
        
//        CloudLogDebug(kModuleNone, @"Evict cache entry for key %@", entry.key);
    }
    
    [_lock unLockWrite];
}

@end
